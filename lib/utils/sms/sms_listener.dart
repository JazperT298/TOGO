// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/utils/constants/app_strings.dart';

abstract class SendSmsListener {
  bool onFailed(String why);
  bool onSent();
  bool onDelivered();
  bool onResponse(String sender, String message);
  bool onTimeout();
}

class SendSmsListeners implements SendSmsListener {
  @override
  bool onFailed(String why) {
    // Implementation  Fluttertoast.showToast(msg: finalResponseString, toastLength: Toast.LENGTH_LONG);
    showToast(Get.context!, why);
    return true;
  }

  @override
  bool onSent() {
    showToast(Get.context!, AppStrings.smssent);
    return true;
  }

  @override
  bool onDelivered() {
    showToast(Get.context!, AppStrings.smsdelivered);
    return true;
  }

  @override
  bool onResponse(String sender, String message) {
    // Implementation
    try {
      // if (option != SmsOption.HIDDEN) {
      //   Navigator.push(ctx, MaterialPageRoute(builder: (context) => HistoryActivity()));
      // } else {
      //   Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
      // }
    } catch (ex) {
      print('Error ${ex.toString()}');
    }
    return false;
  }

  @override
  bool onTimeout() {
    // Implementation  Fluttertoast.showToast(msg: 'Send Exception', toastLength: Toast.LENGTH_LONG);
    showToast(Get.context!, 'Send Exception');
    return true;
  }

  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
