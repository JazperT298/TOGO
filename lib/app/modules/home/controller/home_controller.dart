// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../alertdialog/home_alertdialog.dart';

class HomeController extends GetxController {
  RxBool afficherSolde = true.obs;
  RxBool isLoadingDialog = false.obs;

  RxString name = ''.obs;
  RxString firstname = ''.obs;
  RxString birthdate = ''.obs;
  RxString msisdn = ''.obs;
  RxString soldeFlooz = ''.obs;

  checkVersion() async {
    msisdn.value = Get.find<StorageServices>().storage.read('msisdn');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = "${packageInfo.version}.0";
    verifyAndroid(msisdn: msisdn.value, version: version);
  }

  static void verifyAndroid(
      {required String msisdn, required String version}) async {
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
          <message i:type="d:string">VRFY ANDROIDAPP F3C8DEBDBA27B035 ANDROID $version F</message>
          <token i:type="d:string">F3C8DEBDBA27B035</token>
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
        Get.back();
        if (decodedData['description'] == 'TOKEN_FOUND') {
        } else if (decodedData['description'] == 'TOKEN_NOT_FOUND') {
        } else if (decodedData['description'] == 'VERSION NOT UP TO DATE') {
          HomeAlertDialog.showMessageVersionNotUpToDate(
              controller: Get.find<HomeController>());
        } else {}
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      print('verifyAndroid $e');
    }
  }

  Future<void> launch() async {
    if (!await launchUrl(Uri.parse("https://play.google.com/"))) {
      throw Exception('Could not launch url');
    }
  }

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
          <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
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

  @override
  void onInit() {
    checkVersion();
    super.onInit();
  }
}
