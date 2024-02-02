// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/internet_products_model.dart';
import 'package:ibank/app/data/models/voice_products_model.dart';
import 'package:ibank/app/modules/login/alertdialog/login_alertdialog.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/app/modules/recharge/views/dialog/recharge_menu_dialog.dart';
import 'package:ibank/app/modules/recharge/views/modals/recharge_internet_otp_bottom_sheet.dart';
import 'package:ibank/app/modules/recharge/views/modals/recharge_voice_otp_bottom_sheet.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:xml/xml.dart' as xml;

import '../../../components/main_loading.dart';
import '../../../data/models/transaction_fee.dart';
import '../views/modals/recharge_credit_otp_bottom_sheet.dart';
import '../views/modals/recharge_internet_menu_bottom_sheet.dart';

class RechargeController extends GetxController {
  RxString screen = ''.obs;
  RxString selectedOption = ''.obs;
  RxString internetNumberCode = ''.obs;
  RxString internetProductType = 'All'.obs;
  RxString internetRadioGroupValue = ''.obs;
  RxString senderkeycosttotal = ''.obs;
  RxString senderkeycosttva = ''.obs;
  RxInt totalFess = 0.obs;
  RxInt totalAmount = 0.obs;
  RxString transactionID = ''.obs;
  RxString senderBalance = ''.obs;
  RxString responsemessage = ''.obs;

  RxString voicePackageNumberCode = ''.obs;
  RxString voicePackageHVCNumberCode = ''.obs;
  RxString voicePackageProductType = 'All'.obs;
  RxString voicePackageRadioGroupValue = ''.obs;

  TextEditingController numberTextField = TextEditingController();
  TextEditingController amountTextField = TextEditingController();
  TextEditingController code = TextEditingController();

  RxList<InternetProducts> productsList = <InternetProducts>[].obs;
  RxList<InternetProducts> productsMasterList = <InternetProducts>[].obs;

  RxList<VoiceProducts> voiceProdList = <VoiceProducts>[].obs;
  RxList<VoiceProducts> voiceProdMasterList = <VoiceProducts>[].obs;

  InternetProducts? selectedProduct;
  VoiceProducts? selectedVoice;

  RxString thisHsonString = ''.obs;

  logout({required String response}) async {
    await Get.find<StorageServices>().storage.remove('msisdn').then((value) {
      // Get.find<StorageServices>().storage.remove('isPrivacyCheck');
      Get.find<StorageServices>().storage.remove('isLoginSuccessClick');
      Get.find<StorageServices>().clearUserLocalData();
      Get.find<StorageServices>().clearUsersInformation();
      Get.offAllNamed(AppRoutes.LOGIN);
      if (response == 'VERSION NOT UP TO DATE') {
        Future.delayed(const Duration(seconds: 2), () {
          LoginAlertdialog.showMessageVersionNotUpToDate(controller: Get.find<LoginController>());
        });
      }
    });
  }

