import 'dart:developer';
import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_enter_otp_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class EnergiesAmountBottomSheet {
  static void showBottomSheetSolergieInputAmount() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Solergie payment Solergie payment for ref 4521012578",
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
                              hint: 'Amount to be paid',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.number,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                                if (controller.numberTextField.text.isEmpty) {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                } else {
                                  Get.back();
                                  EnergiesEnterOtpBottomSheet.showBottomSheetOTPSolergie();
                                  // if (controller.numberTextField.text.length == 4) {
                                  // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                }
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
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
                              if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                Get.back();
                                EnergiesEnterOtpBottomSheet.showBottomSheetOTPSolergie();
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
    }), isScrollControlled: true);
  }

  static void showBottomSheetSolevaInputAmount() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Soleva payment for ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                            ),
                            TextSpan(
                              text: '\n${controller.solevaPackageRadioGroupValue.value} ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                            )
                          ]),
                        )),
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
                              inputController: controller.amountTextField,
                              hint: 'Amount to be paid',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.number,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                                if (controller.numberTextField.text.isEmpty) {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                } else {
                                  Get.back();
                                  EnergiesEnterOtpBottomSheet.showBottomSheetOTPSoleva();
                                  // if (controller.numberTextField.text.length == 4) {
                                  // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                }
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
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
                              if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                Get.back();
                                EnergiesEnterOtpBottomSheet.showBottomSheetOTPSoleva();
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
    }), isScrollControlled: true);
  }

  static void showBottomSheetCashPowerInputAmount() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Purchase of cash power for ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                            ),
                            controller.cashPowerPackageRadioGroupValue.value.isEmpty
                                ? TextSpan(
                                    text: '\n${controller.numberTextField.value.text} ',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                  )
                                : TextSpan(
                                    text: '\n${controller.cashPowerPackageRadioGroupValue.value} ',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                  )
                          ]),
                        )),
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
                              inputController: controller.amountTextField,
                              hint: 'Amount to be paid',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.number,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                                if (controller.numberTextField.text.isEmpty) {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                } else {
                                  Get.back();
                                  EnergiesEnterOtpBottomSheet.showBottomSheetOTPCashPower();
                                  // if (controller.numberTextField.text.length == 4) {
                                  // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                }
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
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
                              if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                Get.back();
                                EnergiesEnterOtpBottomSheet.showBottomSheetOTPCashPower();
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
    }), isScrollControlled: true);
  }

  static void showBottomSheetBBoxCizoInputAmount() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'BBox Cizo payment for ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                            ),
                            TextSpan(
                              text: '\n${controller.numberTextField.value.text} ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                            )
                          ]),
                        )),
                    // SizedBox(height: 1.h),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    //   child: Text(
                    //     'Which of your invoices do you want to make payment for?',
                    //     style:
                    //         GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                    //   ),
                    // ),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: FluTextField(
                              inputController: controller.amountTextField,
                              hint: 'Amount to be paid',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.number,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                                if (controller.numberTextField.text.isEmpty) {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                } else {
                                  Get.back();
                                  EnergiesEnterOtpBottomSheet.showBottomSheetOTPBBoxCizo();
                                  // if (controller.numberTextField.text.length == 4) {
                                  // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                }
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
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
                              if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                Get.back();
                                EnergiesEnterOtpBottomSheet.showBottomSheetOTPBBoxCizo();
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
    }), isScrollControlled: true);
  }

  static void showBottomSheetTDEInputAmount() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
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
                        () => controller.selectedTDESubIndex.value == 0
                            ? Text(
                                'Payment ${controller.selectedOption.value}'.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                              )
                            : controller.selectedTDESubIndex.value == 1
                                ? Text(
                                    'TDE payment for a third party'.toUpperCase(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                  )
                                : Text(
                                    'Consultation of unpaid debts'.toUpperCase(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                  ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Select an invoice ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                            ),
                            // TextSpan(
                            //   text: '\n${controller.tdePackageRadioGroupValue.value} ',
                            //   style: GoogleFonts.montserrat(
                            //       fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                            // )
                          ]),
                        )),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        'Which of your invoices do you want to make payment for?',
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
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
                    SizedBox(height: 3.h),
                    SizedBox(
                      height: 27.h,
                      width: 100.w,
                      child: ListView.builder(
                        itemCount: controller.tdePaymentModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                            child: GestureDetector(
                              onTap: () {
                                if (controller.tdePaymentRadioGroupValue.value == controller.tdePaymentModel[index].description) {
                                  controller.tdePaymentRadioGroupValue.value = '';
                                } else {
                                  controller.tdePaymentRadioGroupValue.value = controller.tdePaymentModel[index].description;
                                  controller.selectTDEPaymentModel = controller.tdePaymentModel[index];
                                }
                              },
                              child: Obx(
                                () => Container(
                                  height: 8.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    color: controller.tdePaymentRadioGroupValue.value == controller.tdePaymentModel[index].description
                                        ? const Color(0xFFFEE8D9)
                                        : const Color(0xFFe7edfc),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5.w, right: 1.w, bottom: 1.4.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.tdePaymentModel[index].title,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerLargeText),
                                            ).paddingOnly(bottom: .7.h),
                                            Text(
                                              controller.tdePaymentModel[index].description,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: FontSizes.headerSmallText),
                                            ),
                                          ],
                                        ),
                                        Obx(
                                          () => Radio(
                                              value: controller.tdePaymentModel[index].description,
                                              groupValue: controller.tdePaymentRadioGroupValue.value,
                                              onChanged: (value) {
                                                controller.tdePaymentRadioGroupValue.value = controller.tdePaymentModel[index].description;
                                                controller.selectTDEPaymentModel = controller.tdePaymentModel[index];
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 3.h),
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
                            if (controller.tdePaymentRadioGroupValue.value.isEmpty) {
                              Get.snackbar("Message", 'Please select an invoice', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            } else {
                              Get.back();
                              EnergiesEnterOtpBottomSheet.showBottomSheetOTPTDE();
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
    }), isScrollControlled: true);
  }

  static void showBottomSheetMoonInputAmount() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
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
                      child: Obx(() => controller.selectedOption.value == "Moon" && controller.selectedMoonSubIndex.value == 0
                          ? Text(
                              '${controller.selectedOption.value.toUpperCase()} CONFIRMATION SUBSCRIPTION',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                            )
                          : controller.selectedMoonSubIndex.value == 2
                              ? Text(
                                  'Moon payment for a third party'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                )
                              : Text(
                                  'PAYMENT ${controller.selectedOption.value.toUpperCase()}',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                )),
                    ),
                    SizedBox(height: 1.h),
                    Obx(
                      () => controller.selectedOption.value == "Moon" && controller.selectedMoonSubIndex.value == 0
                          ? Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Text(
                                "You are validating your subscription",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              ),
                            )
                          : controller.selectedMoonSubIndex.value == 0
                              ? Padding(
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                  child: Text(
                                    "Please enter the amount you wish to pay",
                                    style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                  child: Text(
                                    "Please enter the amount to pay.",
                                    style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                  ),
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
                              hint: 'Amount',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.number,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                                if (controller.numberTextField.text.isEmpty) {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                } else {
                                  Get.back();
                                  EnergiesEnterOtpBottomSheet.showBottomSheetOTPSolergie();
                                  // if (controller.numberTextField.text.length == 4) {
                                  // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                }
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
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
                              if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                Get.back();
                                EnergiesEnterOtpBottomSheet.showBottomSheetOTPSolergie();
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
    }), isScrollControlled: true);
  }
}
