import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

import 'recharge_credit_input_amount_bottom_sheet.dart';

class RechargeCreditInputNumberBottomSheet {
  static void showBottomSheetInputNumber() {
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
                "CREDIT".toUpperCase(),
                style: TextStyle(
                  color: Colors.orange[500],
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
                "For Others.",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "Please input number.",
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: FluLine(
                width: 100.w,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: FluTextField(
                inputController: controller.numberTextField,
                hint: "Enter number",
                hintStyle: TextStyle(fontSize: 11.sp),
                textStyle: TextStyle(fontSize: 11.sp),
                height: 50,
                cornerRadius: 15,
                keyboardType: TextInputType.number,
                fillColor: Colors.lightBlue[100],
                onChanged: (text) {},
                onFieldSubmitted: (p0) {
                  if (controller.numberTextField.text.isEmpty) {
                    Get.snackbar("Message", "Montant invalide",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else {
                    Get.back();
                    RechargeCreditInputAmountBottomSheet
                        .showBottomSheetInputAmount();
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
                'Continuer',
                suffixIcon: FluIcons.passwordCheck,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (controller.numberTextField.text.isEmpty) {
                    Get.snackbar("Message", "Numero invalide",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else {
                    if (controller.numberTextField.text.length == 8 ||
                        controller.numberTextField.text.length == 11) {
                      if (controller.numberTextField.text.length == 8) {
                        controller.numberTextField.text =
                            "228${controller.numberTextField.text}";
                        Get.back();
                        RechargeCreditInputAmountBottomSheet
                            .showBottomSheetInputAmount();
                      } else {
                        if (controller.numberTextField.text.substring(0, 3) ==
                            "228") {
                          Get.back();
                          RechargeCreditInputAmountBottomSheet
                              .showBottomSheetInputAmount();
                        } else {
                          Get.snackbar("Message", "Numero invalide",
                              backgroundColor: Colors.lightBlue,
                              colorText: Colors.white);
                        }
                      }
                    } else {
                      Get.snackbar("Message", "Numero invalide",
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
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
    ));
  }
}
