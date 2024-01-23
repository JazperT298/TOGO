import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:sizer/sizer.dart';

class LoginAlertdialog {
  static showMessageVersionNotUpToDate(
      {required LoginController controller}) async {
    Get.dialog(
        WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                    onPressed: () {
                      if (Platform.isIOS) {
                        Get.back();
                      } else {
                        controller.launch();
                      }
                    },
                    child: const Text("MISE À JOUR"))
              ],
              content: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "La version de l'application n'est pas à jour",
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
              )),
        ),
        barrierDismissible: false);
  }
}
