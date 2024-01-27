import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/login/alertdialog/login_alertdialog.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:sizer/sizer.dart';

class LoginSettingsBottomSheet {
  static void shoBottomSheetLoginSettings() {
    Get.bottomSheet(
      Container(
        height: 35.h,
        width: 100.w,
        decoration:
            const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(Get.context!).size.height * .025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text(
                        'Settings'.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.height * .025),
                        child: Text(
                          'You can configuration your app settings here.',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                        )),
                    Row(
                      children: [
                        FluLine(
                          width: 25.w,
                          color: Get.context!.colorScheme.secondary,
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(Get.context!).size.height * .035),
                        ),
                        CircleAvatar(
                          radius: 1.w,
                          backgroundColor: Get.context!.colorScheme.secondary,
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(Get.context!).size.height * .025),
                  child: FluButton(
                    onPressed: () {
                      LoginAlertdialog.showSelectLanguageDialog(Get.context!);
                    },
                    backgroundColor: Get.context!.colorScheme.background,
                    margin: const EdgeInsets.only(top: 12),
                    padding: EdgeInsets.zero,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(color: (Get.context!.colorScheme.primary).withOpacity(.045), shape: BoxShape.circle),
                                child: FluIcon(
                                  FluIcons.flag,
                                  size: 24,
                                  strokeWidth: 1.6,
                                  color: Get.context!.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            LocaleKeys.strLanguage.tr,
                            style: TextStyle(
                              fontSize: M3FontSizes.bodyLarge,
                              fontWeight: FontWeight.bold,
                              color: Get.context!.colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            LocaleKeys.strLanguageDesc.tr,
                            style: TextStyle(
                              color: Get.context!.colorScheme.onBackground.withOpacity(.75),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ])),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(Get.context!).size.height * .025),
                  child: FluButton(
                    onPressed: () {
                      // LoginAlertdialog.showSelectLanguageDialog(Get.context!);
                    },
                    backgroundColor: Get.context!.colorScheme.background,
                    margin: const EdgeInsets.only(top: 12),
                    padding: EdgeInsets.zero,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(color: (Get.context!.colorScheme.primary).withOpacity(.045), shape: BoxShape.circle),
                                child: FluIcon(
                                  FluIcons.fingerScan,
                                  size: 24,
                                  strokeWidth: 1.6,
                                  color: Get.context!.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(
                            'Login with biometrics',
                            style: TextStyle(
                              fontSize: M3FontSizes.bodyLarge,
                              fontWeight: FontWeight.bold,
                              color: Get.context!.colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'You may add extra security with facial recognition option to login to your account. This step is optional',
                            style: TextStyle(
                              color: Get.context!.colorScheme.onBackground.withOpacity(.75),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ])),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
