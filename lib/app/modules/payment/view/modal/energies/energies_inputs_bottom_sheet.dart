import 'dart:developer';
import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_amount_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_enter_otp_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_save_input_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_selection_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_service_link_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class EnergiesInputsBottomSheet {
  static void showBottomSheetCeetInputNumber() {
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
                          "Select or Enter an invoice reference",
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
                                hint: 'Enter the Ref of your invoice',
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
                                    // if (controller.numberTextField.text.length == 4) {
                                    controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                    // if (controller.numberTextField.text.length == 8) {
                                    //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                                    //   Get.back();
                                    //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                    // } else {
                                    //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                                    //     Get.back();
                                    //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                    //   } else {
                                    //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    //   }
                                    // }
                                    // } else {
                                    //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    // }
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                            ),
                            GestureDetector(
                              onTap: () {
                                EnergiesServiceLinksBottomSheet.showBottomSheetCeetServicePackageTo();
                                // Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                                // backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                              },
                              child: Container(
                                  height: 6.5.h,
                                  width: 13.w,
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                  decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child: const FluIcon(
                                    FluIcons.userSearch,
                                    size: 20,
                                    color: Colors.black,
                                  )),
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
                                if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                  controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
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

  static void showBottomSheetSolergieInputNumber() {
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
                        "Enter a reference",
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
                              hint: 'Reference',
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
                                EnergiesAmountBottomSheet.showBottomSheetSolevaInputAmount();
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

  static void showBottomSheetSolevaInputNumber() {
    var controller = Get.find<PaymentController>();
    controller.loadSolevaSubMenu();
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
                          "Select or Enter a reference",
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
                                hint: 'Reference',
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
                                    //check if the reference number is already exists then
                                    if (controller.isSubMenuExists(controller.numberTextField.text)) {
                                      //Go to input amount
                                      Get.back();
                                      EnergiesAmountBottomSheet.showBottomSheetSolevaInputAmount();
                                    } else {
                                      //Go to Save soleva select reference
                                      Get.back();
                                      EnergiesSaveInputBottomSheet.showBottomSheetSolevaInputTitle();
                                    }
                                    // if (controller.numberTextField.text.length == 4) {
                                    // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                    // if (controller.numberTextField.text.length == 8) {
                                    //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                                    //   Get.back();
                                    //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                    // } else {
                                    //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                                    //     Get.back();
                                    //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                    //   } else {
                                    //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    //   }
                                    // }
                                    // } else {
                                    //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    // }
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                            ),
                            GestureDetector(
                              onTap: () {
                                EnergiesSelectionBottomSheet.showBottomSheetPaymentSolevaSelectMenu(context);
                              },
                              child: Container(
                                  height: 6.5.h,
                                  width: 13.w,
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                  decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child: const FluIcon(
                                    FluIcons.bookmarkUnicon,
                                    size: 20,
                                    color: Colors.black,
                                  )),
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
                                //check if the reference numnber if already exists then
                                if (controller.isSubMenuExists(controller.numberTextField.text)) {
                                  //Go to input amount
                                  Get.back();
                                  EnergiesAmountBottomSheet.showBottomSheetSolevaInputAmount();
                                } else {
                                  //Go to Save soleva select reference
                                  Get.back();
                                  EnergiesSaveInputBottomSheet.showBottomSheetSolevaInputTitle();
                                }
                                // if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                //   controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                // } else {
                                //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                // }
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

  static void showBottomSheetCashPowerInputNumber() {
    var controller = Get.find<PaymentController>();
    controller.loadCashPowerSubMenu();
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
                          () => controller.selectedSubOption.value == 'Purchase'
                              ? Text(
                                  '${controller.selectedSubOption.value} ${controller.selectedOption.value}'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                )
                              : Text(
                                  '${controller.selectedOption.value} ${controller.selectedSubOption.value}'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() => controller.selectedSubOption.value == 'Purchase'
                            ? Text(
                                "Select or Enter a meter number",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              )
                            : Text(
                                "Select or Enter a counter number",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              )),
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
                                hint: 'Counter number',
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
                                    if (controller.selectedSubOption.value == 'Purchase') {
                                      //check if the counter number numnber if already exists then
                                      if (controller.isCashPowerSubMenuExists(controller.numberTextField.text)) {
                                        //Go to input amount
                                        Get.back();
                                        EnergiesAmountBottomSheet.showBottomSheetCashPowerInputAmount();
                                      } else {
                                        //Go to Save cash power select reference
                                        Get.back();
                                        EnergiesSaveInputBottomSheet.showBottomSheetCashPowerInputTitle();
                                      }
                                    } else {
                                      Get.back();
                                      EnergiesEnterOtpBottomSheet.showBottomSheetOTPCashPower();
                                    }

                                    // if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                    //   controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                    // } else {
                                    //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    // }
                                  }
                                  // if (controller.numberTextField.text.length == 4) {
                                  // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                  // if (controller.numberTextField.text.length == 8) {
                                  //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                                  //   Get.back();
                                  //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                  // } else {
                                  //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                                  //     Get.back();
                                  //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                  //   } else {
                                  //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  //   }
                                  // }
                                  // } else {
                                  //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  // }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                            ),
                            GestureDetector(
                              onTap: () {
                                EnergiesSelectionBottomSheet.showBottomSheetPaymentCashPowerSelectMenu(context);
                              },
                              child: Container(
                                  height: 6.5.h,
                                  width: 13.w,
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                  decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child: const FluIcon(
                                    FluIcons.bookmarkUnicon,
                                    size: 20,
                                    color: Colors.black,
                                  )),
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
                                if (controller.selectedSubOption.value == 'Purchase') {
                                  //check if the counter number numnber if already exists then
                                  if (controller.isCashPowerSubMenuExists(controller.numberTextField.text)) {
                                    //Go to input amount
                                    Get.back();
                                    EnergiesAmountBottomSheet.showBottomSheetCashPowerInputAmount();
                                  } else {
                                    //Go to Save cash power select reference
                                    Get.back();
                                    EnergiesSaveInputBottomSheet.showBottomSheetCashPowerInputTitle();
                                  }
                                } else {
                                  Get.back();
                                  EnergiesEnterOtpBottomSheet.showBottomSheetOTPCashPower();
                                }

                                // if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                //   controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                // } else {
                                //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                // }
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

  static void showBottomSheetBBoxCizoInputNumber() {
    var controller = Get.find<PaymentController>();
    controller.loadSolevaSubMenu();
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
                            'Payment ${controller.selectedOption.value}'.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(
                          () => controller.selectedBBoxCizeIndex.value == 0
                              ? Text(
                                  "Select or Enter an account number",
                                  style:
                                      GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                )
                              : Text(
                                  ",Enter the beneficiary account number",
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
                                hint: 'Account number',
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
                                    if (controller.selectedBBoxCizeIndex.value == 0) {
                                      //check if the reference number is already exists then
                                      if (controller.isBBoxCizeSubMenuExists(controller.numberTextField.text)) {
                                        //Go to input amount
                                        Get.back();
                                        EnergiesAmountBottomSheet.showBottomSheetBBoxCizoInputAmount();
                                      } else {
                                        //Go to Save soleva select reference
                                        Get.back();
                                        EnergiesSaveInputBottomSheet.showBottomSheetBBoxCizoInputTitle();
                                      }
                                    } else {
                                      Get.back();
                                      EnergiesAmountBottomSheet.showBottomSheetBBoxCizoInputAmount();
                                    }

                                    // if (controller.numberTextField.text.length == 4) {
                                    // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                    // if (controller.numberTextField.text.length == 8) {
                                    //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                                    //   Get.back();
                                    //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                    // } else {
                                    //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                                    //     Get.back();
                                    //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                    //   } else {
                                    //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    //   }
                                    // }
                                    // } else {
                                    //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    // }
                                  }
                                },
                              ),
                            ),
                            Obx(() => controller.selectedBBoxCizeIndex.value == 0
                                ? Padding(
                                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                    child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                                  )
                                : const SizedBox.shrink()),
                            Obx(() => controller.selectedBBoxCizeIndex.value == 0
                                ? GestureDetector(
                                    onTap: () {
                                      EnergiesSelectionBottomSheet.showBottomSheetPaymentBBoxCizoSelectMenu(context);
                                    },
                                    child: Container(
                                        height: 6.5.h,
                                        width: 13.w,
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                        decoration:
                                            const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                        child: const FluIcon(
                                          FluIcons.bookmarkUnicon,
                                          size: 20,
                                          color: Colors.black,
                                        )),
                                  )
                                : const SizedBox.shrink()),
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
                                if (controller.selectedBBoxCizeIndex.value == 0) {
                                  //check if the reference number is already exists then
                                  if (controller.isBBoxCizeSubMenuExists(controller.numberTextField.text)) {
                                    //Go to input amount
                                    Get.back();
                                    EnergiesAmountBottomSheet.showBottomSheetBBoxCizoInputAmount();
                                  } else {
                                    //Go to Save soleva select reference
                                    Get.back();
                                    EnergiesSaveInputBottomSheet.showBottomSheetBBoxCizoInputTitle();
                                  }
                                } else {
                                  Get.back();
                                  EnergiesAmountBottomSheet.showBottomSheetBBoxCizoInputAmount();
                                }
                                // if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                //   controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                // } else {
                                //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                // }
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

  static void showBottomSheetTDEInputNumber() {
    var controller = Get.find<PaymentController>();
    controller.loadTDESubMenu();
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
                          () => controller.selectedTDESubIndex.value == 0
                              ? Text(
                                  'Payment ${controller.selectedOption.value}'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                )
                              : controller.selectedTDESubIndex.value == 1
                                  ? Text(
                                      '${controller.selectedOption.value} payment for a third party'.toUpperCase(),
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
                        child: Obx(() => controller.selectedTDESubIndex.value == 1
                            ? Text(
                                "Enter the beneficiary’s subscriber reference",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              )
                            : Text(
                                "Select or Enter a subscriber reference",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              )),
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
                                hint: 'Subscriber reference',
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
                                    //check if the reference number is already exists then
                                    if (controller.isSubMenuExists(controller.numberTextField.text)) {
                                      //Go to input amount
                                      Get.back();
                                      EnergiesAmountBottomSheet.showBottomSheetTDEInputAmount();
                                    } else {
                                      //Go to Save soleva select reference
                                      Get.back();
                                      EnergiesSaveInputBottomSheet.showBottomSheetTDEInputTitle();
                                    }
                                    // if (controller.numberTextField.text.length == 4) {
                                    // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                    // if (controller.numberTextField.text.length == 8) {
                                    //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                                    //   Get.back();
                                    //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                    // } else {
                                    //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                                    //     Get.back();
                                    //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                    //   } else {
                                    //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    //   }
                                    // }
                                    // } else {
                                    //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    // }
                                  }
                                },
                              ),
                            ),
                            Obx(() => controller.selectedTDESubIndex.value == 1
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                    child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                                  )),
                            Obx(
                              () => controller.selectedTDESubIndex.value == 1
                                  ? const SizedBox.shrink()
                                  : GestureDetector(
                                      onTap: () {
                                        EnergiesSelectionBottomSheet.showBottomSheetPaymentTDESelectMenu(context);
                                      },
                                      child: Container(
                                          height: 6.5.h,
                                          width: 13.w,
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                          decoration:
                                              const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                          child: const FluIcon(
                                            FluIcons.bookmarkUnicon,
                                            size: 20,
                                            color: Colors.black,
                                          )),
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
                                if (controller.selectedTDESubIndex.value == 1) {
                                  Get.back();
                                  EnergiesAmountBottomSheet.showBottomSheetTDEInputAmount();
                                } else {
                                  //check if the reference numnber if already exists then
                                  if (controller.isTDESubMenuExists(controller.numberTextField.text)) {
                                    //Go to input amount
                                    Get.back();
                                    EnergiesAmountBottomSheet.showBottomSheetTDEInputAmount();
                                  } else {
                                    //Go to Save soleva select reference
                                    Get.back();
                                    EnergiesSaveInputBottomSheet.showBottomSheetTDEInputTitle();
                                  }
                                }

                                // if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                                //   controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                // } else {
                                //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                // }
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

  static void showBottomSheetMoonInputNumber() {
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
                          'Moon payment for a third party'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Enter the beneficiary's contract reference",
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
                              hint: 'Reference',
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
                                EnergiesAmountBottomSheet.showBottomSheetMoonInputAmount();
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
