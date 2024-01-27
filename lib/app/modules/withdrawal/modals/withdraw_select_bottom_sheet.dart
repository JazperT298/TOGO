// ignore_for_file: unused_local_variable

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/app/modules/withdrawal/modals/withdraw_input_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class WithdrawSelectBottomSheet {
  static showBottomSheetWithdrawCollectionOTP() {
    var controller = Get.put(WithdrawalController());
    Get.bottomSheet(
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Container(
          height: isKeyboardVisible ? 42.h : 38.h,
          width: 100.w,
          decoration:
              const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 2.h
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Text(
                    "Counter withdrawal".toUpperCase(),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Text(
                    'Select a bank',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8),
                  child: Text(
                    "Morem ipsum dolor sit amet, consectetur adipiscing elit.",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
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
                      controller.internetRadioGroupValue.value = '1';
                      controller.selectedBank.value = 'Ecobank';
                    },
                    child: Container(
                      height: 8.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFe7edfc),
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
                                fontSize: 14.sp,
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
                                  }),
                            )
                          ],
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
                      onPressed: () {
                        Get.back();
                        WithdrawInputBottomSheet.showBottomSheeCountertWithdrawalInputNumber();
                        // if (controller.code.text.isNotEmpty) {
                        //   AppGlobal.dateNow = DateTime.now().toString();
                        //   AppGlobal.timeNow = DateTime.now().toString();
                        //   controller.enterPinToTransactWithdrawal(code: controller.code.text);
                        // } else {
                        //   Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                        // }
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
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      isScrollControlled: true,
    );
  }
}
