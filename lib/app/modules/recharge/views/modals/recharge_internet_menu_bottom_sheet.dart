import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/app/modules/recharge/views/modals/recharge_voice_input_number_bottom_sheet.dart';
import 'package:ibank/app/modules/recharge/views/modals/recharge_voice_selected_package_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import 'recharge_internet_input_number_bottom_sheet.dart';
import 'recharge_internet_select_package_bottom_sheet.dart';

class RechargeInternetMainMenuBottomSheet {
  static void showBottomSheetRechargeInternetTo() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(Container(
      height: 35.h,
      width: 100.w,
      decoration:
          const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "RECHARGE".toUpperCase(),
                style: TextStyle(
                  color: const Color(0xFFfb6708),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "INTERNET",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "Do you want to recharge for yourself or others?",
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
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
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: GestureDetector(
                onTap: () {
                  Get.back();

                  controller.amountTextField.clear();
                  controller.code.clear();
                  controller.numberTextField.clear();
                  controller.selectedOption.value = 'For myself';
                  controller.internetProductType.value = 'All';
                  controller.internetRadioGroupValue.value = '';
                  RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      Container(
                        height: 7.h,
                        width: 12.w,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue[50]),
                        child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "OWN",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Recharge your Moov account.",
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  controller.amountTextField.clear();
                  controller.code.clear();
                  controller.numberTextField.clear();
                  controller.selectedOption.value = 'For others';
                  controller.internetProductType.value = 'All';
                  controller.internetRadioGroupValue.value = '';
                  RechargeInternetsInputNumberBottomSheet.showBottomSheetInputNumber();
                  // RechargeInternetSelectPackageBottomSheet
                  //     .showBottomSheetSelectPackage();
                },
                child: Row(
                  children: [
                    Container(
                      height: 7.h,
                      width: 12.w,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue[50]),
                      child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "OTHERS",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Enter the number and recharge for others.",
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  static void showBottomSheetRechargeVoicePackageTo() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(Container(
      height: 35.h,
      width: 100.w,
      decoration:
          const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "RECHARGE".toUpperCase(),
                style: TextStyle(
                  color: const Color(0xFFfb6708),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "VOICE PACKAGE",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "Do you want to recharge for yourself or others?",
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
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
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: GestureDetector(
                onTap: () {
                  Get.back();

                  controller.amountTextField.clear();
                  controller.code.clear();
                  controller.numberTextField.clear();
                  controller.selectedOption.value = 'For myself';
                  controller.voicePackageProductType.value = 'All';
                  controller.voicePackageRadioGroupValue.value = '';
                  RechargeVoiceSelectedPackageBottomSheet.showBottomSheetSelectPackage();
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      Container(
                        height: 7.h,
                        width: 12.w,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue[50]),
                        child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "For Myself",
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Recharge your Moov account.",
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  controller.amountTextField.clear();
                  controller.code.clear();
                  controller.numberTextField.clear();
                  controller.selectedOption.value = 'For others';
                  controller.voicePackageProductType.value = 'All';
                  controller.voicePackageRadioGroupValue.value = '';
                  RechargeVoiceInputNumberBottomSheet.showBottomSheetInputNumber();
                  // RechargeInternetSelectPackageBottomSheet
                  //     .showBottomSheetSelectPackage();
                },
                child: Row(
                  children: [
                    Container(
                      height: 7.h,
                      width: 12.w,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue[50]),
                      child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "For Others",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Enter the number and recharge for others.",
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}