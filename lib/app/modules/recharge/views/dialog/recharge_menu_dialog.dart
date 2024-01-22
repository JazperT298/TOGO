import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RechargeMenuDialog {
  static showMessageDialog({required String message}) async {
    Get.dialog(AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 11.sp),
            ),
          ),
        )));
  }
}