  verifyAndroidCredit({
    required String msisdn,
    required String amount,
    required String code,
  }) async {
    FullScreenLoading.fullScreenLoadingWithText('Sending request. Please wait. . .');
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
          <message i:type="d:string">VRFY ${Get.find<DevicePlatformServices>().channelID} ${Get.find<DevicePlatformServices>().deviceID} ${Get.find<DevicePlatformServices>().deviceType} 3.0.1.0 F</message>
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
            await transactCreditForOthers(msisdn: msisdn, amount: amount, code: code);
          }
        } else if (decodedData['description'] == 'TOKEN_NOT_FOUND') {
          logout(response: 'TOKEN_NOT_FOUND');
        } else if (decodedData['description'] == 'VERSION NOT UP TO DATE') {
          logout(response: 'VERSION NOT UP TO DATE');
          // HomeAlertDialog.showMessageVersionNotUpToDate(controller: Get.find<HomeController>());
        } else {
          logout(response: '');
        }
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('verifyAndroidCredit $e');
    }
  }

  getCreditTransactionFee({required String amounts}) async {
    FullScreenLoading.fullScreenLoadingWithText('Validating request. . .');
    // await getMsisdnDetails(); // GET MSISDN DETAILS
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
            <soapenv:Header/>
            <soapenv:Body>
                <app:getTransactionFee soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                  <msisdn xsi:type="xsd:string">${AppGlobal.MSISDN}</msisdn>
                  <destmsisdn xsi:type="xsd:string">AIRT</destmsisdn>
                  <keyword xsi:type="xsd:string">APPAIRT</keyword>
                  <value xsi:type="xsd:string">$amounts</value>
                </app:getTransactionFee>
            </soapenv:Body>
          </soapenv:Envelope>''';
      log('getTransactionFee ${request.body}');
      http.StreamedResponse response = await request.send();
      request.headers.addAll(headers);
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('getTransactionFeeReturn').single;
        var jsonString = soapElement.innerText;
        log('getTransactionFee jsonString 2 $jsonString');

        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        TransactionFee transactionFee = TransactionFee.fromJson(jsonData);
        senderkeycosttotal.value = transactionFee.senderkeycosttotal;
        senderkeycosttva.value = transactionFee.senderkeycosttva;
        totalFess.value = int.parse(senderkeycosttotal.value.replaceAll(',', '')) - int.parse(senderkeycosttva.value.replaceAll(',', ''));
        totalAmount.value = int.parse(amounts) + int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        Get.back();
        Get.back();
        RechargeCreditOTPBottomSheet.showBottomSheetOTP();
      }
    } catch (e) {
      log('getCreditTransactionFee asd $e');
      Get.back();
      Get.snackbar("Message", 'An Error Occured, Please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);

      // showMessageDialog(message: e.toString());
    }
  }

  getInternetAndVoiceTransactionFee({required String amounts, required String from}) async {
    FullScreenLoading.fullScreenLoadingWithText('Validating request. . .');
    // await getMsisdnDetails(); // GET MSISDN DETAILS
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
            <soapenv:Header/>
            <soapenv:Body>
                <app:getTransactionFee soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                  <msisdn xsi:type="xsd:string">${AppGlobal.MSISDN}</msisdn>
                  <destmsisdn xsi:type="xsd:string">FORFAIT_FLOOZ</destmsisdn>
                  <keyword xsi:type="xsd:string">APPAIRD</keyword>
                  <value xsi:type="xsd:string">$amounts</value>
                </app:getTransactionFee>
            </soapenv:Body>
          </soapenv:Envelope>''';
      log('getTransactionFee ${request.body}');
      http.StreamedResponse response = await request.send();
      request.headers.addAll(headers);
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('getTransactionFeeReturn').single;
        var jsonString = soapElement.innerText;
        log('getTransactionFee jsonString 2 $jsonString');

        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        TransactionFee transactionFee = TransactionFee.fromJson(jsonData);
        senderkeycosttotal.value = transactionFee.senderkeycosttotal;
        senderkeycosttva.value = transactionFee.senderkeycosttva;
        totalFess.value = int.parse(senderkeycosttotal.value.replaceAll(',', '')) - int.parse(senderkeycosttva.value.replaceAll(',', ''));
        totalAmount.value = int.parse(amounts) + int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        Get.back();
        Get.back();
        if (from == "internet") {
          RechargeInternetOTPBottomSheet.showBottomSheetOTP();
        } else {
          RechargeVoiceOTPBottomSheet.showBottomSheetOTP();
        }
      }
    } catch (e) {
      log('getInternetAndVoiceTransactionFee asd $e');
      Get.back();
      Get.snackbar("Message", 'An Error Occured, Please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);

      // showMessageDialog(message: e.toString());
    }
  }

  transactCreditForMyself({
    required String amount,
    required String code,
  }) async {
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
          <message i:type="d:string">APPAIRT OWN $amount $code F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString.toString());
        thisHsonString.value = jsonString;

        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        responsemessage.value = jsonData['message'];
        Get.back();
        Get.back();
        int msgId = jsonData["msgid"];
        if (msgId == 0) {
          transactionID.value = jsonData['refid'];
          senderBalance.value = jsonData['senderbalance'];
          // RechargeMenuDialog.showMessageDialog(message: jsonString);
          Get.toNamed(AppRoutes.RECHARGESUCCESS);
        } else {
          log("ERROR transactCreditForMyself ${response.reasonPhrase}'");
          Get.toNamed(AppRoutes.RECHARGEFAILED);
        }
      } else {
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      log('transactInternetRechargeOwn $e');
      Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
    }
  }

  transactCreditForOthers({
    required String msisdn,
    required String amount,
    required String code,
  }) async {
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
          <message i:type="d:string">APPAIRT $msisdn $amount $code F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        log('transactCreditForOthers JSON ${jsonString.toString()}');
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        responsemessage.value = jsonData['message'];
        Get.back();
        Get.back();
        int msgId = jsonData["msgid"];
        if (msgId == 0) {
          transactionID.value = jsonData['refid'];
          senderBalance.value = jsonData['senderbalance'];
          Get.toNamed(AppRoutes.RECHARGESUCCESS);
        } else {
          log("ERROR transactCreditForOthers ${response.reasonPhrase}'");
          Get.toNamed(AppRoutes.RECHARGEFAILED);
        }
      } else {
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      log('transactInternetRechargeOwn $e');
      Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
    }
  }

  internetGetProducts() async {
    FullScreenLoading.fullScreenLoadingWithText('Processing. Please wait. . .');
    try {
      productsList.clear();
      productsMasterList.clear();
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
        log(jsonEncode(decodedData));
        Get.back();
        productsList.assignAll(internetProductsFromJson(jsonEncode(decodedData)));
        productsMasterList.assignAll(internetProductsFromJson(jsonEncode(decodedData)));
        RechargeInternetMainMenuBottomSheet.showBottomSheetRechargeInternetTo();
      } else {
        log("ERROR internetGetProducts ${response.reasonPhrase}'");
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      // RechargeMenuDialog.showMessageDialog(message: "There are no available packages. Please try again later.");
      Get.snackbar("Message", 'An Error Occured, Please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);

      log('internetGetProducts $e');
    }
  }

  voicePackageGetProducts() async {
    FullScreenLoading.fullScreenLoadingWithText('Processing. Please wait. . .');
    try {
      voiceProdList.clear();
      voiceProdMasterList.clear();
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
          <message i:type="d:string">GETAIRD ${voicePackageNumberCode.value} F</message>
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

        log('VOICE ${jsonEncode(decodedData)}');

        Get.back();
        voiceProdList.assignAll(VoiceProductsFromJson(jsonEncode(decodedData)));
        voiceProdList.sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
        voiceProdMasterList.assignAll(VoiceProductsFromJson(jsonEncode(decodedData)));
        voiceProdMasterList.sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));

        RechargeInternetMainMenuBottomSheet.showBottomSheetRechargeVoicePackageTo();
      } else {
        log("ERROR  voicePackageGetProducts ${response.reasonPhrase}'");
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      // RechargeMenuDialog.showMessageDialog(message: "There are no available packages. Please try again later.");
      Get.snackbar("Message", 'An Error Occured, Please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);

      log('voicePackageGetProducts $e');
    }
  }

  voicePackageGetHVCProducts() async {
    // ProgressAlertDialog.progressAlertDialog(Get.context!, LocaleKeys.strLoading.tr);
    try {
      voiceProdList.clear();
      voiceProdMasterList.clear();
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
          <message i:type="d:string">GETAIRD ${voicePackageHVCNumberCode.value} F</message>
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

        log('VOICE HVC ${jsonEncode(decodedData)}');
        // Convert JSON to List<Map<String, dynamic>>
        List<Map<String, dynamic>> responseList = jsonDecode(decodedData);
        // Sort the list based on the "amount" field in ascending order
        responseList.sort((a, b) => a['price'].compareTo(b['price']));

        String sortedJsonResponse = jsonEncode(responseList);

        voiceProdList.assignAll(VoiceProductsFromJson(jsonEncode(sortedJsonResponse)));
        voiceProdMasterList.assignAll(VoiceProductsFromJson(jsonEncode(sortedJsonResponse)));
      } else {
        log("ERROR ${response.reasonPhrase}'");
        Get.snackbar("Message", 'Service unavailable, please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } catch (e) {
      // Get.back();
      // RechargeMenuDialog.showMessageDialog(message: "There are no available packages. Please try again later.");
      Get.snackbar("Message", 'An Error Occured, Please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);

      log('voicePackageGetProducts $e');
    }
  }

  verifyAndroidInternet({
    required String msisdn,
    required String code,
  }) async {
    FullScreenLoading.fullScreenLoadingWithText('Sending request. Please wait. . .');
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
          <message i:type="d:string">VRFY ${Get.find<DevicePlatformServices>().channelID} ${Get.find<DevicePlatformServices>().deviceID} ${Get.find<DevicePlatformServices>().deviceType} 3.0.1.0 F</message>
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
            await transactInternetRechargeOwn(msisdn: msisdn, code: code);
          } else {
            await transactInternetRechargeOthers(msisdn: msisdn, code: code);
          }
        } else if (decodedData['description'] == 'TOKEN_NOT_FOUND') {
          logout(response: 'TOKEN_NOT_FOUND');
        } else if (decodedData['description'] == 'VERSION NOT UP TO DATE') {
          logout(response: 'VERSION NOT UP TO DATE');
          // HomeAlertDialog.showMessageVersionNotUpToDate(controller: Get.find<HomeController>());
        } else {
          logout(response: '');
        }
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('verifyAndroidInternet $e');
    }
  }

  verifyAndroidVoice({
    required String msisdn,
    required String code,
  }) async {
    FullScreenLoading.fullScreenLoadingWithText('Sending request. Please wait. . .');
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
          <message i:type="d:string">VRFY ${Get.find<DevicePlatformServices>().channelID} ${Get.find<DevicePlatformServices>().deviceID} ${Get.find<DevicePlatformServices>().deviceType} 3.0.1.0 F</message>
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
            await transactVoiceRechargeOwn(msisdn: msisdn, code: code);
          } else {
            await transactVoieRechargeOthers(msisdn: msisdn, code: code);
          }
        } else if (decodedData['description'] == 'TOKEN_NOT_FOUND') {
          logout(response: 'TOKEN_NOT_FOUND');
        } else if (decodedData['description'] == 'VERSION NOT UP TO DATE') {
          logout(response: 'VERSION NOT UP TO DATE');
          // HomeAlertDialog.showMessageVersionNotUpToDate(controller: Get.find<HomeController>());
        } else {
          logout(response: '');
        }
      } else {
        Get.back();
        log("ERROR verifyAndroidVoice ${response.reasonPhrase}'");
        Get.snackbar("Message", 'Service unavailable, please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      log('verifyAndroidInternet $e');
      Get.snackbar("Message", 'An Error Occured, Please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
    }
  }

  transactInternetRechargeOwn({
    required String msisdn,
    required String code,
  }) async {
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
          <message i:type="d:string">APPAIRD OWN ${selectedProduct!.productid} $code F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString.toString());
        thisHsonString.value = jsonString;
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        responsemessage.value = jsonData['message'];
        Get.back();
        Get.back();
        int msgId = jsonData["msgid"];
        if (msgId == 0) {
          transactionID.value = jsonData['refid'];
          senderBalance.value = jsonData['senderbalance'];
          Get.toNamed(AppRoutes.RECHARGESUCCESS);
        } else {
          Get.back();
          log("ERROR ${response.reasonPhrase}'");
          Get.toNamed(AppRoutes.RECHARGEFAILED);
        }
      } else {
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
      }
    } catch (e) {
      log('transactInternetRechargeOwn $e');
      Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
    }
  }

  transactVoiceRechargeOwn({
    required String msisdn,
    required String code,
  }) async {
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
          <message i:type="d:string">APPAIRD OWN ${selectedVoice!.productid} $code F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      log('selectedVoice!.productid transactVoiceRechargeOwn ${selectedVoice!.productid}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString.toString());
        thisHsonString.value = jsonString;
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        responsemessage.value = jsonData['message'];
        Get.back();
        Get.back();
        int msgId = jsonData["msgid"];
        if (msgId == 0) {
          transactionID.value = jsonData['refid'];
          senderBalance.value = jsonData['senderbalance'];
          Get.toNamed(AppRoutes.RECHARGESUCCESS);
        } else {
          Get.back();
          log("ERROR ${response.reasonPhrase}'");
          Get.toNamed(AppRoutes.RECHARGEFAILED);
        }
      } else {
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      log('transactInternetRechargeOwn $e');
      Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
    }
  }

  transactInternetRechargeOthers({
    required String msisdn,
    required String code,
  }) async {
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
          <message i:type="d:string">APPAIRD OTHER $msisdn ${selectedProduct!.productid} $code F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        log('transactInternetRechargeOthers ${jsonString.toString()}');
        thisHsonString.value = jsonString;
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        responsemessage.value = jsonData['message'];
        Get.back();
        Get.back();
        int msgId = jsonData["msgid"];
        if (msgId == 0) {
          transactionID.value = jsonData['refid'];
          senderBalance.value = jsonData['senderbalance'];
          Get.toNamed(AppRoutes.RECHARGESUCCESS);
        } else {
          Get.back();
          log("ERROR ${response.reasonPhrase}'");
          Get.toNamed(AppRoutes.RECHARGEFAILED);
        }
      } else {
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      log('transactInternetRechargeOthers $e');
      Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
    }
  }

  transactVoieRechargeOthers({
    required String msisdn,
    required String code,
  }) async {
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
          <message i:type="d:string">APPAIRD OTHER $msisdn ${selectedVoice!.productid} $code F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestToken>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      log('transactVoieRechargeOthers ${selectedVoice!.productid}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString.toString());
        thisHsonString.value = jsonString;
        log('transactInternetRechargeOthers ${jsonString.toString()}');
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        responsemessage.value = jsonData['message'];
        Get.back();
        Get.back();
        int msgId = jsonData["msgid"];
        if (msgId == 0) {
          transactionID.value = jsonData['refid'];
          senderBalance.value = jsonData['senderbalance'];
          Get.toNamed(AppRoutes.RECHARGESUCCESS);
        } else {
          Get.back();
          log("ERROR ${response.reasonPhrase}'");
          Get.toNamed(AppRoutes.RECHARGEFAILED);
        }
      } else {
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
      }
    } catch (e) {
      log('transactVoieRechargeOthers $e');
      Get.snackbar("Message", 'Service unavailable, please try again later.', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
    }
  }

  changeInternetProductType() async {
    productsList.clear();
    List eco = ["1", "2", "3", "4", "34", "35"];
    List intense = ["5", "6", "7", "36", "37"];
    List nights = ["11", "12", "13"];

    if (internetProductType.value == "Eco") {
      for (var i = 0; i < productsMasterList.length; i++) {
        if (eco.contains(productsMasterList[i].productid.trim().toString())) {
          productsList.add(productsMasterList[i]);
        }
      }
    } else if (internetProductType.value == "Intense") {
      for (var i = 0; i < productsMasterList.length; i++) {
        if (intense.contains(productsMasterList[i].productid.trim().toString())) {
          productsList.add(productsMasterList[i]);
        }
      }
    } else if (internetProductType.value == "Nights") {
      for (var i = 0; i < productsMasterList.length; i++) {
        if (nights.contains(productsMasterList[i].productid.trim().toString())) {
          productsList.add(productsMasterList[i]);
        }
      }
    } else {
      productsList.assignAll(productsMasterList);
    }
  }

  changeVoiceProductType() async {
    voiceProdList.clear();
    List mixes = ["23", "24", "25", "26", "27", "28", "50", "51", "53", "60"];
    List voice = ["52", "54", "55", "56", "57", "58", "59", "61", "70", "71"];
    List promo = ["8", "38", "62", "63", "64", "65", "66", "67", "68", "69"];
    List hvc = ["39", "40", "41", "42"];

    if (voicePackageProductType.value == "Mixes") {
      for (var i = 0; i < voiceProdMasterList.length; i++) {
        if (mixes.contains(voiceProdMasterList[i].productid.trim().toString())) {
          voiceProdList.add(voiceProdMasterList[i]);
        }
      }
    } else if (voicePackageProductType.value == "Voice") {
      for (var i = 0; i < voiceProdMasterList.length; i++) {
        if (voice.contains(voiceProdMasterList[i].productid.trim().toString())) {
          voiceProdList.add(voiceProdMasterList[i]);
        }
      }
    } else if (voicePackageProductType.value == "Promo") {
      for (var i = 0; i < voiceProdMasterList.length; i++) {
        if (promo.contains(voiceProdMasterList[i].productid.trim().toString())) {
          voiceProdList.add(voiceProdMasterList[i]);
        }
      }
    } else if (voicePackageProductType.value == "HVC") {
      for (var i = 0; i < voiceProdMasterList.length; i++) {
        if (hvc.contains(voiceProdMasterList[i].productid.trim().toString())) {
          voiceProdList.add(voiceProdMasterList[i]);
        }
      }
    } else {
      voiceProdList.assignAll(voiceProdMasterList);
    }
  }

  String textSplitterPackageName({required String text}) {
    if (text.contains("(") || text.contains(")")) {
      var newtext = text.split("(")[0].replaceAll(")", "").trim().toString();
      return newtext;
    } else {
      return text;
    }
  }

  String textSplitterPrice({required String text}) {
    if (text.contains("(") || text.contains(")")) {
      var newtext = text.split("(")[1].replaceAll(")", "").trim().toString();
      return newtext;
    } else {
      return text;
    }
  }
}
