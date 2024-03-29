// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:sizer/sizer.dart';

import '../controller/home_controller.dart';

class HomeAlertDialog {
  static showOTPview({required HomeController controller}) async {
    TextEditingController code = TextEditingController();
    Get.dialog(AlertDialog(
        contentPadding: EdgeInsets.zero,
        actions: [
          TextButton(
              onPressed: () {
                if (code.text.isNotEmpty) {
                  controller.enterPinForInformationPersonelles(code: code.text);
                } else {
                  Get.snackbar("Message", LocaleKeys.strPasswordWarnings.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                }
              },
              child: Text(LocaleKeys.strContinue.tr.toUpperCase())),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(LocaleKeys.strCancel.tr.toUpperCase())),
        ],
        content: Container(
          height: MediaQuery.of(Get.context!).size.height * 0.25,
          width: MediaQuery.of(Get.context!).size.width,
          color: Colors.white,
          child: Obx(
            () => controller.isLoadingDialog.value == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.strEnterPinCode.tr, //  "ENTRER LE CODE PIN",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(Get.context!).size.height * 0.032,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(Get.context!).size.width * 0.05, right: MediaQuery.of(Get.context!).size.width * 0.05),
                        height: MediaQuery.of(Get.context!).size.height * 0.07,
                        width: MediaQuery.of(Get.context!).size.width,
                        child: TextField(
                          obscureText: true,
                          controller: code,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            fillColor: Colors.lightBlue[100],
                            filled: true,
                            contentPadding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.width * 0.03),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   child: OtpTextField(
                      //     obscureText: true,
                      //     numberOfFields: 8,
                      //     borderColor: Colors.lightBlue,
                      //     disabledBorderColor: Colors.black,
                      //     enabledBorderColor: Colors.lightBlue,
                      //     fillColor: Colors.lightBlue,
                      //     showFieldAsBox: true,
                      //     focusedBorderColor: Colors.lightBlue,
                      //     onCodeChanged: (String code) {},
                      //     onSubmit: (String verificationCode) async {
                      //       controller.enterPinForInformationPersonelles(
                      //           code: verificationCode);
                      //     }, // end onSubmit
                      //   ),
                      // ),

                      // Text(
                      //   message,
                      //   textAlign: TextAlign.center,
                      //   style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
                      // ),
                    ],
                  ),
          ),
        )));
  }

  static showMessageVersionNotUpToDate({required HomeController controller}) async {
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
                    child: Text(LocaleKeys.strUpdate.tr))
              ],
              content: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    LocaleKeys.strAppNoUptoDate.tr, //    "La version de l'application n'est pas à jour",
                    style: TextStyle(fontSize: 11.sp),
                  ),
                ),
              )),
        ),
        barrierDismissible: false);
  }
}
