// ignore_for_file: unused_local_variable

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
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/fontsize_config.dart';

class WithdrawSelectBottomSheet {
  static showBottomSheetWithdrawCounterSelect() {
    final controller = Get.find<WithdrawalController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                height: 44.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 2.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Counter withdrawal".toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Select a bank',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8),
                        child: Text(
                          "Morem ipsum dolor sit amet, consectetur adipiscing elit.",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(
                        height: 2.3.h,
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
                        height: 2.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                        child: GestureDetector(
                          onTap: () {
                            if (controller.internetRadioGroupValue.value == '1') {
                              controller.internetRadioGroupValue.value = '';
                              controller.selectedBank.value = '';
                              controller.counterWithdrawalSelectedMessage.value = '';
                            } else {
                              controller.internetRadioGroupValue.value = '1';
                              controller.selectedBank.value = 'Ecobank';
                              controller.counterWithdrawalSelectedMessage.value = 'COMPTE_ECOBANKCARDLESS';
                            }
                          },
                          child: Obx(
                            () => Container(
                              height: 8.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: controller.internetRadioGroupValue.value == '1' ? const Color(0xFFFEE8D9) : const Color(0xFFe7edfc),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 1.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ecobank',
                                      style: TextStyle(
                                        fontSize: FontSizes.headerMediumText,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Obx(
                                      () => Radio(
                                          value: '1',
                                          groupValue: controller.internetRadioGroupValue.value,
                                          onChanged: (value) {
                                            controller.internetRadioGroupValue.value = '1';
                                            controller.selectedBank.value = 'Ecobank';
                                            controller.counterWithdrawalSelectedMessage.value = 'COMPTE_ECOBANKCARDLESS';
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Visibility(
                          visible: isKeyboardVisible ? false : true,
                          child: FluButton.text(
                            'Confirm',
                            suffixIcon: FluIcons.checkCircleUnicon,
                            iconStrokeWidth: 1.8,
                            onPressed: () async {
                              if (controller.internetRadioGroupValue.value.isEmpty) {
                                Get.snackbar("Message", 'Please choose a bank', backgroundColor: Colors.red, colorText: Colors.white);
                              } else {
                                FullScreenLoading.fullScreenLoadingWithTextAndTimer('Validating request. . .');
                                await Future.delayed(const Duration(seconds: 2), () {
                                  controller.amounts.clear();
                                  controller.counterWithdrawalAmount.clear();
                                  Get.back();
                                  Get.back();
                                  WithdrawInputBottomSheet.showBottomSheeCountertWithdrawalInputNumber();
                                });
                              }

                              // if (controller.code.text.isNotEmpty) {
                              //   AppGlobal.dateNow = DateTime.now().toString();
                              //   AppGlobal.timeNow = DateTime.now().toString();
                              //   controller.enterPinToTransactWithdrawal(code: controller.code.text);
                              // } else {
                              //   Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // }
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      isScrollControlled: true,
    );
  }
}
