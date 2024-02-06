import 'dart:developer';
import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/merchant_payment/merchant_payment_amount_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class MerchantPaymentInputsBottomSheet {
  static void showBottomSheetMerchantInputReference() {
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
                        child: Obx(() => Text(
                              '${controller.selectedOption.value} ${controller.selectedSubOption.value}'.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                            ))),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Enter the reference number",
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
                              inputController: controller.referenceTextField,
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
                                log('NUM ${controller.referenceTextField.text.length.toString()}');
                                if (controller.referenceTextField.text.isEmpty) {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                } else {
                                  controller.selectedOption.value = 'Physical payment';
                                  Get.back();
                                  showBottomSheetMerchantInputNumber();
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
                            if (controller.referenceTextField.text.isEmpty) {
                              Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            } else {
                              if (controller.referenceTextField.text.length == 4 || controller.referenceTextField.text.length == 4) {
                                // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                controller.selectedOption.value = 'Physical payment';
                                Get.back();
                                // EnergiesAmountBottomSheet.showBottomSheetMoonInputAmount();
                                showBottomSheetMerchantInputNumber();
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

  static void showBottomSheetMerchantInputNumber() {
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
                      child: Obx(() => Text(
                            '${controller.selectedOption.value} ${controller.selectedSubOption.value}'.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                          )),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Enter the merchant's Flooz number",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
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
                              inputController: controller.numberTextField,
                              hint: 'Merchant number',
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
                                  MerchantPaymentAmountsBottomSheet.showBottomSheetMerchantInputAmount();
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
                                // EnergiesAmountBottomSheet.showBottomSheetMoonInputAmount();
                                MerchantPaymentAmountsBottomSheet.showBottomSheetMerchantInputAmount();
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

  static void showBottomSheetMerchantEcobankInputReference() {
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
                        child: Obx(() => Text(
                              'Ecobankpay ${controller.selectedSubOption.value}'.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                            ))),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Enter the product reference number",
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
                              inputController: controller.referenceTextField,
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
                                log('NUM ${controller.referenceTextField.text.length.toString()}');
                                if (controller.referenceTextField.text.isEmpty) {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                } else {
                                  Get.back();
                                  showBottomSheetMerchantInputNumber();
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
                            if (controller.referenceTextField.text.isEmpty) {
                              Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            } else {
                              if (controller.referenceTextField.text.length == 4 || controller.referenceTextField.text.length == 4) {
                                // controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                Get.back();
                                // EnergiesAmountBottomSheet.showBottomSheetMoonInputAmount();
                                showBottomSheetMerchantEcobankInputNumber();
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

  static void showBottomSheetMerchantEcobankInputNumber() {
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
                      child: Obx(() => Text(
                            'Ecobankpay ${controller.selectedSubOption.value}'.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                          )),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Enter the merchant's terminal ID",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
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
                              inputController: controller.numberTextField,
                              hint: 'Terminal ID',
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
                                  MerchantPaymentAmountsBottomSheet.showBottomSheetMerchantEcobankInputAmount();
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
                                // EnergiesAmountBottomSheet.showBottomSheetMoonInputAmount();
                                MerchantPaymentAmountsBottomSheet.showBottomSheetMerchantEcobankInputAmount();
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
