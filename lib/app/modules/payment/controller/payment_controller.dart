// ignore_for_file: unnecessary_null_comparison, unused_local_variable, unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/bill_payment_model.dart';
import 'package:ibank/app/data/models/ceet_products_model.dart';
import 'package:ibank/app/data/models/transaction_fee.dart';
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
  RxString senderkeycosttotal = ''.obs;
  RxString senderkeycosttva = ''.obs;
  RxInt totalFess = 0.obs;
  RxInt totalAmount = 0.obs;
  DateTime? parsedDate;
  RxString extractedDate = ''.obs;

  RxList<CeetProducts> ceetProductList = <CeetProducts>[].obs;
  RxList<Datum> ceetDataList = <Datum>[].obs;

  RxString ceetPackageRadioGroupValue = ''.obs;
  RxString keyword = ''.obs;

  RxString selectedOption = ''.obs;
  Datum? selectDatum;
  BillPayment? billPayment;
  List<WalletAction> walletChild = [];
  RxString price = ''.obs;
  TransactionFee? transactionFee;
  RxString billType = 'APPBILL CEET'.obs;
  RxString billRef = ''.obs;

  RxString thisDsonString = ''.obs;
  RxString errorMessage = ''.obs;

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
    FullScreenLoading.fullScreenLoading();
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
      log('verifyGetCeetLink 1 ${request.body}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        var decodedData = jsonDecode(jsonString);
        log('verifyGetCeetLink 0 ${decodedData.toString()}');

        log('verifyGetCeetLink 1 ${jsonEncode(decodedData)}');
        // var apiResponseMap = json.decode(decodedData);
        if (decodedData['description'] == 'SUCCESS') {
          if (selectedOption.value == "CEET") {
            Get.back();
            Get.back();
            // PaymentInputsBottomSheet.showBottomSheetInputNumber();
            // CeetProducts apiResponse = CeetProducts.fromJson(json.decode(decodedData));

            ceetDataList.assignAll(CeetDataProductsFromJson(jsonEncode(decodedData['data']))); //<----
            // PaymentServiceLinksBottomSheet.showBottomSheetCeetServicePackageTo();
            PaymentInputsBottomSheet.showBottomSheetCeetInputNumber();
            // await transactVoiceRechargeOwn(msisdn: msisdn, code: code);
          }
        } else if (decodedData['description'] == 'DATA_NOT_FOUND') {
          // await transactVoieRechargeOthers(msisdn: msisdn, code: code);
          Get.back();
          Get.snackbar("Message", decodedData['message'], backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
        }
      } else {
        Get.back();
        log("ERROR ${response.reasonPhrase}'");
        Get.snackbar("Message", 'An Error Occured, Please try again later', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
      }
    } catch (e) {
      log('verifyGetCeetLink $e');
      Get.back();
      RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
    }
  }

  verifyCeetRefIDfromInput({required String refId}) async {
    FullScreenLoading.fullScreenLoading();
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
      log('verifyCeetRefIDfromInput 0 ${request.body}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('verifyCeetRefIDfromInput result 0 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log('verifyCeetRefIDfromInput jsonString 1 ${jsonString.toString()}');
        var decodedData = jsonDecode(jsonString);
        log('verifyCeetRefIDfromInput 2 decodedData ${decodedData.toString()}');

        if (decodedData['status'] == "0") {
          Get.back();
          billPayment = BillPayment.fromJson(decodedData);
          price.value = billPayment!.message[0].price;
          RegExp regExp = RegExp(r'\b(\d{8})\b');
          Match match = regExp.firstMatch(billPayment!.message[0].description)!;
          if (match != null) {
            extractedDate.value = match.group(1)!;
            log("Extracted date: ${extractedDate.value}");
            parsedDate = DateTime.parse(extractedDate.value);
          }
          getTransactionFee(selectedOption.value, price.value, 'APPBILL');
        } else if (decodedData['status'] == "99") {
          Get.back();
          Get.snackbar("Message", 'Reference unavailable, please try again later', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else if ((decodedData['status'] == "98")) {
          Get.back();
          Get.snackbar("Message", 'No pending bills. ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else {
          Get.back();
          Get.snackbar("Message", 'Service unavailable, pelase try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
      } else {
        log("ERROR verifyCeetRefIDfromInput ${response.reasonPhrase}");
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
        log("ERROR verifyCeetRefIDfromSaved ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('transactInternetRechargeOwn $e');
    }
  }

  getTransactionFee(String destmsisdn, String price, String keywords) async {
    FullScreenLoading.fullScreenLoading();
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:getTransactionFee xmlns:n0="http://applicationmanager.tlc.com">
              <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
              <destmsisdn i:type="d:string">$destmsisdn</destmsisdn>
              <keyword i:type="d:string">$keywords</keyword>
              <value i:type="d:string">$price</value>
          </n0:getTransactionFee>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('getTransactionFeeReturn').single;
        var jsonString = soapElement.innerText;
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        transactionFee = TransactionFee.fromJson(jsonData);
        senderkeycosttotal.value = transactionFee!.senderkeycosttotal;
        senderkeycosttva.value = transactionFee!.senderkeycosttva;
        totalFess.value = int.parse(senderkeycosttotal.value.replaceAll(',', '')) - int.parse(senderkeycosttva.value.replaceAll(',', ''));
        totalAmount.value = int.parse(price) + int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        Get.back();
        Get.back();
        PaymentEnterOtpBottomSheet.showBottomSheetOTPCEET();
      } else {
        Get.back();
        log("ERROR getTransactionFee ${response.reasonPhrase}");
        RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
      }
    } catch (e) {
      Get.back();
      log('getTransactionFee $e');
      RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
    }
  }

  sentBillPaymentRequest(String billType, String billRef, String pice, String password) async {
    FullScreenLoading.fullScreenLoading();
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
            <n0:RequestTokenJson xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">$billType $billRef $price $password F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      log('request.body  ${request.body}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('result  $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        var decodedData = jsonDecode(jsonString);
        log('jsonString  $jsonString');
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        log('jsonData  $jsonData');
        //60001
        if (decodedData['msgid'] == 0) {
          Get.back();
          thisDsonString.value = jsonString;
          Get.toNamed(AppRoutes.PAYMENTSUCCESS);
        } else if (decodedData['msgid'] == 5) {
          Get.back();
          errorMessage.value = decodedData['message'];
          Get.snackbar("Message", decodedData['message'], backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
        } else {
          Get.back();
          errorMessage.value = decodedData['message'];
          Get.toNamed(AppRoutes.PAYMENTFAILED);
        }
        // transactionFee = TransactionFee.fromJson(jsonData);
        // senderkeycosttotal.value = transactionFee!.senderkeycosttotal;
        // senderkeycosttva.value = transactionFee!.senderkeycosttva;
        // totalFess.value = int.parse(senderkeycosttotal.value.replaceAll(',', '')) - int.parse(senderkeycosttva.value.replaceAll(',', ''));
        // totalAmount.value = int.parse(price) + int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        // PaymentEnterOtpBottomSheet.showBottomSheetOTPCEET();
      } else {
        Get.back();
        log("ERROR getTransactionFee ${response.reasonPhrase}");
        RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
      }
    } catch (e) {
      Get.back();
      log('getTransactionFee $e');
      RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
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
