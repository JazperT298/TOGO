import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/app/modules/recharge/views/modals/recharge_internet_select_package_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class RechargeInternetsInputNumberBottomSheet {
  static void showBottomSheetInputNumber() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Container(
          height: isKeyboardVisible ? 35.h : 45.h,
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
                  child: Text(
                    "Internet package for a third party".toUpperCase(),
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFB6404),
                        fontSize: 13.sp),
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "Yorem ipsum dolor sit amet, adipiscing elit.", //  "CREDIT",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 19.sp),
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
                  child: FluTextField(
                    inputController: controller.numberTextField,
                    hint: LocaleKeys.strEnterNumber.tr, // "Enter number",
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
                      if (controller.numberTextField.text.isEmpty) {
                        Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                            backgroundColor: Colors.lightBlue,
                            colorText: Colors.white);
                      } else {
                        if (controller.numberTextField.text.length == 8 ||
                            controller.numberTextField.text.length == 11) {
                          if (controller.numberTextField.text.length == 8) {
                            controller.numberTextField.text =
                                "228${controller.numberTextField.text}";
                            Get.back();
                            RechargeInternetSelectPackageBottomSheet
                                .showBottomSheetSelectPackage();
                          } else {
                            if (controller.numberTextField.text
                                    .substring(0, 3) ==
                                "228") {
                              Get.back();
                              RechargeInternetSelectPackageBottomSheet
                                  .showBottomSheetSelectPackage();
                            } else {
                              Get.snackbar(
                                  "Message", LocaleKeys.strInvalidNumber.tr,
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            }
                          }
                        } else {
                          Get.snackbar(
                              "Message", LocaleKeys.strInvalidNumber.tr,
                              backgroundColor: Colors.lightBlue,
                              colorText: Colors.white);
                        }
                      }
                    },
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
                          if (controller.numberTextField.text.length == 8 ||
                              controller.numberTextField.text.length == 11) {
                            if (controller.numberTextField.text.length == 8) {
                              controller.numberTextField.text =
                                  "228${controller.numberTextField.text}";
                              Get.back();
                              RechargeInternetSelectPackageBottomSheet
                                  .showBottomSheetSelectPackage();
                            } else {
                              if (controller.numberTextField.text
                                      .substring(0, 3) ==
                                  "228") {
                                Get.back();
                                RechargeInternetSelectPackageBottomSheet
                                    .showBottomSheetSelectPackage();
                              } else {
                                Get.snackbar(
                                    "Message", LocaleKeys.strInvalidNumber.tr,
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              }
                            }
                          } else {
                            Get.snackbar(
                                "Message", LocaleKeys.strInvalidNumber.tr,
                                backgroundColor: Colors.lightBlue,
                                colorText: Colors.white);
                          }
                        }
                      },
                      height: 7.h,
                      width: 100.w,
                      cornerRadius: UISettings.minButtonCornerRadius,
                      backgroundColor: const Color(0xFF124DE5),
                      foregroundColor: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 25,
                          spreadRadius: 3,
                          offset: Offset(0, 5),
                        )
                      ],
                      textStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFF4F5FA),
                          fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
