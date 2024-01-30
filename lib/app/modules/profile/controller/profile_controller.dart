// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/profile/dialog/profile_message_dialog.dart';
import 'package:ibank/app/modules/recharge/views/dialog/recharge_menu_dialog.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  RxString selectedRoute = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingProfile = false.obs;

  RxString name = ''.obs;
  RxString firstname = ''.obs;
  RxString birthdate = ''.obs;
  RxString msisdn = ''.obs;
  RxString soldeFlooz = ''.obs;
  RxString commission = ''.obs;

  TextEditingController oldPIN = TextEditingController();
  TextEditingController newPIN = TextEditingController();
  TextEditingController confirmNewPIN = TextEditingController();

  TextEditingController code = TextEditingController();
  TextEditingController amountTextField = TextEditingController();

  RxBool secured = false.obs;
  RxString secureText = ''.obs;

  RxString selectedImage = ''.obs;

  File? imageFile;

  RxString imageName = ''.obs;

  void getSecureTextFromStorage() async {
    if (Get.find<StorageServices>().storage.read('biometrics') != null) {
      secured.value = await Get.find<StorageServices>().storage.read('biometrics');
    }
  }

  getBack() {
    Get.back();
    Get.back();
  }

  verifyGetProfile({required String msidsn, required String token, required String message, required String sendsms}) async {
    // ProgressAlertDialog.progressAlertDialog(Get.context!, LocaleKeys.strLoading.tr);
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope
            xmlns:i="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:d="http://www.w3.org/2001/XMLSchema"
            xmlns:c="http://schemas.xmlsoap.org/soap/encoding/"
            xmlns:v="http://schemas.xmlsoap.org/soap/envelope/"
          xmlns:web="http://applicationmanager.tlc.com">
             	<v:Header/>
              <v:Body>
                <n0:RequestToken
                    xmlns:n0="http://applicationmanager.tlc.com">
                  <msisdn i:type="d:string"><![CDATA[$msidsn]]></msisdn>
                  <message i:type="d:string"><![CDATA[$message]]></message>
                  <token i:type="d:string"><![CDATA[$token]]></token>
                  <sendsms i:type="d:string"><![CDATA[$sendsms]]></sendsms>
                </n0:RequestToken>
              </v:Body>
            </v:Envelope>''';
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var document = xml.XmlDocument.parse(result);
        var soapBody = document.findAllElements('soapenv:Body').single;
        var requestTokenResponse = soapBody.findAllElements('ns1:RequestTokenResponse').single;
        var requestTokenReturn = requestTokenResponse.findAllElements('RequestTokenReturn').single;
        var jsonString = requestTokenReturn.innerText;
        jsonString = jsonString.replaceAll('&quot;', '"');
        // Convert to JSON
        var json = jsonDecode(jsonString);
        // Get.back();
        String profile = json.containsKey("profile") ? json["profile"] : "";
        String description = json.containsKey("description") ? json["description"] : "";
        String msg = json.containsKey("message") ? json["message"] : "";
        String status = json.containsKey("status") ? json["status"] : "";

        Get.find<StorageServices>().saveVerifyProfile(profile: profile, description: description, message: msg, status: status);
      }
    } on Exception catch (_) {
      log("ERROR $_");
    }
  }

  enterPinForInformationPersonelles({required String code}) async {
    FullScreenLoading.fullScreenLoadingWithText('Validating PIN . . .');
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
          <message i:type="d:string">BALN $code F</message>
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
          soldeFlooz.value = dataDecoded['Solde Flooz'];
          if ((dataDecoded as Map).containsKey('Commission')) {
            commission.value = dataDecoded['Commission'];
          } else {
            commission.value = "N/A";
          }
          //Save lang nko sa storage just in case
          Get.find<StorageServices>().saveUserData(
              name: name.value,
              firstname: firstname.value,
              msisdn: msisdn.value,
              birthdate: birthdate.value,
              soldeFlooz: soldeFlooz.value,
              commission: commission.value);
          Get.back();
          Get.toNamed(AppRoutes.PROFILEINFORMATIONPERSONELLES);
        } else {
          Get.back();
          Get.snackbar("Message", jsonString, backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
      } else {
        print(response.reasonPhrase);
        Get.back();
        Get.snackbar("Message", 'Service unvailable. Please try again later', backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } on Exception catch (_) {
      Get.back();
      RechargeMenuDialog.showMessageDialog(message: "There are no available packages. Please try again later.");
      log("ERROR $_");
    }
  }

  changePin({required String oldPin, required String newPin}) async {
    isLoading(true);
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
          <message i:type="d:string">PASS $oldPin $newPin F</message>
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
        log(jsonString.toString());
        Get.back();
        Get.snackbar("Message", jsonString, backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 10));
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (_) {
      log("ERROR $_");
    }
    isLoading(false);
  }

  amountToCalculate({
    required String amount,
  }) async {
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
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">VRFY GETKEYCOST $amount F</message>
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
        log(jsonString.toString());
        Get.back();
        ProfileMessageDialog.showMessageDialog(message: jsonString);
      } else {
        log("ERROR ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('transactInternetRechargeOwn $e');
    }
  }

  @override
  void onInit() {
    log('MSISDN ${AppGlobal.MSISDN}');
    // verifyGetProfile(
    //     msidsn: AppGlobal.MSISDN,
    //     token: AppGlobal.TOKEN,
    //     message: 'VRFY GETPROFILE F',
    //     sendsms: 'false');
    getLanguage();
    super.onInit();
  }

  void getLanguage() async {
    isLoadingProfile(true);
    String enLang = await Get.find<StorageServices>().storage.read('language');
    await Get.updateLocale(Locale(enLang.toLowerCase()));
    AppGlobal.isSelectFrench = enLang == "FR" ? true : false;
    AppGlobal.isSelectEnglish = enLang == "EN" ? true : false;
    isLoadingProfile(false);
  }

  void changeProfilePicture() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
      if (result!.isSinglePick) {
        selectedImage.value = result.files[0].path!;

        cropImage();
      }
    } catch (ex) {
      if (Platform.isIOS) {
        if (await Permission.storage.isPermanentlyDenied) {
          AppSettings.openAppSettings();
        }
      } else {
        if (!await Permission.storage.shouldShowRequestRationale && await Permission.storage.status.isDenied) {
          AppSettings.openAppSettings();
        }
      }
    }
  }

  ///[_cropImage] call cropping after picking image
  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: selectedImage.value,
      aspectRatioPresets: Platform.isAndroid ? [CropAspectRatioPreset.square] : [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: const Color(0xFF124DE5),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            hideBottomControls: true,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Crop Image',
          resetButtonHidden: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
          rectX: 10000,
          rectY: 10000,
          rectHeight: 10000,
          rectWidth: 10000,
          minimumAspectRatio: 10000,
        )
      ],
    );

    if (croppedFile != null) {
      selectedImage.value = croppedFile.path;
      imageName.value = croppedFile.path.split('/').last;
      imageFile = File(croppedFile.path);
      log('imageFile $imageFile');
      Get.find<StorageServices>().saveProfileImageFromGallery(imageFile: selectedImage.value);
      if (Get.find<StorageServices>().storage.read('imageFile') != null) {
        AppGlobal.PROFILEIMAGE = Get.find<StorageServices>().storage.read('imageFile');
      }
      if (Get.find<StorageServices>().storage.read('image') != null) {
        AppGlobal.PROFILEAVATAR = Get.find<StorageServices>().storage.read('image');
      }
    }
  }
}
