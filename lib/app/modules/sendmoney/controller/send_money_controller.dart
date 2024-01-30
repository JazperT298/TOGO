// ignore_for_file: avoid_print, unused_local_variable, unnecessary_string_interpolations

import 'dart:convert';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/transac_reponse.dart';
import 'package:ibank/app/data/models/transaction_fee.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/send_money_input_bottom_sheet.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/send_money_otp_bottom_sheet.dart';
import 'package:ibank/app/providers/auth_provider.dart';
import 'package:ibank/app/providers/transaction_provider.dart';
import 'package:ibank/app/routes/app_routes.dart';
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

  RxBool isInvalidCode = false.obs;
  RxString invalidCodeString = ''.obs;

  RxBool isLoading = true.obs;

  RxBool isTextFieldEmpty = false.obs;
  RxString selectedCountryCode = '+228'.obs;
  FieldType? fieldtype;
  RxString messageType = ''.obs;

  CountryCode? countryCode;
  FlCountryCodePicker countryPicker = FlCountryCodePicker(
      localize: true,
      showDialCode: true,
      showSearchBar: false,
      title: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 0),
              child: Text(LocaleKeys.strSelect.tr.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFB6404))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 0),
              child: Text(LocaleKeys.strYourCountry.tr,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 0),
                child: Text(LocaleKeys.strChooseCountryDesc.tr,
                    style: const TextStyle(fontSize: 14))),
          ],
        ),
      ),
      filteredCountries: ['BJ', 'CI', 'NE', 'BF', 'ML', 'GW', 'SN']);
  TransactionFee? transactionFee;

  TransacResponse? transacResponse;

  RxString thisDsonString = ''.obs;
  RxString errorMessage = ''.obs;
  RxString responsemessage = ''.obs;

  addNumberFromReceiver(String msisdn, String token) async {
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
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
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log(jsonString);
        var decodedData = jsonDecode(jsonString);
        String description = decodedData['description'];
        if (description.contains('TOKEN_FOUND')) {
          var asd = '228${numberController.value.text.replaceAll(" ", "")}';
          log(asd);

          sendMoneyToReceiver(
              asd,
              Get.find<DevicePlatformServices>().deviceID,
              amountController.value.text,
              otpController.value.text,
              messageType.value);
          // // } else if (description.contains('VERSION NOT UP TO DATE')) {
        } else {
          isInvalidCode.value = true;
          if (!description.contains('TOKEN_NOT_FOUND')) {
            invalidCodeString.value = description;
          } else if (description.contains('TOKEN_NOT_FOUND')) {
            await Future.delayed(const Duration(seconds: 1), () {});
            // await SharedPrefService.logoutUserData(false, '').then((value) {
            //   ProgressAlertDialog.showALoadingDialog(Get.context!, LocaleKeys.strLogoutMessage.tr, 3, AppRoutes.LOGIN);
            // });
            Get.snackbar("Message", LocaleKeys.strSessionExpired.tr,
                backgroundColor: Colors.lightBlue,
                colorText: Colors.white,
                duration: const Duration(seconds: 5));
          }
        }
        print('JSON Response: $jsonString');
      } else {
        Get.snackbar("Message", 'An Error Occured',
            backgroundColor: Colors.lightBlue, colorText: Colors.white);

        print('asda ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.back();
      Get.snackbar("Message", e.toString(),
          backgroundColor: Colors.lightBlue, colorText: Colors.white);
      print('addNumberFromReceiver $e');
    }
  }

  sendMoneyToReceiver(String msisdn, String token, String amounts, String code,
      String mess) async {
    FullScreenLoading.fullScreenLoadingWithText(
        'Sending request. Please wait. . .');
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body =
          '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header /><v:Body>
          <n0:RequestTokenJson xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
          <message i:type="d:string">$mess $msisdn $amounts $code F</message>
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
        var soapElement =
            document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        var documentss = xml.XmlDocument.parse(parseResult);
        var requestTokenReturnElement =
            document.findAllElements('RequestTokenJsonReturn').single;

        if (jsonString.contains('Transfert reussi')) {
          String trimString = jsonString.replaceAll('Transfert reussi', '');
          log('LINES $trimString');
          // String inputString = "'''$trimString'''";
          String inputString = '''$trimString''';
          var lines = inputString.trim().split('\r\n');
          var jsonMap = {};
          log('LINES 1 ${lines.toString()}');

          Map<String, dynamic> jsonData = jsonDecode(trimString);

          transacResponse = TransacResponse.fromJson(jsonData);

          for (var line in lines) {
            var parts = line.split(':');
            if (parts.length == 2) {
              var key = parts[0].trim();
              var value = parts[1].trim();
              jsonMap[key] = value;
            }
            if (parts.length == 3) {
              var trioPart = line.split(',');
              for (var lin in trioPart) {
                var finLine = lin.split(':');
                var key = finLine[0].trim();
                var value = finLine[1].trim();
                jsonMap[key] = value;
              }
            }
            if (parts.length == 4) {
              String date = line.replaceAll('Date:', '');
              var dateformatList = date.trim().toString().split(" ");
              jsonMap['Date'] = dateformatList[0];
              jsonMap['Time'] = dateformatList[1];
            }
          }
          var dataEncoded = jsonEncode(jsonMap);
          var dataDecoded = jsonDecode(dataEncoded);
          log(dataDecoded.toString());

          Get.back();
          Get.back();
          Get.find<StorageServices>().saveHistoryTransaction(
              message: jsonString, service: LocaleKeys.strNationalTransfer.tr);
          thisDsonString.value = jsonString;
          errorMessage.value = jsonData['message'];
          responsemessage.value = jsonData['message'];

          int msgId = jsonData["msgid"];
          log('msgId $msgId');
          if (msgId == 0 && messageType.value == "APPCASH" ||
              msgId == 3010 && messageType.value == "CASHOFF") {
            log('SULOD DRE $msgId');
            Get.toNamed(AppRoutes.TRANSACCOMPLETE);
          } else {
            log('SULOD DRE KO $msgId');
            Get.toNamed(AppRoutes.TRANSACFAILED);
          }
        } else {
          log('SULOD GAWAS');
          Get.back();
          Get.find<StorageServices>().saveHistoryTransaction(
              message: jsonString, service: LocaleKeys.strNationalTransfer.tr);
          Get.toNamed(AppRoutes.TRANSACFAILED);

          invalidCodeString.value = jsonString;
        }
      } else {
        log('response.reasonPhrase ${response.reasonPhrase}');
      }
    } on Exception catch (_) {
      Get.back();
      Get.snackbar("Message", 'An Error occured! Please try again later',
          backgroundColor: Colors.lightBlue, colorText: Colors.white);

      log("ERROR $_");
    } catch (e) {
      log('asd $e');
      Get.back();
      Get.back();
      Get.snackbar("Message", 'An Error occured! Please try again later',
          backgroundColor: Colors.lightBlue, colorText: Colors.white);
    }
    isInvalidCode.value = false;
  }

  //Submit feom national
  onVerifySmidnSubmit(String msisdn, BuildContext context) async {
    FullScreenLoading.fullScreenLoadingWithText('Verifying MSISDN. . .');
    try {
      fieldtype = FieldType.NORMAL;
      if (AppGlobal.isEditedTransferNational) {
        var res = await AuthProvider.sendVerification(msisdn);
        Get.back();
        if (res.extendedData.issubscribed == false &&
            res.extendedData.othernet == true) {
          AppGlobal.isEditedTransferNational = false;
          messageType.value = 'CASHOFF';
          Get.back();
          SendMoneyInputBottomSheet
              .showBottomSheetSendMoneyNationaInputAmount();
        } else {
          AppGlobal.isEditedTransferNational = false;
          messageType.value = 'APPCASH';
          Get.back();
          SendMoneyInputBottomSheet
              .showBottomSheetSendMoneyNationaInputAmount();
        }
      } else {
        var res = await AuthProvider.sendVerification(msisdn);
        Get.back();
        if (res.extendedData.issubscribed == false &&
            res.extendedData.othernet == true) {
          AppGlobal.isEditedTransferNational = false;
          Get.back();
          messageType.value = 'CASHOFF';
          SendMoneyInputBottomSheet
              .showBottomSheetSendMoneyNationaInputAmount();
        } else {
          AppGlobal.isEditedTransferNational = false;
          messageType.value = 'APPCASH';
          Get.back();
          SendMoneyInputBottomSheet
              .showBottomSheetSendMoneyNationaInputAmount();
        }
      }

      log('onSendMoneySubmit messageType $messageType');
    } catch (ex) {
      Get.back();
      log('onSendMoneySubmit ex $ex');
    }
  }

  //Submit feom international
  void onVerifySmidnSubmitInt(
      String destinationMsisdn, String selectedCountryCode) async {
    try {
      print(" --- $destinationMsisdn");
      print(" --- $selectedCountryCode");
      String removeFirstThreeCharacter = destinationMsisdn.substring(3);
      numberController.text = removeFirstThreeCharacter.replaceAllMapped(
          RegExp(r".{2}"), (match) => "${match.group(0)} ");
      print(" destinationMsisdn --- $destinationMsisdn");
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
          Get.snackbar(LocaleKeys.strInvalidNumber.tr, jsonString,
              backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else {
          if (decodedData['description'] == "SUCCESS" &&
              decodedData['international'] == 'xmcash') {
            AppGlobal.internationalType = decodedData['international'];
            //toNextStep();
            Get.back();
            String countryName = '';

            // ['BJ', 'CI', 'NE', 'BF', 'ML', 'GW', 'SN']
            if (selectedCountryCode == "+229") {
              countryName = 'Benin';
            }
            if (selectedCountryCode == "+226") {
              countryName = 'Burkina Faso';
            }
            if (selectedCountryCode == "+225") {
              countryName = "Cote D'lvoire Faso";
            }
            if (selectedCountryCode == "+245") {
              countryName = "Guine-Bissau";
            }
            if (selectedCountryCode == "+223") {
              countryName = "Mali";
            }
            if (selectedCountryCode == "+227") {
              countryName = "Niger";
            }
            if (selectedCountryCode == "+221") {
              countryName = "Senegal";
            }
            SendMoneyInputBottomSheet
                .showBottomSheetSendMoneyInterationaInputAmount(
                    countryName: countryName);
          } else {
            Get.snackbar("Message", "Le numéro n'est pas autorisé",
                backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
    FullScreenLoading.fullScreenLoadingWithText('Validating request. . .');
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
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
        var soapElement =
            document.findAllElements('getTransactionFeeReturn').single;
        var jsonString = soapElement.innerText;
        log('getTransactionFee jsonString 2 $jsonString');
        var asd = '228${numberController.text.replaceAll(" ", "")}';
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        transactionFee = TransactionFee.fromJson(jsonData);
        transactionFee = TransactionFee.fromJson(jsonData);
        senderkeycosttotal.value = transactionFee!.senderkeycosttotal;
        senderkeycosttva.value = transactionFee!.senderkeycosttva;
        totalFess.value =
            int.parse(senderkeycosttotal.value.replaceAll(',', '')) -
                int.parse(senderkeycosttva.value.replaceAll(',', ''));
        totalAmount.value = int.parse(amounts) +
            int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        Get.back();
        Get.back();
        //To OTP
        SendMoneyOtpsBottomSheet.showBottomSheetSendMoneyNationalOtp();
      }
    } catch (e) {
      log('getTransactionFee asd $e');
      Get.back();
      // showMessageDialog(message: e.toString());
    }
  }

  getInternationalTransactionFee(String msisdn, String amounts) async {
    FullScreenLoading.fullScreenLoadingWithText('Validating request. . .');
    try {
      String countryName = '';
      String alphacodetwo = '';

      // ['BJ', 'CI', 'NE', 'BF', 'ML', 'GW', 'SN']
      if (selectedCountryCode.value == "+229") {
        alphacodetwo = 'BJ';
        countryName = 'Benin';
      }
      if (selectedCountryCode.value == "+226") {
        alphacodetwo = 'BF';
        countryName = 'Burkina Faso';
      }
      if (selectedCountryCode.value == "+225") {
        alphacodetwo = 'CI';
        countryName = "Cote D'lvoire Faso";
      }
      if (selectedCountryCode.value == "+245") {
        alphacodetwo = 'GW';
        countryName = "Guine-Bissau";
      }
      if (selectedCountryCode.value == "+223") {
        alphacodetwo = 'ML';
        countryName = "Mali";
      }
      if (selectedCountryCode.value == "+227") {
        alphacodetwo = 'NE';
        countryName = "Niger";
      }
      if (selectedCountryCode.value == "+221") {
        alphacodetwo = 'SN';
        countryName = "Senegal";
      }
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      if (AppGlobal.internationalType == "xmcash") {
        request.body =
            '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
            <soapenv:Header/>
            <soapenv:Body>
                <app:getTransactionFee soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                  <msisdn xsi:type="xsd:string">${AppGlobal.MSISDN}</msisdn>
                  <destmsisdn xsi:type="xsd:string">MFS_AFRICA_SEND</destmsisdn>
                  <keyword xsi:type="xsd:string">XMCASH</keyword>
                  <value xsi:type="xsd:string">500</value>
                </app:getTransactionFee>
            </soapenv:Body>
          </soapenv:Envelope>''';
      } else if (AppGlobal.internationalType == "xcash") {
        request.body =
            '''<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:app="http://applicationmanager.tlc.com">
            <soapenv:Header/>
            <soapenv:Body>
                <app:getTransactionFee soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
                  <msisdn xsi:type="xsd:string">${AppGlobal.MSISDN}</msisdn>
                  <destmsisdn xsi:type="xsd:string">XBORDER_SEND_$alphacodetwo</destmsisdn>
                  <keyword xsi:type="xsd:string">XCASH</keyword>
                  <value xsi:type="xsd:string">$amount</value>
                </app:getTransactionFee>
            </soapenv:Body>
          </soapenv:Envelope>''';
      }
      log('getTransactionFee ${request.body}');
      http.StreamedResponse response = await request.send();
      request.headers.addAll(headers);
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        // log('getTransactionFee jsonString 1 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement =
            document.findAllElements('getTransactionFeeReturn').single;
        var jsonString = soapElement.innerText;
        log('getTransactionFee jsonString 2 $jsonString');
        var asd =
            '${selectedCountryCode.value.replaceAll('+', '')}${numberController.text.replaceAll(" ", "")}';
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        transactionFee = TransactionFee.fromJson(jsonData);
        transactionFee = TransactionFee.fromJson(jsonData);
        senderkeycosttotal.value = transactionFee!.senderkeycosttotal;
        senderkeycosttva.value = transactionFee!.senderkeycosttva;
        totalFess.value =
            int.parse(senderkeycosttotal.value.replaceAll(',', '')) -
                int.parse(senderkeycosttva.value.replaceAll(',', ''));
        totalAmount.value = int.parse(amounts) +
            int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        Get.back();
        Get.back();
        //To OTP
        SendMoneyOtpsBottomSheet.showBottomSheetSendMoneyInterationalOtp(
            countryName: countryName);
      }
    } catch (e) {
      log('getTransactionFee asd $e');
      Get.back();
      // showMessageDialog(message: e.toString());
    }
  }

  sendMoneyInternationFinalHit(
      {required String destinationMSISDN,
      required String amount,
      required String selectedCountryCode,
      required String code}) async {
    FullScreenLoading.fullScreenLoadingWithText('Validating request. . .');
    String toReplaceSpaces =
        (selectedCountryCode + destinationMSISDN).trim().toString();
    String toReplacePlusSign = toReplaceSpaces.replaceAll(" ", "");
    String finalmsisdn =
        toReplacePlusSign.replaceAll("+", "").trim().toString();
    print(finalmsisdn);
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST',
          Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      if (AppGlobal.internationalType == "xcash") {
        request.body =
            '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:RequestTokenJson xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
          <message i:type="d:string">CASH $finalmsisdn $amount $code F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms></n0:RequestTokenJson></v:Body></v:Envelope>''';
      } else if (AppGlobal.internationalType == "xmcash") {
        String alphacodetwo = '';
        // ['BJ', 'CI', 'NE', 'BF', 'ML', 'GW', 'SN']
        if (selectedCountryCode == "+229") {
          alphacodetwo = 'BJ';
        }
        if (selectedCountryCode == "+226") {
          alphacodetwo = 'BF';
        }
        if (selectedCountryCode == "+225") {
          alphacodetwo = 'CI';
        }
        if (selectedCountryCode == "+245") {
          alphacodetwo = 'GW';
        }
        if (selectedCountryCode == "+223") {
          alphacodetwo = 'ML';
        }
        if (selectedCountryCode == "+227") {
          alphacodetwo = 'NE';
        }
        if (selectedCountryCode == "+221") {
          alphacodetwo = 'SN';
        }
        request.body =
            '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
            xmlns:d="http://www.w3.org/2001/XMLSchema" 
            xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
            xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
            <v:Header />
            <v:Body>
            <n0:RequestTokenJson xmlns:n0="http://applicationmanager.tlc.com">
            <msisdn i:type="d:string">${AppGlobal.MSISDN}</msisdn>
            <message i:type="d:string">XMCASH MFS_AFRICA_SEND $finalmsisdn:::$alphacodetwo $amount $code F</message>
            <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
            <sendsms i:type="d:string">true</sendsms>
            </n0:RequestTokenJson></v:Body></v:Envelope>''';
      }

      http.StreamedResponse response = await request.send();
      request.headers.addAll(headers);
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement =
            document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        thisDsonString.value = jsonString;
        log(jsonString.toString());
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        if (jsonData['msgid'] == "0") {
          Get.back();
          responsemessage.value = jsonData['message'];
          Get.toNamed(AppRoutes.TRANSACFAILED);
          Get.find<StorageServices>().saveHistoryTransaction(
              message: responsemessage.value,
              service: LocaleKeys.strInternationalTransfer.tr);
        } else {
          Get.back();
          responsemessage.value = jsonData['message'];
          Get.toNamed(AppRoutes.TRANSACFAILED);
          Get.find<StorageServices>().saveHistoryTransaction(
              message: responsemessage.value,
              service: LocaleKeys.strInternationalTransfer.tr);
        }
      }
    } catch (e) {
      log('getTransactionFee asd $e');
      Get.back();
      Get.snackbar("Message", "An Error occured! Please try again later");
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
