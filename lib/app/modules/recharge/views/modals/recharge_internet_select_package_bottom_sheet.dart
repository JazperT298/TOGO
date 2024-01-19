import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';
import 'recharge_internet_otp_bottom_sheet.dart';

class RechargeInternetSelectPackageBottomSheet {
  static void showBottomSheetSelectPackageAmount() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(Container(
      height: 80.h,
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
                "INTERNET".toUpperCase(),
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
              child: Obx(
                () => controller.selectedOption.value == "For myself"
                    ? Text(
                        "For My Self.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )
                    : Text(
                        "For Others.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "Please select product.",
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

            // Padding(
            //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
            //   child: Container(
            //     height: 6.h,
            //     width: 100.w,
            //     decoration: BoxDecoration(
            //         color: Colors.lightBlue[100],
            //         borderRadius: BorderRadius.circular(8)),
            //     child: Obx(() => DropdownButton<InternetProducts>(
            //           value: controller.productSelected,
            //           padding: EdgeInsets.only(left: 3.w),
            //           underline: const SizedBox(),
            //           elevation: 16,
            //           isExpanded: true,
            //           onChanged: (InternetProducts? value) {
            //             // This is called when the user selects an item.
            //             controller.productSelected = value;
            //           },
            //           items: controller.productsList
            //               .map<DropdownMenuItem<InternetProducts>>(
            //                   (InternetProducts product) {
            //             return DropdownMenuItem<InternetProducts>(
            //               value: product,
            //               child: Text(product.description),
            //             );
            //           }).toList(),
            //         )),
            //   ),
            // ),

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
                  if (controller.amountTextField.text.isEmpty) {
                    Get.snackbar("Message", "Montant invalide",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else if (controller.amountTextField.text.length > 8) {
                    Get.snackbar("Message", "Montant invalide",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else if (double.parse(controller.amountTextField.text) <=
                      0) {
                    Get.snackbar("Message", "Montant invalide",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  } else {
                    Get.back();
                    RechargeInternetOTPBottomSheet.showBottomSheetOTP();
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
