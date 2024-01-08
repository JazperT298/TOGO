import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final numberController = TextEditingController().obs;

  RxString selectedCountryCode = '+228'.obs;
  RxBool isTextFieldEmpty = false.obs;

  final countryPicker = const FlCountryCodePicker().obs;
  // final countryCode = CountryCode().obs;
}
// https://flooznfctest.moov-africa.tg/kyctest/inquiry