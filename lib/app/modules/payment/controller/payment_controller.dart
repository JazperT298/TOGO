// ignore_for_file: unnecessary_null_comparison, unused_local_variable, unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/data/models/bbox_cizo_model.dart';
import 'package:ibank/app/data/models/bbox_cizo_sub_model.dart';
import 'package:ibank/app/data/models/bill_payment_model.dart';
import 'package:ibank/app/data/models/cash_power_model.dart';
import 'package:ibank/app/data/models/cash_power_sub_model.dart';
import 'package:ibank/app/data/models/ceet_products_model.dart';
import 'package:ibank/app/data/models/moon_payment_mode.dart';
import 'package:ibank/app/data/models/moon_payment_sub_model.dart';
import 'package:ibank/app/data/models/payment_merchant.dart';
import 'package:ibank/app/data/models/soleva_payment_model.dart';
import 'package:ibank/app/data/models/soleva_payment_sub_model.dart';
import 'package:ibank/app/data/models/tde_model.dart';
import 'package:ibank/app/data/models/tde_payment_model.dart';
import 'package:ibank/app/data/models/tde_sub_model.dart';
import 'package:ibank/app/data/models/transaction_fee.dart';
import 'package:ibank/app/data/models/tvchannels_model.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/login/alertdialog/login_alertdialog.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_enter_otp_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_inputs_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_enter_otp_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_inputs_bottom_sheet.dart';
import 'package:ibank/app/modules/recharge/views/dialog/recharge_menu_dialog.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class PaymentController extends GetxController {
  TextEditingController referenceTextField = TextEditingController();
  TextEditingController numberTextField = TextEditingController();
  TextEditingController titleTextField = TextEditingController();
  TextEditingController namneTextField = TextEditingController();
  TextEditingController amountTextField = TextEditingController();
  TextEditingController code = TextEditingController();
  RxString senderkeycosttotal = ''.obs;
  RxString senderkeycosttva = ''.obs;
  RxInt totalFess = 0.obs;
  RxInt totalAmount = 0.obs;
  DateTime? parsedDate;
  RxString extractedDate = ''.obs;
  RxString selectedOption = ''.obs;
  RxString selectedSubOption = ''.obs;

  //Merchant Payment variables
  RxInt selectedMerchantIndex = 0.obs;
  RxInt selectedMerchanSubMenutIndex = 0.obs;
  RxInt selectedMerchanEcobanktIndex = 0.obs;

  //TV Channels variables

  //Energies variables
  RxList<CeetProducts> ceetProductList = <CeetProducts>[].obs;
  RxList<Datum> ceetDataList = <Datum>[].obs;
  RxString ceetPackageRadioGroupValue = ''.obs;
  RxString keyword = ''.obs;

  Datum? selectDatum;
  BillPayment? billPayment;
  RxInt selectedMoonIndex = 0.obs;
  RxInt selectedMoonSubIndex = 0.obs;
  RxInt selectedSolevaIndex = 0.obs;
  RxInt selectedSolevaSubIndex = 0.obs;
  RxInt selectedCashPowerIndex = 0.obs;
  RxInt selectedCashPowerSubIndex = 0.obs;
  RxInt selectedTDEIndex = 0.obs;
  RxInt selectedTDESubIndex = 0.obs;
  RxInt selectedBBoxCizeIndex = 0.obs;
  RxInt selectedBBoxCizeSubIndex = 0.obs;

  SolevaPaymentSubModel? selectedSolevaSubMenu;
  CashPowerSubModel? selectedCashPowerSubMenu;
  BBoxCizoSubModel? selectedBBoxCizoSubMenu;
  TDESubModel? selectTDESubMenu;
  TDEPaymentModel? selectTDEPaymentModel;

  RxString solevaPackageRadioGroupValue = ''.obs;
  RxString cashPowerPackageRadioGroupValue = ''.obs;
  RxString tdePackageRadioGroupValue = ''.obs;
  RxString tdePaymentRadioGroupValue = ''.obs;
  RxString bboxCizoackageRadioGroupValue = ''.obs;

  //Canal Box variables

  //Insurance variables

  //Tuition variables

  //Transport and Freight variables

  //Fuel Card variables

  //Moov Postpaid variables

  final _solevaPaymentModelList = <SolevaPaymentSubModel>[].obs;
  List<SolevaPaymentSubModel> get solevaPaymentModelList => _solevaPaymentModelList;

  final _cashPowerSubModelList = <CashPowerSubModel>[].obs;
  List<CashPowerSubModel> get cashPowerSubModelList => _cashPowerSubModelList;

  final _bboxCizoSubModelList = <BBoxCizoSubModel>[].obs;
  List<BBoxCizoSubModel> get bboxCizoSubModelList => _bboxCizoSubModelList;

  final _tdeSubModelList = <TDESubModel>[].obs;
  List<TDESubModel> get tdeSubModelList => _tdeSubModelList;

  List<PaymentMerchantModel> paymentMerchatList = [
    PaymentMerchantModel(title: 'Contactless payment', description: 'Pay your merchant quickly', icon: FluIcons.tvRetroUnicon),
    PaymentMerchantModel(title: 'Online payment', description: 'Pay for your orders online', icon: FluIcons.tvRetroUnicon),
  ];

  List<PaymentMerchantSubModel> paymentMerchatSubList = [
    PaymentMerchantSubModel(title: 'Payment with reference', description: 'Pay using the merchant ref', icon: FluIcons.tvRetroUnicon),
    PaymentMerchantSubModel(title: 'Payment without reference', description: 'Pay without merchant ref', icon: FluIcons.tvRetroUnicon),
    PaymentMerchantSubModel(title: 'EcobankPay', description: 'Pay with your Ecobank account', icon: FluIcons.tvRetroUnicon),
  ];

  List<TVChannelsModel> tvChannelsMode = [
    TVChannelsModel(title: 'Canal + ', description: 'Resubscribe to Canal +', icon: FluIcons.tvRetroUnicon),
    TVChannelsModel(title: 'New World TV', description: 'Resubscribe to New World TV', icon: FluIcons.tvRetroUnicon),
  ];

  List<MoonPaymentModel> moonPaymentModel = [
    MoonPaymentModel(title: 'Payment offer', description: 'I would like to subscribe to the offer', icon: FluIcons.tvRetroUnicon),
    MoonPaymentModel(title: 'Accessory payment', description: 'I would like to pay for accessories', icon: FluIcons.tvRetroUnicon),
  ];

  List<MoonPaymentSubModel> moonPaymentSubModel = [
    MoonPaymentSubModel(title: 'New customer', description: 'Validate the subscription', icon: FluIcons.tvRetroUnicon),
    MoonPaymentSubModel(title: 'Pay for me', description: 'I pay for myself', icon: FluIcons.tvRetroUnicon),
    MoonPaymentSubModel(title: 'Pay for a third party', description: 'I pay for a third party', icon: FluIcons.tvRetroUnicon),
  ];

  List<SolevaPaymentModel> solevaPaymentModel = [
    SolevaPaymentModel(title: 'For myself', description: 'I pay for myself', icon: FluIcons.tvRetroUnicon),
    SolevaPaymentModel(title: 'For another person', description: 'I pay for a loved one', icon: FluIcons.tvRetroUnicon),
  ];

  List<CashPowerModel> cashPowerModel = [
    CashPowerModel(title: 'Buying Cash Power', description: 'Make a cash power payment', icon: FluIcons.tvRetroUnicon),
    CashPowerModel(title: 'Duplicate', description: 'Retrieve the cash power code', icon: FluIcons.tvRetroUnicon),
  ];

  List<BBoxCizoModel> bboxCizoModel = [
    BBoxCizoModel(title: 'For myself', description: 'I pay for myself', icon: FluIcons.tvRetroUnicon),
    BBoxCizoModel(title: 'For another person', description: 'I pay for a loved one', icon: FluIcons.tvRetroUnicon),
  ];

  List<TDEModel> tdeModel = [
    TDEModel(title: 'TDE payment for me', description: 'I pay for myself', icon: FluIcons.tvRetroUnicon),
    TDEModel(title: 'TDE payment for a third party', description: 'I pay for a loved one', icon: FluIcons.tvRetroUnicon),
    TDEModel(title: 'View unpaid debts', description: 'View my unpaid invoices', icon: FluIcons.tvRetroUnicon),
  ];
  List<TDEPaymentModel> tdePaymentModel = [
    TDEPaymentModel(title: '2 750 FCFA', description: '12/2023'),
    TDEPaymentModel(title: '3 400 FCFA', description: '11/2023'),
    TDEPaymentModel(title: '2 100 FCFA', description: '10/2023'),
  ];
  List<WalletAction> walletChild = [
    WalletAction(name: 'CEET', description: 'Gorem ipsum dolor sit amet, co...', icon: FluIcons.electricity),
    WalletAction(name: 'Cash Power', description: 'Gorem ipsum dolor sit amet, co...', icon: FluIcons.electricity),
    WalletAction(name: 'TDE', description: 'Gorem ipsum dolor sit amet, co...', icon: FluIcons.sun),
    WalletAction(name: 'Solergie', description: 'Gorem ipsum dolor sit amet, co...', icon: FluIcons.sun),
    WalletAction(name: 'BBox Cizo', description: 'Gorem ipsum dolor sit amet, co...', icon: FluIcons.wallet),
    WalletAction(name: 'Soleva', description: 'Gorem ipsum dolor sit amet, co...', icon: FluIcons.watch),
    WalletAction(name: 'Moon', description: 'Gorem ipsum dolor sit amet, co...', icon: FluIcons.moon),
  ];
  RxString price = ''.obs;
  TransactionFee? transactionFee;
  RxString billType = 'APPBILL CEET'.obs;
  RxString billRef = ''.obs;

  RxString thisDsonString = ''.obs;
  RxString errorMessage = ''.obs;
  //----Soleva
  bool isSubMenuExists(String description) {
    return _solevaPaymentModelList.any((solevaPaymentModelList) => solevaPaymentModelList.description == description);
  }

  void addSolevaSubMenu(SolevaPaymentSubModel solevaPaymentSubModel) {
    _solevaPaymentModelList.add(solevaPaymentSubModel);
    saveSolevaSubMenu();
  }

  saveSolevaSubMenu() {
    final box = GetStorage();
    box.write('solevaPaymentModelList', _solevaPaymentModelList.map((solevaPaymentModelList) => solevaPaymentModelList.toJson()).toList());
  }

  loadSolevaSubMenu() {
    final box = GetStorage();
    final userListData = box.read<List>('solevaPaymentModelList') ?? [];
    solevaPaymentModelList.assignAll(userListData.map((data) => SolevaPaymentSubModel.fromJson(data)));
  }
  //----End Soleva

  //----Cash Power
  bool isCashPowerSubMenuExists(String description) {
    return _cashPowerSubModelList.any((cashPowerSubModelList) => cashPowerSubModelList.description == description);
  }

  void addCashPowerSubMenu(CashPowerSubModel cashPowerSubModelList) {
    _cashPowerSubModelList.add(cashPowerSubModelList);
    loadCashPowerSubMenu();
  }

  saveCashPowerSubMenu() {
    final box = GetStorage();
    box.write('cashPowerSubModelList', _cashPowerSubModelList.map((cashPowerSubModelList) => cashPowerSubModelList.toJson()).toList());
  }

  loadCashPowerSubMenu() {
    final box = GetStorage();
    final userListData = box.read<List>('cashPowerSubModelList') ?? [];
    cashPowerSubModelList.assignAll(userListData.map((data) => CashPowerSubModel.fromJson(data)));
  }
  //----End Cash Power

  //----TDE
  bool isTDESubMenuExists(String description) {
    return _cashPowerSubModelList.any((cashPowerSubModelList) => cashPowerSubModelList.description == description);
  }

  void addTDESubMenu(TDESubModel tdeSubModelList) {
    _tdeSubModelList.add(tdeSubModelList);
    loadTDESubMenu();
  }

  saveTDESubMenu() {
    final box = GetStorage();
    box.write('tdeSubModelList', _tdeSubModelList.map((tdeSubModelList) => tdeSubModelList.toJson()).toList());
  }

  loadTDESubMenu() {
    final box = GetStorage();
    final userListData = box.read<List>('tdeSubModelList') ?? [];
    tdeSubModelList.assignAll(userListData.map((data) => TDESubModel.fromJson(data)));
  }
  //----End TDE

  //----BBox Cize
  bool isBBoxCizeSubMenuExists(String description) {
    return _bboxCizoSubModelList.any((bboxCizoSubModelList) => bboxCizoSubModelList.description == description);
  }

  void addBBoxCizeSubMenu(BBoxCizoSubModel bboxCizoSubModelList) {
    _bboxCizoSubModelList.add(bboxCizoSubModelList);
    loadBBoxCozeSubMenu();
  }

  saveBBoxCizeSubMenu() {
    final box = GetStorage();
    box.write('bboxCizoSubModelList', _bboxCizoSubModelList.map((bboxCizoSubModelList) => bboxCizoSubModelList.toJson()).toList());
  }

  loadBBoxCozeSubMenu() {
    final box = GetStorage();
    final userListData = box.read<List>('bboxCizoSubModelList') ?? [];
    bboxCizoSubModelList.assignAll(userListData.map((data) => BBoxCizoSubModel.fromJson(data)));
  }
  //----End BBox Cize

  verifyGetCeetLink() async {
    FullScreenLoading.fullScreenLoadingWithTextAndTimer('Requesting. . .');
    try {
      ceetProductList.clear();
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
          <message i:type="d:string">VRFY GETCEETLINK F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">false</sendsms>
          </n0:RequestToken>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      log('verifyGetCeetLink 1 ${request.body}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        var decodedData = jsonDecode(jsonString);
        log('verifyGetCeetLink 0 ${decodedData.toString()}');

        log('verifyGetCeetLink 1 ${jsonEncode(decodedData)}');
        // var apiResponseMap = json.decode(decodedData);
        if (decodedData['description'] == 'SUCCESS') {
          if (selectedOption.value == "CEET") {
            // Get.back();
            Get.back();
            Get.back();

            // PaymentInputsBottomSheet.showBottomSheetInputNumber();
            // CeetProducts apiResponse = CeetProducts.fromJson(json.decode(decodedData));

            ceetDataList.assignAll(CeetDataProductsFromJson(jsonEncode(decodedData['data']))); //<----
            // PaymentServiceLinksBottomSheet.showBottomSheetCeetServicePackageTo();
            EnergiesInputsBottomSheet.showBottomSheetCeetInputNumber();
            // await transactVoiceRechargeOwn(msisdn: msisdn, code: code);
          }
        } else if (decodedData['description'] == 'DATA_NOT_FOUND') {
          // await transactVoieRechargeOthers(msisdn: msisdn, code: code);
          Get.back();
          Get.snackbar("Message", decodedData['message'], backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
        }
      } else {
        Get.back();
        log("ERROR ${response.reasonPhrase}'");
        Get.snackbar("Message", 'An Error Occured, Please try again later', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
      }
    } catch (e) {
      log('verifyGetCeetLink $e');
      Get.back();
      RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
    }
  }

  verifyCeetRefIDfromInput({required String refId}) async {
    FullScreenLoading.fullScreenLoadingWithTextAndTimer('Validating Reference ID. . .');
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
          <message i:type="d:string">VRFY CEET $refId</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestToken>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      log('verifyCeetRefIDfromInput 0 ${request.body}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('verifyCeetRefIDfromInput result 0 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log('verifyCeetRefIDfromInput jsonString 1 ${jsonString.toString()}');
        var decodedData = jsonDecode(jsonString);
        log('verifyCeetRefIDfromInput 2 decodedData ${decodedData.toString()}');

        if (decodedData['status'] == "0") {
          Get.back();
          billPayment = BillPayment.fromJson(decodedData);
          price.value = billPayment!.message[0].price;
          RegExp regExp = RegExp(r'\b(\d{8})\b');
          Match match = regExp.firstMatch(billPayment!.message[0].description)!;
          if (match != null) {
            extractedDate.value = match.group(1)!;
            log("Extracted date: ${extractedDate.value}");
            parsedDate = DateTime.parse(extractedDate.value);
          }
          getTransactionFee(selectedOption.value, price.value, 'APPBILL');
        } else if (decodedData['status'] == "99") {
          Get.back();
          Get.snackbar("Message", 'Reference unavailable, please try again later', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else if ((decodedData['status'] == "98")) {
          Get.back();
          Get.snackbar("Message", 'No pending bills. ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else {
          Get.back();
          Get.snackbar("Message", 'Service unavailable, pelase try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
      } else {
        log("ERROR verifyCeetRefIDfromInput ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.back();
      log('verifyCeetRefIDfromInput $e');
      RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
    }
  }

  verifySolergieRefIDfromInput({required String refId}) async {
    FullScreenLoading.fullScreenLoadingWithTextAndTimer('Validating Reference ID. . .');
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
          <message i:type="d:string">VRFY SOL $refId</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestToken>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      log('verifySolergieRefIDfromInput 0 ${request.body}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('verifySolergieRefIDfromInput result 0 $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenReturn').single;
        var jsonString = soapElement.innerText;
        log('verifySolergieRefIDfromInput jsonString 1 ${jsonString.toString()}');
        var decodedData = jsonDecode(jsonString);
        log('verifySolergieRefIDfromInput 2 decodedData ${decodedData.toString()}');

        if (decodedData['status'] == "0") {
          Get.back();
          billPayment = BillPayment.fromJson(decodedData);
          price.value = billPayment!.message[0].price;
          RegExp regExp = RegExp(r'\b(\d{8})\b');
          Match match = regExp.firstMatch(billPayment!.message[0].description)!;
          if (match != null) {
            extractedDate.value = match.group(1)!;
            log("Extracted date: ${extractedDate.value}");
            parsedDate = DateTime.parse(extractedDate.value);
          }
          getTransactionFee(selectedOption.value, price.value, 'APPBILL');
        } else if (decodedData['status'] == "99") {
          Get.back();
          Get.snackbar("Message", 'Reference unavailable, please try again later', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else if ((decodedData['status'] == "98")) {
          Get.back();
          Get.snackbar("Message", 'No pending bills. ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        } else {
          Get.back();
          Get.snackbar("Message", 'Service unavailable, please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
        }
      } else {
        log("ERROR verifySolergieRefIDfromInput ${response.reasonPhrase}");
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      log('verifyCeetRefIDfromInput $e');
      Get.snackbar("Message", 'An Error Occured, Please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
    }
  }

  verifyCeetRefIDfromSaved() async {
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
          <message i:type="d:string">VRFY CEET ${selectDatum!.reference}</message>
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
        Get.back();
        RechargeMenuDialog.showMessageDialog(message: jsonString);
      } else {
        log("ERROR verifyCeetRefIDfromSaved ${response.reasonPhrase}'");
      }
    } catch (e) {
      log('transactInternetRechargeOwn $e');
    }
  }

  getTransactionFee(String destmsisdn, String price, String keywords) async {
    // FullScreenLoading.fullScreenLoading();
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
          <n0:getTransactionFee xmlns:n0="http://applicationmanager.tlc.com">
              <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
              <destmsisdn i:type="d:string">$destmsisdn</destmsisdn>
              <keyword i:type="d:string">$keywords</keyword>
              <value i:type="d:string">$price</value>
          </n0:getTransactionFee>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('getTransactionFeeReturn').single;
        var jsonString = soapElement.innerText;
        Map<String, dynamic> jsonData = jsonDecode(jsonString);

        transactionFee = TransactionFee.fromJson(jsonData);
        senderkeycosttotal.value = transactionFee!.senderkeycosttotal;
        senderkeycosttva.value = transactionFee!.senderkeycosttva;
        totalFess.value = int.parse(senderkeycosttotal.value.replaceAll(',', '')) - int.parse(senderkeycosttva.value.replaceAll(',', ''));
        totalAmount.value = int.parse(price) + int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        // Get.back();
        Get.back();
        EnergiesEnterOtpBottomSheet.showBottomSheetOTPCEET();
      } else {
        // Get.back();
        log("ERROR getTransactionFee ${response.reasonPhrase}");
        Get.back();
        Get.snackbar("Message", 'Service unavailable, please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      log('getTransactionFee $e');
      Get.snackbar("Message", 'An Error Occured, Please try again later ', backgroundColor: Colors.lightBlue, colorText: Colors.white);
    }
  }

  sentBillPaymentRequest(String billType, String billRef, String pice, String password) async {
    // FullScreenLoading.fullScreenLoading();
    try {
      var headers = {'Content-Type': 'application/xml'};
      var request = http.Request('POST', Uri.parse('https://flooznfctest.moov-africa.tg/WebReceive?wsdl'));
      request.body = '''<v:Envelope xmlns:i="http://www.w3.org/2001/XMLSchema-instance" 
          xmlns:d="http://www.w3.org/2001/XMLSchema" 
          xmlns:c="http://schemas.xmlsoap.org/soap/encoding/" 
          xmlns:v="http://schemas.xmlsoap.org/soap/envelope/">
          <v:Header />
          <v:Body>
            <n0:RequestTokenJson xmlns:n0="http://applicationmanager.tlc.com">
          <msisdn i:type="d:string">${Get.find<StorageServices>().storage.read('msisdn')}</msisdn>
          <message i:type="d:string">$billType $billRef $price $password F</message>
          <token i:type="d:string">${Get.find<DevicePlatformServices>().deviceID}</token>
          <sendsms i:type="d:string">true</sendsms>
          </n0:RequestTokenJson>
          </v:Body>
          </v:Envelope>''';
      request.headers.addAll(headers);
      log('request.body  ${request.body}');
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log('result  $result');
        var parseResult = "'''$result'''";
        var document = xml.XmlDocument.parse(parseResult);
        var soapElement = document.findAllElements('RequestTokenJsonReturn').single;
        var jsonString = soapElement.innerText;
        var decodedData = jsonDecode(jsonString);
        log('jsonString  $jsonString');
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        log('jsonData  $jsonData');
        //60001
        if (decodedData['msgid'] == 0) {
          Get.back();
          thisDsonString.value = jsonString;
          Get.toNamed(AppRoutes.PAYMENTSUCCESS);
        } else if (decodedData['msgid'] == 5) {
          Get.back();
          errorMessage.value = decodedData['message'];
          Get.snackbar("Message", decodedData['message'], backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
        } else {
          Get.back();
          errorMessage.value = decodedData['message'];
          Get.toNamed(AppRoutes.PAYMENTFAILED);
        }
        // transactionFee = TransactionFee.fromJson(jsonData);
        // senderkeycosttotal.value = transactionFee!.senderkeycosttotal;
        // senderkeycosttva.value = transactionFee!.senderkeycosttva;
        // totalFess.value = int.parse(senderkeycosttotal.value.replaceAll(',', '')) - int.parse(senderkeycosttva.value.replaceAll(',', ''));
        // totalAmount.value = int.parse(price) + int.parse(senderkeycosttotal.value.replaceAll(',', ''));

        // PaymentEnterOtpBottomSheet.showBottomSheetOTPCEET();
      } else {
        Get.back();
        log("ERROR getTransactionFee ${response.reasonPhrase}");
        RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
      }
    } catch (e) {
      Get.back();
      log('getTransactionFee $e');
      RechargeMenuDialog.showMessageDialog(message: 'An Error Occured, Please try again later');
    }
  }

  logout() async {
    await Get.find<StorageServices>().storage.remove('msisdn').then((value) {
      Get.find<StorageServices>().storage.remove('isPrivacyCheck');
      Get.find<StorageServices>().storage.remove('isLoginSuccessClick');
      Get.find<StorageServices>().clearUserLocalData();
      Get.find<StorageServices>().clearUsersInformation();
      Get.offAllNamed(AppRoutes.LOGIN);
      Future.delayed(const Duration(seconds: 2), () {
        LoginAlertdialog.showMessageVersionNotUpToDate(controller: Get.find<LoginController>());
      });
    });
  }

  Future<void> resetVariables() async {
    numberTextField.clear();
    amountTextField.clear();
    code.clear();
    senderkeycosttotal.value = '';
    senderkeycosttva.value = '';
    totalFess.value = 0;
    totalAmount.value = 0;
    parsedDate = null;
    extractedDate.value = '';

    ceetProductList.clear();
    ceetDataList.clear();

    ceetPackageRadioGroupValue.value = '';
    keyword.value = '';

    selectedOption.value = '';
    selectDatum = null;
    billPayment = null;
    List<WalletAction> walletChild = [
      WalletAction(
        name: 'CEET',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.electricity,
      ),
      WalletAction(
        name: 'Cash Power',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.electricity,
      ),
      WalletAction(
        name: 'TDE',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.sun,
      ),
      WalletAction(
        name: 'Solergie',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.sun,
      ),
      WalletAction(
        name: 'BBox Cizo',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.wallet,
      ),
      WalletAction(
        name: 'Soleva',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.watch,
      ),
      WalletAction(
        name: 'Moon',
        description: 'Gorem ipsum dolor sit amet, co...',
        icon: FluIcons.moon,
      ),
    ];
    price.value = '';
    transactionFee = null;
    billType.value = 'APPBILL CEET';
    billRef.value = '';

    thisDsonString.value = '';
    errorMessage.value = '';
  }
}
