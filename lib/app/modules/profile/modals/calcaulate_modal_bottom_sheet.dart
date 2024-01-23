import 'dart:ffi';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/profile/controller/profile_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class CalculateBottomSheet {
  static void showBottomSheetInputNumber() {
    var controller = Get.find<ProfileController>();
    Get.bottomSheet(
      Container(
        height: 40.h,
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
                  "Calculate keycost".toUpperCase(),
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
                  "Enter the amount to calculate the fee.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
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
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: FluTextField(
                  inputController: controller.amountTextField,
                  hint: "Enter amount to calculate",
                  hintStyle: TextStyle(fontSize: 11.sp),
                  textStyle: TextStyle(fontSize: 11.sp),
                  height: 50,
                  cornerRadius: 15,
                  keyboardType: TextInputType.number,
                  fillColor: const Color(0xFFf4f5fa),
                  onChanged: (text) {},
                  onFieldSubmitted: (p0) {
                    if (controller.amountTextField.text.isEmpty) {
                      Get.snackbar("Message", 'Please input an amount', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                    } else {
                      Get.back();
                      controller.amountToCalculate(amount: controller.amountTextField.text);
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
                  LocaleKeys.strvalidate.tr, //   'Continuer',
                  suffixIcon: FluIcons.checkCircleUnicon,
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    if (controller.amountTextField.text.isEmpty) {
                      Get.snackbar("Message", 'Please input an amount', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                    } else {
                      Get.back();
                      controller.amountToCalculate(amount: controller.amountTextField.text);
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
                  textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
