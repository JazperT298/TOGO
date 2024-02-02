// ignore_for_file: unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/mbank_model.dart';
import 'package:ibank/app/data/models/mbank_sub_model.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/data/models/transac_reponse.dart';
import 'package:ibank/app/data/models/transaction_fee.dart';
import 'package:ibank/app/modules/mbanking/views/modals/mbaking_otp_bottom_sheet.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:xml/xml.dart' as xml;

class MBankingController extends GetxController {
  TextEditingController amountTextField = TextEditingController();
  TextEditingController codeTextField = TextEditingController();

  RxString selectedMenu = ''.obs;
  RxString selectedSubMenu = ''.obs;
  RxString transferDesc = ''.obs;

  List<MBankModel> mBankModel = [];
  List<MBankSubModel> mBankSubModel = [];
  List<MBankListModel> mBankListModel = [];

  RxString destmsisdn = ''.obs;
  RxString keyword = ''.obs;

  RxBool lastIsLogout = false.obs;
  TransactionFee? transactionFee;
  TransacResponse? transacResponse;

  RxString senderkeycosttotal = ''.obs;
  RxString senderkeycosttva = ''.obs;
  RxInt totalFess = 0.obs;
  RxInt totalAmount = 0.obs;

  RxString thisDsonString = ''.obs;
  RxString errorMessage = ''.obs;
  RxString responsemessage = ''.obs;
  RxString transactionID = ''.obs;
  RxString senderBalance = ''.obs;

  RxString firstname = ''.obs;

  RxString lastname = ''.obs;
  RxInt selectedIndex = 0.obs;
  RxString selectedBank = ''.obs;
  @override
  void onInit() {
    super.onInit();
    getMBankList();
    getMBankSubList();
    getMBankGetList();
  }

  getMBankList() {
    mBankModel = [
      MBankModel(
        mBankType: 'Banks',
        mBankTypeDesc: 'Connect your bank accounts',
      ),
      MBankModel(
        mBankType: 'Microfinance',
        mBankTypeDesc: 'Simply connect your insurance',
      ),
      MBankModel(
        mBankType: 'Mesofinance',
        mBankTypeDesc: 'Connect to your mesofinances',
      )
    ];
  }

  getMBankSubList() {
    mBankSubModel = [
      MBankSubModel(
        mBankType: 'Flooz to Ecobank',
        mBankTypeDesc: 'EcoBank',
        icon: FluIcons.profile,
      ),
      MBankSubModel(
        mBankType: 'Ecobank to Flooz',
        mBankTypeDesc: 'Send money to Flooz',
        icon: FluIcons.textalignCenter,
      )
    ];
  }

  getMBankGetList() {
    mBankListModel = [
      MBankListModel(
        mBankType: 'Bank',
        mBankTypeDesc: 'EcoBank',
        icon: FluIcons.profile,
      ),
      MBankListModel(
        mBankType: 'Bank',
        mBankTypeDesc: 'La Poste',
        icon: FluIcons.profile,
      ),
      MBankListModel(
        mBankType: 'Bank',
        mBankTypeDesc: 'Bank Atlantique',
        icon: FluIcons.profile,
      ),
      MBankListModel(
        mBankType: 'Bank',
        mBankTypeDesc: 'Orabank',
        icon: FluIcons.profile,
      ),
    ];
  }

  getBankingTransactionFee(String destmsisdn, String amounts, String keyword) async {
    FullScreenLoading.fullScreenLoadingWithText('Validating request. . .');
    await getMsisdnDetails(); //
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
   <soapenv:Header/>
   <soapenv:Body>
      <app:getTransactionFee soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <msisdn xsi:type="xsd:string">${AppGlobal.MSISDN}</msisdn>
         <destmsisdn xsi:type="xsd:string">$destmsisdn</destmsisdn>
         <keyword xsi:type="xsd:string">$keyword</keyword>
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
        senderkeycosttotal.value = transactionFee!.senderkeycosttotal;
        senderkeycosttva.value = transactionFee!.senderkeycosttva;
        totalFess.value = int.parse(senderkeycosttotal.value.replaceAll(',', '')) - int.parse(senderkeycosttva.value.replaceAll(',', ''));
        totalAmount.value = int.parse(amounts) + int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        Get.back();
        Get.back();
        MBankingOTpBottomSheet.showMBankingOtpBankBottomSheet();
        //To OTP
      }
    } catch (e) {
      log('getTransactionFee asd $e');
      Get.back();
      // showMessageDialog(message: e.toString());
    }
  }

  getMsisdnDetails() async {
    try {
      // String usermsisdn = AppGlobal.MSISDN.replaceAll("from", replace)
      String usermsisdn = AppGlobal.MSISDN.substring(3);
      log(usermsisdn);
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));

      request.body =
          '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
              <soapenv:Header/>
              <soapenv:Body>
                  <app:getMsisdnDetails soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                    <msisdn xsi:type="xsd:string">$usermsisdn</msisdn>
                  </app:getMsisdnDetails>
              </soapenv:Body>
            </soapenv:Envelope>''';
      log('getMsisdnDetails ${request.body}');
      http.StreamedResponse response = await request.send();
      request.headers.addAll(headers);
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        // log('getTransactionFee jsonString 1 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('getMsisdnDetailsReturn').single;
        var jsonString = soapElement.innerText;
        log('getMsisdnDetails jsonString 2 $jsonString');
        var jsonDecodedData = jsonDecode(jsonString);
        firstname.value = jsonDecodedData['FIRSTNAME'];
        lastname.value = jsonDecodedData['LASTNAME'];
      }
    } catch (e) {
      log('getTransactionFee asd $e');
      Get.back();
      Get.snackbar("Message", 'An Error occured! Please try again later', backgroundColor: Colors.lightBlue, colorText: Colors.white);
      // showMessageDialog(message: e.toString());
    }
  }

  sendFinalTransaction(String keyword, String selectedMenu, String amount, String password) async {
    FullScreenLoading.fullScreenLoadingWithText('Sending request. Please wait. . .');
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header /><v:Body>
          <n0:RequestTokenJson xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
          <message i:type="d:string">$keyword $selectedMenu $amount $password F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token><sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson></v:Body></v:Envelope>''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      log(request.body);

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('result 2 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;

        var jsonString = soapElement.innerText;
        thisDsonString.value = jsonString;

        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        transacResponse = TransacResponse.fromJson(jsonData);
        if (jsonData['msgid'] == 0) {
          transactionID.value = jsonData['refid'];
          senderBalance.value = jsonData['senderbalance'];
          Get.back();
          responsemessage.value = jsonData['message'];
          Get.toNamed(AppRoutes.MBANKSUCCESS);
          Get.find<StorageServices>().saveHistoryTransaction(message: responsemessage.value, service: 'MBanking');
        } else {
          Get.back();
          responsemessage.value = jsonData['message'];
          Get.toNamed(AppRoutes.MBANKFAILED);
          Get.find<StorageServices>().saveHistoryTransaction(message: responsemessage.value, service: 'MBanking');
        }
      } else {
        Get.back();
        log('response.reasonPhrase ${response.reasonPhrase}');
      }
    } on Exception catch (_) {
      Get.back();
      Get.snackbar("Message", 'An Error occured! Please try again later', backgroundColor: Colors.lightBlue, colorText: Colors.white);

      log("ERROR $_");
    } catch (e) {
      log('asd $e');
      Get.back();
      Get.snackbar("Message", 'An Error occured! Please try again later', backgroundColor: Colors.lightBlue, colorText: Colors.white);
    }
  }
}
