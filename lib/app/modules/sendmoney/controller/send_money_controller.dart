import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'dart:developer';

class SendMoneyController extends GetxController {
  RxString nickname = ''.obs;
  RxString amount = ''.obs;
  RxString refID = ''.obs;
  RxString fees = ''.obs;
  RxString withdrawalAmountWithUnit = ''.obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    // await addNumberFromReceiver('99990228', 'F3C8DEBDBA27B035');
    // sendMoneyToReceiver('99990228', 'F3C8DEBDBA27B035', '123');
    super.onInit();
  }

  addNumberFromReceiver(String msisdn, String token) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
    <v:Header />
    <v:Body>
        <n0:RequestToken xmlns:n0="http://applicationmanager.tlc.com">
            <msisdn i:type="d:string">22899990228</msisdn>
            <message i:type="d:string">VRFY ANDROIDAPP F3C8DEBDBA27B035 ANDROID 3.0.1.0 F</message>
            <token i:type="d:string">F3C8DEBDBA27B035</token>
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
            <msisdn i:type="d:string">22899990228</msisdn>
            <message i:type="d:string">APPCASH 22879397111 $amounts 1111 F</message>
            <token i:type="d:string">F3C8DEBDBA27B035</token>
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
}
