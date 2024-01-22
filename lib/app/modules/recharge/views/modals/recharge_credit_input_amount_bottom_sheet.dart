import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

import 'recharge_credit_otp_bottom_sheet.dart';

class RechargeCreditInputAmountBottomSheet {
  static void showBottomSheetInputAmount({required String selectedMenu}) {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(Container(
      height: 40.h,
      width: 100.w,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
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
                selectedMenu.toUpperCase(),
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
              child: Obx(() => controller.selectedOption.value == "For myself"
                  ? RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text:
                              'Please enter the amount you want to recharge your ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Moov ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF295fe7),
                          ),
                        ),
                        TextSpan(
                          text: 'account using ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Flooz.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFfb6708),
                          ),
                        )
                      ]),
                    )
                  : RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text:
                              'Please enter the amount you wish to recharge for ${controller.numberTextField.text} ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Moov ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF295fe7),
                          ),
                        ),
                        TextSpan(
                          text: 'account using ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Flooz.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFfb6708),
                          ),
                        )
                      ]),
                    )),
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
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: FluTextField(
                inputController: controller.amountTextField,
                hint: LocaleKeys.strEnterAmounts.tr, // "Enter amount",
                hintStyle: TextStyle(fontSize: 11.sp),
                textStyle: TextStyle(fontSize: 11.sp),
                height: 50,
                cornerRadius: 15,
                keyboardType: TextInputType.number,
                fillColor: const Color(0xFFf4f5fa),
                onChanged: (text) {},
                onFieldSubmitted: (p0) {
                  if (controller.amountTextField.text.isEmpty) {
                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else if (controller.amountTextField.text.length > 8) {
                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else if (double.parse(controller.amountTextField.text) <=
                      0) {
                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else {
                    Get.back();
                    RechargeCreditOTPBottomSheet.showBottomSheetOTP();
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
              child: FluButton.text(
                LocaleKeys.strContinue.tr.toString(),
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (controller.amountTextField.text.isEmpty) {
                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else if (controller.amountTextField.text.length > 8) {
                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else if (double.parse(controller.amountTextField.text) <=
                      0) {
                    Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr,
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else {
                    Get.back();
                    RechargeCreditOTPBottomSheet.showBottomSheetOTP();
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
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
    ));
  }
}
