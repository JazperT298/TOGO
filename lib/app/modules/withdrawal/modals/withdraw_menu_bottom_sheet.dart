// ignore_for_file: unused_import

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_input_bottom_sheet.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_otp_bottom_sheet.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_select_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:sizer/sizer.dart';


class WithdrawMenuBottomSheets {
  static void showBottomSheetWithdrawMenu() {
    final controller = Get.put(WithdrawalController());
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: 52.h,
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
                      child: Text(
                        'Withdrawal of money'.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        'Yorem ipsum dolor sit amet, adipiscing elit.',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                      ),
                    ),
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
                    InkWell(
                      onTap: () {
                        Get.back();
                        AppGlobal.siOTPPage = false;
                        AppGlobal.dateNow = '';
                        AppGlobal.timeNow = '';
                        controller.code.clear();
                        controller.amounts.clear();
                        controller.checkPendingCashout();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Container(
                            height: 9.h,
                            width: MediaQuery.of(Get.context!).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                            // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDBE4FB)),
                                  child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                                ),
                                const SizedBox(width: 8),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Normal withdrawal',
                                      style: TextStyle(fontSize: 14, color: Color(0xFF27303F), fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Worem ipsum dolor sit amet ...',
                                      style: TextStyle(fontSize: 14, color: Color(0xFF687997), fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ).paddingOnly(bottom: 12),
                    InkWell(
                      onTap: () {
                        Get.back();
                        AppGlobal.siOTPPage = false;
                        AppGlobal.dateNow = '';
                        AppGlobal.timeNow = '';
                        controller.code.clear();
                        controller.amounts.clear();
                        WithdrawOtpBottomSheet.showBottomSheetWithdrawCollectionOTP();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Container(
                            height: 9.h,
                            width: MediaQuery.of(Get.context!).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                            // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDBE4FB)),
                                  child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                                ),
                                const SizedBox(width: 8),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'WIthdrawal collection',
                                      style: TextStyle(fontSize: 14, color: Color(0xFF27303F), fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Worem ipsum dolor sit amet ...',
                                      style: TextStyle(fontSize: 14, color: Color(0xFF687997), fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ).paddingOnly(bottom: 12),
                    InkWell(
                      onTap: () {
                        Get.back();
                        controller.internetRadioGroupValue.value = '';
                        controller.selectedBank.value = '';
                        controller.code.clear();
                        controller.amounts.clear();
                        WithdrawSelectBottomSheet.showBottomSheetWithdrawCounterSelect();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Container(
                            height: 9.h,
                            width: MediaQuery.of(Get.context!).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                            // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDBE4FB)),
                                  child: const FluIcon(FluIcons.moneySend, size: 24, strokeWidth: 1.6, color: Colors.black),
                                ),
                                const SizedBox(width: 8),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Withdrawal counter',
                                      style: TextStyle(fontSize: 14, color: Color(0xFF27303F), fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Worem ipsum dolor sit amet ...',
                                      style: TextStyle(fontSize: 14, color: Color(0xFF687997), fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
