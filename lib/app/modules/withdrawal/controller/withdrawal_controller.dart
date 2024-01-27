// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/transaction_fee.dart';
import 'package:ibank/app/modules/recharge/views/dialog/recharge_menu_dialog.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_input_bottom_sheet.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_otp_bottom_sheet.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:developer';

import '../../../routes/app_routes.dart';

class WithdrawalController extends GetxController {
  RxString nickname = ''.obs;
  RxString amount = ''.obs;
  RxString refID = ''.obs;
  RxString fees = ''.obs;
  RxString taf = ''.obs;
  RxString balance = ''.obs;
  RxString withdrawalAmountWithUnit = ''.obs;
  String message = '';
  RxString internetRadioGroupValue = ''.obs;
  RxString selectedBank = ''.obs;
  RxBool isLoading = true.obs;

  static TransactionFee? transactionFee;

  TextEditingController code = TextEditingController();

  getBack() {
    Get.back();
    Get.back();
    Get.back();
  }

  addPendingCashout() async {
    var headers = {'Content-Type': 'application/xml'};
    var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
    request.body =
        '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
   <soapenv:Header/>
   <soapenv:Body>
      <app:RequestToken soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <msisdn xsi:type="xsd:string">22899990507</msisdn>
         <message xsi:type="xsd:string">AGNTI ${AppGlobal.MSISDN} 500 9999 F</message>
         <token xsi:type="xsd:string">1234567890</token>
         <sendsms xsi:type="xsd:string">true</sendsms>
      </app:RequestToken>
   </soapenv:Body>
</soapenv:Envelope>''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var parseResult = "'''$result'''";
      var document = xml.XmlDocument.parse(parseResult);
      var soapElement = document.findAllElements('RequestTokenReturn').single;
      var jsonString = soapElement.innerText;
      log(jsonString);
      // var jsonResponse = jsonDecode(jsonString);
      // print('JSON Response: $jsonResponse');
    } else {
      print(response.reasonPhrase);
    }
  }

  checkPendingCashout() async {
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
      <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
      <message i:type="d:string">AGNTGET F</message>
      <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
      <sendsms i:type="d:string">false</sendsms>
      </n0:RequestToken></v:Body>
      </v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString);
        var decodedData = jsonDecode(jsonString);
        // Map<String, dynamic> jsonData = jsonDecode(jsonString);
        // String msgId = jsonData["status"];

        if (decodedData['status'] == "0") {
          nickname.value = decodedData['nickname'];
          amount.value = decodedData['amount'];
          refID.value = decodedData['refid'];
          log('amount.value  ${amount.value}');
          log('nickname.value  ${nickname.value}');
          log('refID.value  ${refID.value}');
          Get.back();
          // WithdrawInputBottomSheet.showBottomSheetInputNumber();
          getTransactionFee(decodedData['nickname'], decodedData['amount'], 'APPAGNT');
        } else {
          Get.back();
          WithdrawInputBottomSheet.showBottomSheetWithdrawalNormalInputNumber();

          // Get.snackbar("Message", decodedData['message'], backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
        // var jsonResponse = jsonDecode(jsonString);
        // print('JSON Response: $jsonResponse');
      } else {
        Get.back();
        print(response.reasonPhrase);
      }
    } on Exception catch (_) {
      log("ERROR $_");
      Get.back();
      RechargeMenuDialog.showMessageDialog(message: "There are no available packages. Please try again later.");
    }
  }

  enterPinToTransactWithdrawal({required String code}) async {
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
          <n0:RequestTokenJson xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
          <message i:type="d:string">APPAGNT ${refID.value} $code F</message>
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
        // var decodedData = jsonDecode(jsonString);
        if (jsonString.contains('Retrait validé')) {
          // SqlHelper.setTransacHistory("-1", jsonString);
          Get.find<StorageServices>().saveHistoryTransaction(message: jsonString, service: "Retrait");
          String trimString = jsonString.replaceAll('Retrait validé', '');
          String inputString = "'''$trimString'''";
          var lines = inputString.trim().split('\n');
          var jsonMap = {};
          for (var line in lines) {
            var parts = line.split(':');
            if (parts.length == 2) {
              var key = parts[0].trim();
              var value = parts[1].trim();
              jsonMap[key] = value;
            }
            if (parts.length == 3) {
              var trioPart = line.split(',');
              for (var lin in trioPart) {
                var finLine = lin.split(':');
                var key = finLine[0].trim();
                var value = finLine[1].trim();
                jsonMap[key] = value;
              }
            }
          }
          var dataEncoded = jsonEncode(jsonMap);
          var dataDecoded = jsonDecode(dataEncoded);
          log('data decoded ${dataDecoded.toString()}');
          // fees.value = dataDecoded['Frais HT'];
          // withdrawalAmountWithUnit.value = dataDecoded['Montant'];
          // taf.value = dataDecoded['TAF'];
          // balance.value = dataDecoded['Nouveau solde Flooz'];
          // message = dataDecoded['message'];
          Get.back();
          // Get.toNamed(AppRoutes.WITHDRAWALSUCCESS);
          Get.toNamed(AppRoutes.WITHDRAWALSUCCESS, arguments: {'msisdn': '', 'amounts': '', 'trimString': jsonString});
        } else {
          Get.back();
          Get.snackbar("Message", jsonString, backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
        }
      } else {
        Get.back();
        print(response.reasonPhrase);
      }
    } on Exception catch (_) {
      log("ERROR $_");
      Get.back();
      RechargeMenuDialog.showMessageDialog(message: "There are no available packages. Please try again later.");
    }
  }

  void getTransactionFee(String msisdn, String amounts, String mess) async {
    ProgressAlertDialog.progressAlertDialog(Get.context!, LocaleKeys.strLoading.tr);
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
   <soapenv:Header/>
   <soapenv:Body>
      <app:getTransactionFee soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <msisdn xsi:type="xsd:string">${AppGlobal.MSISDN}</msisdn>
         <destmsisdn xsi:type="xsd:string">$msisdn</destmsisdn>
         <keyword xsi:type="xsd:string">$mess</keyword>
         <value xsi:type="xsd:string">$amounts</value>
      </app:getTransactionFee>
   </soapenv:Body>
</soapenv:Envelope>''';
      log('getTransactionFee ${request.body}');
      http.StreamedResponse response = await request.send();
      request.headers.addAll(headers);
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('getTransactionFee jsonString 1 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('getTransactionFeeReturn').single;
        var jsonString = soapElement.innerText;
        log('getTransactionFee jsonString 2 $jsonString');

        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        transactionFee = TransactionFee.fromJson(jsonData);
        fees.value = transactionFee!.sender;
        Get.back();
        WithdrawOtpBottomSheet.showBottomSheetWithdrawNormalOTP();
      }
    } catch (e) {
      log('getTransactionFee asd $e');
      Get.back();
      Get.snackbar("Message", 'An error occured! Please try again later', backgroundColor: Colors.lightBlue, colorText: Colors.white);
    }
  }

  @override
  void onInit() async {
    // await addPendingCashout();
    // checkPendingCashout();
    super.onInit();
  }
}
