// ignore_for_file: unused_import

import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_input_bottom_sheet.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_otp_bottom_sheet.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_select_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/fontsize_config.dart';

class WithdrawMenuBottomSheets {
  static void showBottomSheetWithdrawMenu() {
    final controller = Get.find<WithdrawalController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 54.h,
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
                        child: Text(
                          'Withdrawal of money'.toUpperCase(),
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
                          'Yorem ipsum dolor sit amet, adipiscing elit.',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      Row(
                        children: [
                          FluLine(
                            width: 25.w,
                            color: Get.context!.colorScheme.secondary,
                            height: 1,
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(Get.context!).size.height *
                                        .035),
                          ),
                          CircleAvatar(
                            radius: 1.w,
                            backgroundColor: Get.context!.colorScheme.secondary,
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          AppGlobal.siOTPPage = false;
                          AppGlobal.dateNow = '';
                          AppGlobal.timeNow = '';
                          controller.code.clear();
                          controller.amounts.clear();
                          controller.withdrawType.value = 'Normal';
                          controller.checkPendingCashout();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Container(
                              height: 9.h,
                              width: MediaQuery.of(Get.context!).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 4.0),
                              // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: Row(
                                children: [
                                  Container(
                                    height: 9.h,
                                    width: 20.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFDBE4FB)),
                                    child: const FluIcon(FluIcons.moneySend,
                                        size: 24,
                                        strokeWidth: 1.6,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 1.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Normal Withdrawal',
                                        style: GoogleFonts.montserrat(
                                            fontSize: FontSizes.headerSmallText,
                                            color: const Color(0xFF27303F),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Worem ipsum dolor sit amet ...',
                                        style: GoogleFonts.montserrat(
                                            fontSize: FontSizes.headerSmallText,
                                            color: const Color(0xFF687997),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ).paddingOnly(bottom: 1.5.h),
                      InkWell(
                        onTap: () async {
                          AppGlobal.siOTPPage = false;
                          AppGlobal.dateNow = '';
                          AppGlobal.timeNow = '';
                          controller.code.clear();
                          controller.amounts.clear();
                          FullScreenLoading.fullScreenLoadingWithTextAndTimer(
                              'Processing. . .');
                          await Future.delayed(const Duration(seconds: 2), () {
                            Get.back();
                            Get.back();
                            controller.withdrawType.value = 'Collection';
                            //controller.getTransactionFee();
                            WithdrawOtpBottomSheet
                                .showBottomSheetWithdrawCollectionOTP();
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Container(
                              height: 9.h,
                              width: MediaQuery.of(Get.context!).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 4.0),
                              // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: Row(
                                children: [
                                  Container(
                                    height: 9.h,
                                    width: 20.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFDBE4FB)),
                                    child: const FluIcon(FluIcons.moneySend,
                                        size: 24,
                                        strokeWidth: 1.6,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 1.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'WIthdrawal Collection',
                                        style: GoogleFonts.montserrat(
                                            fontSize: FontSizes.headerSmallText,
                                            color: const Color(0xFF27303F),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Worem ipsum dolor sit amet ...',
                                        style: GoogleFonts.montserrat(
                                            fontSize: FontSizes.headerSmallText,
                                            color: const Color(0xFF687997),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ).paddingOnly(bottom: 1.5.h),
                      InkWell(
                        onTap: () async {
                          controller.internetRadioGroupValue.value = '';
                          controller.selectedBank.value = '';
                          controller.code.clear();
                          controller.amounts.clear();
                          FullScreenLoading.fullScreenLoadingWithTextAndTimer(
                              'Processing. . .');
                          await Future.delayed(const Duration(seconds: 2), () {
                            Get.back();
                            Get.back();
                            controller.withdrawType.value = 'Counter';
                            controller.counterWithdrawalSelectedMessage.value =
                                '';
                            WithdrawSelectBottomSheet
                                .showBottomSheetWithdrawCounterSelect();
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Container(
                              height: 9.h,
                              width: MediaQuery.of(Get.context!).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 4.0),
                              // decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              child: Row(
                                children: [
                                  Container(
                                    height: 9.h,
                                    width: 20.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFDBE4FB)),
                                    child: const FluIcon(FluIcons.moneySend,
                                        size: 24,
                                        strokeWidth: 1.6,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 1.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Withdrawal Counter',
                                        style: GoogleFonts.montserrat(
                                            fontSize: FontSizes.headerSmallText,
                                            color: const Color(0xFF27303F),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Worem ipsum dolor sit amet ...',
                                        style: GoogleFonts.montserrat(
                                            fontSize: FontSizes.headerSmallText,
                                            color: const Color(0xFF687997),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
