// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fast_rsa/fast_rsa.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:developer';

class LoginController extends GetxController {
  final numberController = TextEditingController().obs;
  RxString selectedCountryCode = '+228'.obs;
  RxBool isTextFieldEmpty = false.obs;
  final countryPicker = const FlCountryCodePicker().obs;
  static var client = http.Client();
  RxList<String> existingLetters = <String>[].obs;

  kycInquiryRequest({required String msisdn, required String formattedMSISDN, required String countryCode}) async {
    try {
      var client = HttpClient();
      client.badCertificateCallback = (cert, host, port) => true;
      final request = await client.postUrl(Uri.parse("https://flooznfctest.moov-africa.tg/kyctest/inquiry"));

      // request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      // request.headers.set("Accept", 'application/json');
      request.headers.set("command-id", 'kycinquiry');
      // request.headers.set("Authorization", 'Basic UkVVR0lFOlJFVUdJRQ==');
      // request.headers.set("Content-Type", "application/json");
      request.write(
          jsonEncode({"command-id": "kycinquiry", "destination": msisdn, "request-id": "INQ-$msisdn${DateTime.now().millisecondsSinceEpoch}"}));

      final response = await request.close();
      var responsebody = await response.transform(utf8.decoder).join();

      log("STATUS CODE: ${response.statusCode}");
      // log(response.body);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(responsebody);
        if (decodedData['extended-data']['issubscribed'] == false && decodedData['extended-data']['othernet'] == true) {
          // SOAP REQUEST
          await otpRequestViaApi(msisdn: msisdn, formattedMSISDN: formattedMSISDN, countryCode: countryCode);
        }
        if (decodedData['extended-data']['issubscribed'] == true && decodedData['extended-data']['othernet'] == false) {
          // VIA SMS
          // encryptionExample(msisdn: msisdn, formattedMSISDN: formattedMSISDN, countryCode: countryCode);
          await otpRequestViaApi(msisdn: msisdn, formattedMSISDN: formattedMSISDN, countryCode: countryCode);
        } else {
          Get.back();
          Get.snackbar("Message", "Numero Invalide", backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
      } else {
        log("ERROR something went wrong");
      }
    } on TimeoutException catch (_) {
      log("ERROR TimeoutException $_");
    } on SocketException catch (_) {
      log("ERROR SocketException $_");
      Get.back();
      Get.snackbar("Message", "Une erreur s'est produite. Veuillez réessayer...", backgroundColor: Colors.lightBlue, colorText: Colors.white);
    } catch (_) {
      log("ERROR $_");
    }
  }

  otpRequestViaApi({required String msisdn, required String formattedMSISDN, required String countryCode}) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
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
        if (jsonString.contains('Votre application est en cours d’activation.')) {
          String otp = StringUtil().extractOTP(jsonString)!;
          //Save OTP to local Storage
          Get.find<StorageServices>().saveOTP(otp: otp);
          // VERIFY OTP
          Get.back();
          Get.offAllNamed(AppRoutes.OTP,
              arguments: {"msisdn": msisdn, "formatedMSISDN": formattedMSISDN, "countryCode": countryCode, "requestVia": "api"});
        } else {
          Get.back();
          Get.snackbar("Message", jsonString, backgroundColor: Colors.lightBlue, colorText: Colors.white);
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

  Future<void> encryptionExample({required String msisdn, required String formattedMSISDN, required String countryCode}) async {
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
      incrementedCode = 65; // Wrap around to 'A'
    }
    String incrementedLetter = String.fromCharCode(incrementedCode);
    Get.find<StorageServices>().storage.write('incrementedLetter', incrementedLetter);
    log("Random letter: $incrementedLetter");
    String data = '${incrementedLetter}EULA GETOTP ANDROID $msisdn';
    log(data);
    final List<int> bytes = utf8.encode(data);
    debugPrint(bytes.toString());
    Uint8List xorData = await xor(data);
    log("XOR DATA: ${xorData.toString()}");

    Uint8List encrypted = await rsa(xorData);

    String encryptPrefix = 'c';
    String base64 = encryptPrefix + base64Encode(encrypted);
    log(base64);
    Get.back();
    await opensMessagingApp(encrptedText: base64);
    Get.offAllNamed(AppRoutes.OTP, arguments: {"msisdn": msisdn, "formatedMSISDN": formattedMSISDN, "countryCode": countryCode, "requestVia": "sms"});
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
}
// https://flooznfctest.moov-africa.tg/kyctest/inquiry