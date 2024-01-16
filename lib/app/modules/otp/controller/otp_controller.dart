// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:developer';
import 'package:get/get.dart';

class OtpController extends GetxController {
  RxString msisdn = ''.obs;
  RxString formatedMSISDN = ''.obs;
  RxString countryCode = ''.obs;
  RxString requestVia = ''.obs;
  RxBool isResendShow = false.obs;
  RxInt tries = 0.obs;

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
          Get.find<StorageServices>().saveMsisdn(
              msisdn: msisdn.value, formattedMSISDN: formatedMSISDN.value);
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

  startTimer() async {
    Timer(const Duration(seconds: 60), () {
      isResendShow.value = true;
      log(isResendShow.value.toString());
    });
  }

  opensMessagingApp({required String encrptedText}) async {
    if (Platform.isAndroid) {
      // const uri = 'sms:+39 348 060 888?body=hello%20there';
      var uri = 'sms:150?body=$encrptedText';
      await launchUrl(Uri.parse(uri));
    } else if (Platform.isIOS) {
      // const uri = 'sms:0039-222-060-888&body=hello%20there';
      var uri = 'sms:150&body=$encrptedText';
      await launchUrl(Uri.parse(uri));
    }
  }

  Future<void> resendencryptionExample(
      {required String msisdn,
      required String formattedMSISDN,
      required String countryCode}) async {
    // String plainPrefix = 'A'; // it must be random character if possible
    // String plainData = 'Hello World';
    // String data = plainPrefix + plainData;
    String letter = "Z";
    if (Get.find<StorageServices>().storage.read("incrementedLetter") != null) {
      letter = Get.find<StorageServices>().storage.read("incrementedLetter");
    }
    int letterCode = letter.codeUnitAt(0);
    int incrementedCode = letterCode + 1;
    if (incrementedCode > 90) {
      incrementedCode = 65;
    }
    String incrementedLetter = String.fromCharCode(incrementedCode);
    Get.find<StorageServices>()
        .storage
        .write('incrementedLetter', incrementedLetter);
    log("Random letter: $incrementedLetter");
    String data = '${incrementedLetter}EULA GETOTP ANDROID $msisdn';
    log(data);
    final List<int> bytes = utf8.encode(data);
    debugPrint(bytes.toString());
    Uint8List xorData = await xor(data);
    debugPrint(xorData.toString());

    Uint8List encrypted = await rsa(xorData);

    String encryptPrefix = 'c';
    String base64 = encryptPrefix + base64Encode(encrypted);
    log(base64);
    await opensMessagingApp(encrptedText: base64);
  }

  Future<Uint8List> xor(String data) async {
    final List<int> bytes = utf8.encode(data);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = bytes[i] ^ 135;
    }
    return Uint8List.fromList(bytes);
  }

  Future<Uint8List> rsa(Uint8List data) async {
    //Prepare Public Key
    String jwkStr =
        "{\"kty\":\"RSA\",\"e\":\"AQAB\",\"n\":\"AKbjVIEF4Ph+wSzUbfMk1Iaidh9WtrlrTxByvB/PL4C4PLJdglemZre9F5vhZr/PgIDZM8Jh4wSM9rPYWnbOUg0iL41vBrojF5/iaS2n7I/37b1ZYHc9EPhpsLPZuaFaS/wuBoagtZTV5hKsQuZPYaZs6P+iqw==\"}";
    dynamic jwk = json.decode(jwkStr);
    String publicKey = await RSA.convertJWKToPublicKey(jwk, "");
    //Encrypt
    Uint8List encrypted = await RSA.encryptPKCS1v15Bytes(data, publicKey);
    return encrypted;
  }

  otpRequestViaApi(
      {required String msisdn,
      required String formattedMSISDN,
      required String countryCode}) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
            <soapenv:Header/>
            <soapenv:Body>
                <app:RequestToken soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                  <msisdn xsi:type="xsd:string">$msisdn</msisdn>
                  <message xsi:type="xsd:string">EULA GETOTP ANDROID $msisdn</message>
                  <token xsi:type="xsd:string">F3C8DEBDBA27B035</token>
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
        print('jsonString $jsonString');
        if (jsonString
            .contains('Votre application est en cours d’activation.')) {
          String otp = StringUtil().extractOTP(jsonString)!;
          //Save OTP to local Storage
          Get.find<StorageServices>().saveOTP(otp: otp);
          // VERIFY OTP
          Get.back();
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
    requestVia.value = await Get.arguments['requestVia'];
    startTimer();
    log(isResendShow.value.toString());
    super.onInit();
  }
}
