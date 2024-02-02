// ignore_for_file: unused_local_variable

import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/home/controller/home_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

import '../../../../services/android_verify_services.dart';

class BalanceCheckBottomSheet {
  static void showBottomSheetInputNumber() {
    var controller = Get.find<HomeController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
          return Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: isKeyboardVisible ? 27.h : 33.h,
                width: 100.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Balance consultation".toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFB6404),
                              fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Norem ipsum dolor sit amet \nconsectetur ",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          FluLine(
                            width: 30.w,
                            color: const Color(0xFFfb6708),
                          ),
                          CircleAvatar(
                            radius: 1.w,
                            backgroundColor: const Color(0xFFfb6708),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluTextField(
                            inputController: controller.code,
                            hint: LocaleKeys
                                .strCodeSecret.tr, // "Votre code secret",
                            height: 6.5.h,
                            cornerRadius: 15,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            fillColor: const Color(0xFFF4F5FA),
                            cursorColor: const Color(0xFF27303F),
                            hintStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF27303F),
                                fontSize: FontSizes.textFieldText),
                            textStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: FontSizes.textFieldText),
                            onChanged: (text) {
                              String newText = text.replaceAll(' ', '');
                              String spacedText = newText.split('').join(' ');
                              controller.code.value =
                                  controller.code.value.copyWith(
                                text: spacedText,
                                selection: TextSelection.collapsed(
                                    offset: spacedText.length),
                              );
                            },
                            onFieldSubmitted: (p0) async {
                              if (controller.code.text.isNotEmpty) {
                                bool verified =
                                    await Get.find<AndroidVerifyServices>()
                                        .verifyAndroid();
                                if (verified) {
                                  String finalPINCode =
                                      controller.code.text.replaceAll(' ', '');
                                  controller.enterPinForInformationPersonelles(
                                      code: finalPINCode);
                                }
                              } else {
                                Get.snackbar("Message", "Entrées manquantes",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              }
                            }),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Visibility(
                          visible: isKeyboardVisible ? false : true,
                          child: FluButton.text(
                            'Validate',
                            suffixIcon: FluIcons.checkCircleUnicon,
                            iconStrokeWidth: 1.8,
                            onPressed: () async {
                              if (controller.code.text.isNotEmpty) {
                                bool verified =
                                    await Get.find<AndroidVerifyServices>()
                                        .verifyAndroid();
                                if (verified) {
                                  String finalPINCode =
                                      controller.code.text.replaceAll(' ', '');
                                  controller.enterPinForInformationPersonelles(
                                      code: finalPINCode);
                                }
                              } else {
                                Get.snackbar("Message", "Entrées manquantes",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              }
                            },
                            height: 7.h,
                            width: 100.w,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: Colors.blue[900],
                            foregroundColor: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 25,
                                spreadRadius: 3,
                                offset: Offset(0, 5),
                              )
                            ],
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSizes.buttonText),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
