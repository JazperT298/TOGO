// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ibank/utils/constants/app_integer.dart';
import 'package:ibank/utils/constants/app_string_validation.dart';
import 'package:ibank/utils/constants/big_dicimal.dart';
import 'package:ibank/utils/string_utils.dart';

class ParserValidator {
  static const int minMsisdnLength = 10;
  static const int maxAltMsisdnLength = 13;
  static const int minAltMsisdnLength = 11;
  static const int minPinLength = 4;
  static const int minPasswordLength = 6;

  static String? parseAmount(BuildContext context, TextEditingController unitController, TextEditingController centController) {
    try {
      double unit = double.parse(unitController.text);
      double cent = double.parse(centController.text);

      double totalAmount = unit + (cent / 100);
      if (!(totalAmount > 0)) {
        showToast(context, AppStringValidation.amountRequired);
        return null;
      }

      return totalAmount.toStringAsFixed(2);
    } catch (e) {
      showToast(context, AppStringValidation.amountRequired);
      return null;
    }
  }

  static String? parseReference(BuildContext context, TextEditingController unitController) {
    String str = unitController.text.trim();
    if (str.length < 8) {
      showToast(context, AppStringValidation.invalidreference);
      return null;
    }
    return str;
  }

  static String? parseMerchant(BuildContext context, TextEditingController unitController) {
    String str = unitController.text.trim();
    if (str.length < 8) {
      showToast(context, AppStringValidation.invalidmerchant);
      return null;
    }
    return str;
  }

  static String? parseMeterNumber(TextEditingController unitController, BuildContext context) {
    String str = unitController.text.trim();
    if (str.length < minMsisdnLength) {
      showToast(context, 'Invalid meter number');
      return null;
    }
    return str;
  }

  static String? parseSerialNumber(TextEditingController unitController, BuildContext context) {
    String str = unitController.text.trim();
    if (str.length < minMsisdnLength) {
      showToast(context, 'Invalid serial number');
      return null;
    }
    return str;
  }

  static String? parseConfirmMeterNumber(TextEditingController unitController, BuildContext context) {
    String str = unitController.text.trim();
    if (str.length < minMsisdnLength) {
      showToast(context, 'Invalid confirm meter number');
      return null;
    }
    return str;
  }

  static String? parseAmount2(TextEditingController unitsController, BuildContext context) {
    BigDecimal units;
    try {
      units = BigDecimal.parse(unitsController.text).setScale(0, BigDecimal.ROUND_CEILING);
    } catch (e) {
      units = BigDecimal.ZERO;
    }
    if (!(units.compareTo(BigDecimal.ZERO) > 0)) {
      showToast(context, 'Amount is required');
      return null;
    }
    return units.toString();
  }

  static String? parsePin(TextEditingController pinController, BuildContext context) {
    String str = pinController.text.trim();
    if (str.length < minPinLength) {
      showToast(context, 'Invalid pin');
      return null;
    }
    return str;
  }

  static String? parsePassword(TextEditingController passwordController, BuildContext context) {
    String str = passwordController.text.trim();
    if (str.length < minPasswordLength) {
      showToast(context, 'Invalid password');
      return null;
    }
    return str;
  }

  static String? parseNewPassword(TextEditingController newPasswordController, BuildContext context) {
    String str = newPasswordController.text.trim();
    if (str.length < minPasswordLength) {
      showToast(context, 'Invalid new password');
      return null;
    }
    return str;
  }

  static String? parseMsisdn(String msisdnController, BuildContext context) {
    String str = msisdnController.trim();
    print('parseMsisdn $str');
    if (str.length < AppInteger.minMsisdn) {
      showToast(context, 'Invalid destination');
      return null;
    }
    print('parseMsisdn $str');
    return str;
  }

  static String? parseRollNumber(TextEditingController msisdnController, BuildContext context) {
    String str = msisdnController.text.trim();
    if (str.length < minMsisdnLength) {
      showToast(context, 'Invalid roll number');
      return null;
    }
    return str;
  }

  static String? parseSchoolId(TextEditingController msisdnController, BuildContext context) {
    String str = msisdnController.text.trim();
    if (str.length < minMsisdnLength) {
      showToast(context, 'Invalid school ID');
      return null;
    }
    return str;
  }

  static String? parsePoliceNumber(TextEditingController msisdnController, BuildContext context) {
    String str = msisdnController.text.trim();
    if (str.length < minMsisdnLength) {
      showToast(context, 'Invalid police number');
      return null;
    }
    return str;
  }

  static String validateMsisdn(String countryCode, String msisdn, BuildContext context) {
    try {
      bool isValid = true;
      String tempMsisdn = ParserValidator.parseMsisdn(msisdn, context)!;
      if (StringUtil().isNullOrEmpty(tempMsisdn)) return "";

      tempMsisdn = tempMsisdn.replaceAll("+", "").replaceAll(" ", "");
      String newMsisdn = tempMsisdn;

      if (StringUtil().isNullOrEmpty(tempMsisdn)) {
        isValid = false;
      }
      if (tempMsisdn.length < AppInteger.minMsisdn) {
        isValid = false;
      }

      if (tempMsisdn.length == AppInteger.maxAltMsisdn) {
        String ctryCode = tempMsisdn.substring(0, 3);
        if (ctryCode != countryCode) {
          isValid = false;
        }
      } else if (tempMsisdn.length == AppInteger.minAltMsisdn) {
        newMsisdn = countryCode + tempMsisdn;
      } else {
        isValid = false;
      }
      if (!isValid) return "";
      log('newMsisdn $newMsisdn');
      return newMsisdn;
    } catch (ex) {
      print('validateMsisdn $ex');
      rethrow;
    }
  }

  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
