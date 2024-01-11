import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool afficherSolde = true.obs;
  RxBool isLoadingDialog = false.obs;

  RxString name = ''.obs;
  RxString firstname = ''.obs;
  RxString birthdate = ''.obs;
  RxString msisdn = ''.obs;
  RxString soldeFlooz = ''.obs;

  enterPinForInformationPersonelles({required String code}) async {
    isLoadingDialog(true);
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
          <msisdn i:type="d:string">22899990228</msisdn>
          <message i:type="d:string">BALN $code F</message>
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
        // var decodedData = jsonDecode(jsonString);
        if (jsonString.contains('Compte:')) {
          String inputString = jsonString;
          var lines = inputString.trim().split('\n');
          var jsonMap = {};
          for (var line in lines) {
            var parts = line.split(':');
            if (parts.length == 2) {
              var key = parts[0].trim();
              var value = parts[1].trim();
              jsonMap[key] = value;
            }
          }
          var dataEncoded = jsonEncode(jsonMap);
          var dataDecoded = jsonDecode(dataEncoded);
          log(dataDecoded.toString());
          name.value = dataDecoded['Nom'];
          firstname.value = dataDecoded['Prenoms'];
          msisdn.value = dataDecoded['Compte'];
          birthdate.value = dataDecoded['Date de naissance'];
          soldeFlooz.value = dataDecoded['Solde Flooz']
              .toString()
              .replaceAll("FCFA", "")
              .trim()
              .toString();
          afficherSolde.value = false;
          log(soldeFlooz.value);
          Get.back();
        } else {
          Get.snackbar("Message", jsonString,
              backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (_) {
      log("ERROR $_");
    }
    isLoadingDialog(false);
  }
}
