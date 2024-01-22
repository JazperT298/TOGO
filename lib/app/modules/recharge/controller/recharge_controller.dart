import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/internet_products_model.dart';
import 'package:ibank/app/modules/login/alertdialog/login_alertdialog.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/app/modules/recharge/views/dialog/recharge_menu_dialog.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:xml/xml.dart' as xml;

class RechargeController extends GetxController {
  RxString screen = ''.obs;
  RxString selectedOption = ''.obs;
  InternetProducts? productSelected;
  RxString internetNumberCode = ''.obs;

  TextEditingController numberTextField = TextEditingController();
  TextEditingController amountTextField = TextEditingController();
  TextEditingController code = TextEditingController();

  RxList<InternetProducts> productsList = <InternetProducts>[].obs;

  logout() async {
    await Get.find<StorageServices>().storage.remove('msisdn').then((value) {
      Get.find<StorageServices>().storage.remove('isPrivacyCheck');
      Get.find<StorageServices>().storage.remove('isLoginSuccessClick');
      Get.offAllNamed(AppRoutes.LOGIN);
      Future.delayed(const Duration(seconds: 2), () {
        LoginAlertdialog.showMessageVersionNotUpToDate(
            controller: Get.find<LoginController>());
      });
    });
  }

  verifyAndroid({
    required String msisdn,
    required String amount,
    required String code,
  }) async {
    ProgressAlertDialog.progressAlertDialog(
        Get.context!, LocaleKeys.strLoading.tr);
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">$msisdn</msisdn>
          <message i:type="d:string">VRFY ANDROIDAPP ${Get.find<DevicePlatformServices>().deviceID} ANDROID 3.0.1.0 F</message>
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
        if (decodedData['description'] == 'TOKEN_FOUND') {
          if (selectedOption.value == "For myself") {
            await transactCreditForMyself(amount: amount, code: code);
          } else {
            await transactCreditForOthers(
                msisdn: msisdn, amount: amount, code: code);
          }
        } else if (decodedData['description'] == 'TOKEN_NOT_FOUND') {
          logout();
        } else if (decodedData['description'] == 'VERSION NOT UP TO DATE') {
          logout();
          // HomeAlertDialog.showMessageVersionNotUpToDate(controller: Get.find<HomeController>());
        } else {
          logout();
        }
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('verifyAndroid $e');
    }
  }

  transactCreditForMyself({
    required String amount,
    required String code,
  }) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">APPAIRT OWN $amount $code F</message>
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
      log('transactCredit $e');
    }
  }

  transactCreditForOthers({
    required String msisdn,
    required String amount,
    required String code,
  }) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">APPAIRT $msisdn $amount $code F</message>
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
      log('transactCredit $e');
    }
  }

  internetGetProducts() async {
    ProgressAlertDialog.progressAlertDialog(
        Get.context!, LocaleKeys.strLoading.tr);
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">GETAIRD ${internetNumberCode.value} F</message>
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
        // log(decodedData.toString());
        log(jsonEncode(decodedData));
        productsList
            .assignAll(internetProductsFromJson(jsonEncode(decodedData)));
        if (productsList.isNotEmpty) {
          productSelected = productsList[0];
        }
        Get.back();
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('verifyAndroid $e');
    }
  }
}
