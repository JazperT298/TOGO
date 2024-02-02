import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:developer';

import '../modules/login/alertdialog/login_alertdialog.dart';
import '../modules/login/controller/login_controller.dart';

class AndroidVerifyServices extends GetxService {
  Future<bool> verifyAndroid() async {
    ProgressAlertDialog.progressAlertDialog(
        Get.context!, LocaleKeys.strLoading.tr);
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = "${packageInfo.version}.0";
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
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">VRFY ${Get.find<DevicePlatformServices>().channelID} ${Get.find<DevicePlatformServices>().deviceID} ${Get.find<DevicePlatformServices>().deviceType} $version F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">false</sendsms>
          </n0:RequestToken>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      log('VERIFY ${request.body}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('RESULT $result');

        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        var decodedData = jsonDecode(jsonString);
        log(decodedData.toString());
        // Get.back();
        if (decodedData['description'] == 'TOKEN_FOUND') {
          log("***********************************************************");
          log("********************* REQUEST VERIFIED ********************");
          log("***********************************************************");
          return true;
        } else if (decodedData['description'] == 'TOKEN_NOT_FOUND') {
          await logout(response: 'TOKEN_NOT_FOUND');
          return false;
        } else if (decodedData['description'] == 'VERSION NOT UP TO DATE') {
          await logout(response: 'VERSION NOT UP TO DATE');
          return false;
        } else {
          return false;
        }
      } else {
        Get.back();
        log("ERROR ${response.reasonPhrase}'");
        return false;
      }
    } catch (e) {
      Get.back();
      log('verifyAndroid $e');
      return false;
    }
  }

  logout({required String response}) async {
    await Get.find<StorageServices>().storage.remove('msisdn').then((value) {
      // Get.find<StorageServices>().storage.remove('isPrivacyCheck');
      Get.find<StorageServices>().storage.remove('isLoginSuccessClick');
      Get.find<StorageServices>().clearUserLocalData();
      Get.find<StorageServices>().clearUsersInformation();
      Get.offAllNamed(AppRoutes.LOGIN);
      Future.delayed(const Duration(seconds: 2), () {
        if (response == "VERSION NOT UP TO DATE") {
          LoginAlertdialog.showMessageVersionNotUpToDate(
              controller: Get.find<LoginController>());
        }
      });
    });
  }
}
