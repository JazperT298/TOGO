import 'dart:convert';
import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/bill_payment_model.dart';
import 'package:ibank/app/data/models/ceet_products_model.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/login/alertdialog/login_alertdialog.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_enter_otp_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_inputs_bottom_sheet.dart';
import 'package:ibank/app/modules/recharge/views/dialog/recharge_menu_dialog.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class PaymentController extends GetxController {
  TextEditingController numberTextField = TextEditingController();
  TextEditingController amountTextField = TextEditingController();
  TextEditingController code = TextEditingController();

  RxList<CeetProducts> ceetProductList = <CeetProducts>[].obs;
  RxList<Datum> ceetDataList = <Datum>[].obs;

  RxString ceetPackageRadioGroupValue = ''.obs;

  RxString selectedOption = ''.obs;
  Datum? selectDatum;
  BillPayment? billPayment;
  List<WalletAction> walletChild = [];

  @override
  void onInit() {
    // TODO: implement onInit
    walletChild = [
      WalletAction(
        name: 'CEET',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.electricity,
      ),
      WalletAction(
        name: 'Cash Power',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.electricity,
      ),
      WalletAction(
        name: 'TDE',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.sun,
      ),
      WalletAction(
        name: 'Solergie',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.sun,
      ),
      WalletAction(
        name: 'BBox Cizo',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.wallet,
      ),
      WalletAction(
        name: 'Soleva',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.watch,
      ),
      WalletAction(
        name: 'Moon',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.moon,
      ),
    ];
    super.onInit();
  }

  verifyGetCeetLink() async {
    ProgressAlertDialog.progressAlertDialog(Get.context!, LocaleKeys.strLoading.tr);
    try {
      ceetProductList.clear();
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">VRFY GETCEETLINK F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">false</sendsms>
          </n0:RequestToken>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        var decodedData = jsonDecode(jsonString);
        log(decodedData.toString());

        log('verifyGetCeetLink 1 ${jsonEncode(decodedData)}');
        // var apiResponseMap = json.decode(decodedData);
        if (decodedData['description'] == 'SUCCESS') {
          if (selectedOption.value == "CEET") {
            Get.back();
            // PaymentInputsBottomSheet.showBottomSheetInputNumber();
            // CeetProducts apiResponse = CeetProducts.fromJson(json.decode(decodedData));

            ceetDataList.assignAll(CeetDataProductsFromJson(jsonEncode(decodedData['data']))); //<----
            // PaymentServiceLinksBottomSheet.showBottomSheetCeetServicePackageTo();
            PaymentInputsBottomSheet.showBottomSheetCeetInputNumber();
            // await transactVoiceRechargeOwn(msisdn: msisdn, code: code);
          } else {
            // await transactVoieRechargeOthers(msisdn: msisdn, code: code);
          }
        }
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('verifyGetCeetLink $e');
      Get.back();
      RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
    }
  }

  verifyCeetRefIDfromInput({required String refId}) async {
    ProgressAlertDialog.progressAlertDialog(Get.context!, LocaleKeys.strLoading.tr);
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">VRFY CEET $refId</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestToken>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString.toString());
        var decodedData = jsonDecode(jsonString);
        // log('verifyCeetRefIDfromInput 1 ${jsonEncode(decodedData)}');
        // print('STATUS ${decodedData['status']}');
        if (decodedData['status'] == '99') {
          Get.back();
          Get.snackbar("Message", decodedData['message'], backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else {
          Get.back();
          Get.back();
          billPayment = BillPayment.fromJson(decodedData);
          log(billPayment!.message[0].productname);
          PaymentEnterOtpBottomSheet.showBottomSheetOTPCEET();
        }
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      Get.back();
      log('verifyCeetRefIDfromInput $e');
      RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
    }
  }

  verifyCeetRefIDfromSaved() async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">VRFY CEET ${selectDatum!.reference}</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestToken>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString.toString());
        Get.back();
        Get.back();
        RechargeMenuDialog.showMessageDialog(message: jsonString);
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('transactInternetRechargeOwn $e');
    }
  }

  logout() async {
    await Get.find<StorageServices>().storage.remove('msisdn').then((value) {
      Get.find<StorageServices>().storage.remove('isPrivacyCheck');
      Get.find<StorageServices>().storage.remove('isLoginSuccessClick');
      Get.offAllNamed(AppRoutes.LOGIN);
      Future.delayed(const Duration(seconds: 2), () {
        LoginAlertdialog.showMessageVersionNotUpToDate(controller: Get.find<LoginController>());
      });
    });
  }
}
