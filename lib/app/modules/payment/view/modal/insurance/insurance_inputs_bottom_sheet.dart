// ignore_for_file: unnecessary_string_interpolations

import 'dart:developer';
import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/insurance/insurance_amounts_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/insurance/insurance_selection_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class InsuranceInputsBottomSheet {
  static void showBottomSheetInsuranceInputNumber() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: isKeyboardVisible ? 33.h : 42.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(
                          () => Text(
                            '${controller.selectedOption.value}'.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Enter your Moov phone number",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: FluTextField(
                                inputController: controller.numberTextField,
                                hint: 'Phone number',
                                hintStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                                textStyle:
                                    GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                                height: 6.5.h,
                                cornerRadius: 15,
                                keyboardType: TextInputType.number,
                                fillColor: const Color(0xFFf4f5fa),
                                onChanged: (text) {},
                                onFieldSubmitted: (p0) {
                                  log('NUM ${controller.numberTextField.text.length.toString()}');
                                  if (controller.numberTextField.text.isEmpty) {
                                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                                        backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  } else {
                                    Get.back();
                                    InsuranceSelectionBottomSheet.showBottomSheetInsuranceTypeSelectMenu(context);
                                    // if (controller.numberTextField.text.length == 4) {
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          right: 5.w,
                        ),
                        child: Visibility(
                          visible: isKeyboardVisible ? false : true,
                          child: FluButton.text(
                            LocaleKeys.strContinue.tr, //   'Continuer',
                            suffixIcon: FluIcons.arrowRight,
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              if (controller.numberTextField.text.isEmpty) {
                                Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              } else {
                                if (controller.numberTextField.text.length == 8 || controller.numberTextField.text.length == 11) {
                                  // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                  Get.back();
                                  InsuranceSelectionBottomSheet.showBottomSheetInsuranceTypeSelectMenu(context);
                                } else {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
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
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: FontSizes.buttonText),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  static void showBottomSheetInsuranceInputPolicy() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: isKeyboardVisible ? 33.h : 42.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(
                          () => Text(
                            '${controller.selectedOption.value}'.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Enter your policy number",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: FluTextField(
                                inputController: controller.numberTextField,
                                hint: 'Policy number',
                                hintStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                                textStyle:
                                    GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                                height: 6.5.h,
                                cornerRadius: 15,
                                keyboardType: TextInputType.number,
                                fillColor: const Color(0xFFf4f5fa),
                                onChanged: (text) {},
                                onFieldSubmitted: (p0) {
                                  log('NUM ${controller.numberTextField.text.length.toString()}');
                                  if (controller.numberTextField.text.isEmpty) {
                                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                                        backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  } else {
                                    Get.back();
                                    InsuranceAmountsBottomSheet.showBottomSheetInsuranceInputAmount();
                                    // if (controller.numberTextField.text.length == 4) {
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          right: 5.w,
                        ),
                        child: Visibility(
                          visible: isKeyboardVisible ? false : true,
                          child: FluButton.text(
                            LocaleKeys.strContinue.tr, //   'Continuer',
                            suffixIcon: FluIcons.arrowRight,
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              if (controller.numberTextField.text.isEmpty) {
                                Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              } else {
                                if (controller.numberTextField.text.length == 7 || controller.numberTextField.text.length == 8) {
                                  // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                  Get.back();
                                  InsuranceAmountsBottomSheet.showBottomSheetInsuranceInputAmount();
                                } else {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
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
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: FontSizes.buttonText),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
