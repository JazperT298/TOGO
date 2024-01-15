// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:developer';
import 'package:get/get.dart';

class OtpController extends GetxController {
  RxString msisdn = ''.obs;
  RxString formatedMSISDN = ''.obs;
  RxString countryCode = ''.obs;

  verifyOTP({required String otp}) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
            <soapenv:Header/>
            <soapenv:Body>
                <app:RequestToken soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                  <msisdn xsi:type="xsd:string">${msisdn.value}</msisdn>
                  <message xsi:type="xsd:string">EULA OTP $otp F3C8DEBDBA27B035 ANDROID 3.0.1.0</message>
                  <token xsi:type="xsd:string">F3C8DEBDBA27B035</token>
                  <sendsms xsi:type="xsd:string">false</sendsms>
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
        if (jsonString
            .contains("Connexion à l'application Flooz réussie. Merci!")) {
          //Save the msisdn and token to storage if success
          Get.find<StorageServices>().saveMsisdn(msisdn: msisdn.value);
          Get.find<StorageServices>().setToken(token: 'F3C8DEBDBA27B035');
          // SUCCESS OTP
          Get.back();
          Get.offAllNamed(AppRoutes.PRIVACY);
        } else {
          Get.back();
          Get.snackbar("Message", jsonString,
              backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
        // var jsonResponse = jsonDecode(jsonString);
        // print('JSON Response: $jsonResponse');
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (_) {
      log("ERROR $_");
      Get.back();
    }
  }

  @override
  void onInit() async {
    msisdn.value = await Get.arguments['msisdn'];
    formatedMSISDN.value = await Get.arguments['formatedMSISDN'];
    countryCode.value = await Get.arguments['countryCode'];

    super.onInit();
  }
}
