// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/data/models/transaction_fee.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/send_money_input_bottom_sheet.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/send_money_otp_bottom_sheet.dart';
import 'package:ibank/app/providers/auth_provider.dart';
import 'package:ibank/app/providers/transaction_provider.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:developer';

class SendMoneyController extends GetxController {
  RxString nickname = ''.obs;
  RxString amount = ''.obs;
  RxString refID = ''.obs;
  RxString fees = ''.obs;
  RxString senderkeycosttotal = ''.obs;
  RxString senderkeycosttva = ''.obs;
  RxInt totalFess = 0.obs;
  RxInt totalAmount = 0.obs;
  RxString withdrawalAmountWithUnit = ''.obs;

  RxBool isSummaryPage = false.obs;
  RxInt pageLast = 0.obs;
  RxInt index = 0.obs;

  RxString altnumber = ''.obs;
  RxString status = ''.obs;
  RxString lastname = ''.obs;
  RxString gender = ''.obs;
  RxString firstname = ''.obs;
  RxString email = ''.obs;

  RxString msidn = ''.obs;
  RxString amounts = ''.obs;
  RxString thisDate = ''.obs;
  RxString thisTime = ''.obs;
  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxBool isLoadingSend = false.obs;

  RxBool isLoading = true.obs;

  RxBool isTextFieldEmpty = false.obs;
  RxString selectedCountryCode = '+228'.obs;
  FieldType? fieldtype;
  RxString messageType = ''.obs;

  CountryCode? countryCode;
  late final FlCountryCodePicker countryPicker;
  TransactionFee? transactionFee;

  addNumberFromReceiver(String msisdn, String token) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
    <v:Header />
    <v:Body>
        <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
            <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
            <message i:type="d:string">VRFY ANDROIDAPP ${Get.find<DevicePlatformServices>().deviceID} ANDROID 3.0.1.0 F</message>
            <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
            <sendsms i:type="d:string">false</sendsms>
        </n0:RequestToken>
    </v:Body>
</v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print('reseponse 1 ${response.stream.bytesToString()}');
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString);
        // var jsonResponse = jsonDecode(jsonString);
        print('JSON Response: $jsonString');
      } else {
        print('asda ${response.reasonPhrase}');
      }
    } catch (e) {
      print('addNumberFromReceiver $e');
    }
  }

  sendMoneyToReceiver(String msisdn, String token, String amounts) async {
    isLoading(true);
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
    <v:Header />
    <v:Body>
        <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
            <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
            <message i:type="d:string">APPCASH 22879397111 $amounts 1111 F</message>
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
        print(' asd $jsonString');
        var decodedData = jsonDecode(jsonString);
        print('jsonString $jsonString');
        if (decodedData['status'] == "0") {
          nickname.value = decodedData['nickname'];
          amount.value = decodedData['amount'];
          refID.value = decodedData['refid'];
        } else {
          Get.back();
          Get.snackbar("Message", decodedData['message'], backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
        // var jsonResponse = jsonDecode(jsonString);
        // print('JSON Response: $jsonResponse');
      } else {
        print('response.reasonPhrase ${response.reasonPhrase}');
      }
    } on Exception catch (_) {
      log("ERROR $_");
    } catch (e) {
      print('asd $e');
    }
    isLoading(false);
  }

  //Submit feom national
  onVerifySmidnSubmit(String msisdn, BuildContext context) async {
    isLoadingSend(true);
    try {
      fieldtype = FieldType.NORMAL;
      if (AppGlobal.isEditedTransferNational) {
        var res = await AuthProvider.sendVerification(msisdn);
        if (res.extendedData.issubscribed == false && res.extendedData.othernet == true) {
          AppGlobal.isEditedTransferNational = false;
          messageType.value = 'CASHOFF';
          Get.back();
          SendMoneyInputBottomSheet.showBottomSheetSendMoneyNationaInputAmount();
        } else {
          AppGlobal.isEditedTransferNational = false;
          messageType.value = 'APPCASH';
          Get.back();
          SendMoneyInputBottomSheet.showBottomSheetSendMoneyNationaInputAmount();
        }
      } else {
        var res = await AuthProvider.sendVerification(msisdn);
        if (res.extendedData.issubscribed == false && res.extendedData.othernet == true) {
          AppGlobal.isEditedTransferNational = false;
          Get.back();
          messageType.value = 'CASHOFF';

          SendMoneyInputBottomSheet.showBottomSheetSendMoneyNationaInputAmount();
        } else {
          AppGlobal.isEditedTransferNational = false;
          messageType.value = 'APPCASH';
          Get.back();
          SendMoneyInputBottomSheet.showBottomSheetSendMoneyNationaInputAmount();
        }
      }
      log('onSendMoneySubmit messageType $messageType');
    } catch (ex) {
      Get.back();
      log('onSendMoneySubmit ex $ex');
    }
    isLoadingSend(false);
  }

  //Submit feom international
  void onVerifySmidnSubmitInt(String destinationMsisdn, String selectedCountryCode) async {
    try {
      print(" --- $destinationMsisdn");
      print(" --- $selectedCountryCode");
      String removeFirstThreeCharacter = destinationMsisdn.substring(3);
      numberController.text = removeFirstThreeCharacter.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
      print(" destinationMsisdn --- $destinationMsisdn");
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
          <message i:type="d:string">VRFY GETNDC $destinationMsisdn F</message>
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

        if (decodedData['onNet'] == true || decodedData['offNet'] == true) {
          Get.snackbar(LocaleKeys.strInvalidNumber.tr, jsonString, backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else {
          if (decodedData['description'] == "SUCCESS") {
            AppGlobal.internationalType = decodedData['international'];
            //toNextStep();
            Get.back();
            SendMoneyInputBottomSheet.showBottomSheetSendMoneyInterationaInputAmount();
          } else {
            Get.snackbar("Message", "Le numéro n'est pas autorisé", backgroundColor: Colors.lightBlue, colorText: Colors.white);
          }
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('onVerifySmidnSubmit $e');
    }
  }

  getNationalTransactionFee(String msisdn, String amounts, String mess) async {
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
        var asd = '228${numberController.text.replaceAll(" ", "")}';
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        transactionFee = TransactionFee.fromJson(jsonData);
        senderkeycosttotal.value = transactionFee!.senderkeycosttotal;
        senderkeycosttva.value = transactionFee!.senderkeycosttva;

        //To OTP
        SendMoneyOtpsBottomSheet.showBottomSheetSendMoneyNationalOtp();
      }
    } catch (e) {
      log('getTransactionFee asd $e');
      Get.back();
      // showMessageDialog(message: e.toString());
    }
  }

  clearInputAndData() {
    isTextFieldEmpty.value = false;
    messageType.value = '';
    numberController.clear();
    amountController.clear();
    otpController.clear();
    totalFess.value = 0;
    totalAmount.value = 0;
    senderkeycosttotal.value = '';
    senderkeycosttva.value = '';
  }
}
