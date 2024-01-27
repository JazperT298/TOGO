import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class LoginAlertdialog {
  static showMessageVersionNotUpToDate({required LoginController controller}) async {
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

  static showSelectLanguageDialog(BuildContext context) {
    List<bool> selectedLanguages = [false, false]; // Index 0: English, Index 1: French

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(12), // Outside Padding
            contentPadding: const EdgeInsets.all(12), // Content Padding

            title: Text(LocaleKeys.strSelectLanguage.tr),
            content: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width - 60,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppImages.ukFlag, height: 30, width: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(LocaleKeys.strEnglish.tr),
                            ),
                          ],
                        ),
                        Checkbox(
                          value: AppGlobal.isSelectEnglish,
                          onChanged: (value) {
                            // English checkbox
                            setState(() {
                              selectedLanguages[1] = false;
                              AppGlobal.isSelectEnglish = true;
                              AppGlobal.isSelectFrench = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppImages.franceFlag, height: 30, width: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(LocaleKeys.strFrench.tr),
                            ),
                          ],
                        ),
                        Checkbox(
                          value: AppGlobal.isSelectFrench,
                          onChanged: (value) {
                            // French checkbox
                            setState(() {
                              AppGlobal.isSelectEnglish = false;
                              AppGlobal.isSelectFrench = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: AppGlobal.isSelectEnglish == false && AppGlobal.isSelectFrench == false
                    ? null
                    : () {
                        if (AppGlobal.isSelectFrench == true && AppGlobal.isSelectEnglish == false) {
                          Get.find<StorageServices>().saveLanguage(language: 'FR');
                        } else {
                          Get.find<StorageServices>().saveLanguage(language: 'EN');
                        }

                        Navigator.pop(context);
                      },
                child: Text(LocaleKeys.strSelect.tr),
              ),
            ],
          );
        });
      },
    ).then((value) {
      String enLang = Get.find<StorageServices>().storage.read('language');
      Get.updateLocale(Locale(enLang.toLowerCase()));
      AppGlobal.isSelectFrench = enLang == "FR" ? true : false;
      AppGlobal.isSelectEnglish = enLang == "EN" ? true : false;
      // setState(() {});
    });
  }
}
