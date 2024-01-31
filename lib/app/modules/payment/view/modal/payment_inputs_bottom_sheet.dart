import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_service_link_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class PaymentInputsBottomSheet {
  static void showBottomSheetCeetInputNumber() {
    var controller = Get.put(PaymentController());
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: isKeyboardVisible ? 33.h : 42.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () => Text(
                          'Payment ${controller.selectedOption.value}'
                              .toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFB6404),
                              fontSize: 13.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Select or Enter an invoice reference",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 19.sp),
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
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF27303F),
                                  fontSize: 12.sp),
                              textStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12.sp),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.number,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                                if (controller.numberTextField.text.isEmpty) {
                                  Get.snackbar(
                                      "Message", LocaleKeys.strInvalidNumber.tr,
                                      backgroundColor: Colors.lightBlue,
                                      colorText: Colors.white);
                                } else {
                                  // if (controller.numberTextField.text.length == 4) {
                                  controller.verifyCeetRefIDfromInput(
                                      refId: controller.numberTextField.text);
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
                            child: Container(
                                width: .5.w, color: Colors.grey, height: 3.5.h),
                          ),
                          GestureDetector(
                            onTap: () {
                              PaymentServiceLinksBottomSheet
                                  .showBottomSheetCeetServicePackageTo();
                              // Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                              // backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                            },
                            child: Container(
                                height: 6.5.h,
                                width: 13.w,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 4.0),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF4F5FA),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
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
                              Get.snackbar(
                                  "Message", LocaleKeys.strInvalidNumber.tr,
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            } else {
                              if (controller.numberTextField.text.length == 4 ||
                                  controller.numberTextField.text.length == 4) {
                                controller.verifyCeetRefIDfromInput(
                                    refId: controller.numberTextField.text);
                              } else {
                                Get.snackbar(
                                    "Message", LocaleKeys.strInvalidNumber.tr,
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              }
                            }
                          },
                          height: 55,
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
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: M3FontSizes.bodyLarge),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  static void showBottomSheetSolergieInputNumber() {
    var controller = Get.put(PaymentController());
    Get.bottomSheet(backgroundColor: Colors.transparent,
        KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Wrap(
        children: [
          bottomSheetDivider(),
          Container(
            height: isKeyboardVisible ? 25.h : 32.h,
            width: 100.w,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Obx(
                      () => Text(
                        'Payment ${controller.selectedOption.value}'
                            .toUpperCase(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFB6404),
                            fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "Enter a reference",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 22),
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
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                            textStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 14),
                            height: 50,
                            cornerRadius: 15,
                            keyboardType: TextInputType.number,
                            fillColor: const Color(0xFFf4f5fa),
                            onChanged: (text) {},
                            onFieldSubmitted: (p0) {
                              log('NUM ${controller.numberTextField.text.length.toString()}');
                              if (controller.numberTextField.text.isEmpty) {
                                Get.snackbar(
                                    "Message", LocaleKeys.strInvalidNumber.tr,
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              } else {
                                // if (controller.numberTextField.text.length == 4) {
                                controller.verifyCeetRefIDfromInput(
                                    refId: controller.numberTextField.text);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                              width: 1.5, color: Colors.grey, height: 20),
                        ),
                        GestureDetector(
                          onTap: () async {
                            PaymentServiceLinksBottomSheet
                                .showBottomSheetCeetServicePackageTo();
                            // Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                            // backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                          },
                          child: Container(
                              height: 45,
                              width:
                                  MediaQuery.of(Get.context!).size.width / 7.8,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 4.0),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF4F5FA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child:
                                  const FluIcon(FluIcons.userSearch, size: 20)),
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
                            Get.snackbar(
                                "Message", LocaleKeys.strInvalidNumber.tr,
                                backgroundColor: Colors.lightBlue,
                                colorText: Colors.white);
                          } else {
                            if (controller.numberTextField.text.length == 4 ||
                                controller.numberTextField.text.length == 4) {
                              controller.verifyCeetRefIDfromInput(
                                  refId: controller.numberTextField.text);
                            } else {
                              Get.snackbar(
                                  "Message", LocaleKeys.strInvalidNumber.tr,
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            }
                          }
                        },
                        height: 55,
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
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: M3FontSizes.bodyLarge),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }), isScrollControlled: true);
  }
}
