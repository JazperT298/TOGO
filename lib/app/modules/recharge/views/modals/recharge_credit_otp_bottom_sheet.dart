import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class RechargeCreditOTPBottomSheet {
  static showBottomSheetOTP() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(Container(
      height: 60.h,
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
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                "SUMMARY".toUpperCase(),
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
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.strTransferNumber.tr, //'Number',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: controller.selectedOption.value == "For myself"
                        ? Text(
                            Get.find<StorageServices>().storage.read('msisdn'),
                            style: TextStyle(
                              fontSize: 14.sp,
                              // color: context.colorScheme.onSurface,
                            ),
                          )
                        : Text(
                            controller.numberTextField.text,
                            style: TextStyle(
                              fontSize: 14.sp,
                              // color: context.colorScheme.onSurface,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text(
                LocaleKeys.strTransferDetails.tr.toUpperCase(),
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.strTransferAmount.tr,
                      style: const TextStyle(
                          fontSize: M3FontSizes.bodyLarge, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${controller.amountTextField.text.toString()} FCFA',
                      style: TextStyle(
                        fontSize: 14.sp,
                        // color: context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
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
                textAlign: TextAlign.center,
                inputController: controller.code,
                hint: "Enter PIN code", // "Montant à envoyer",
                hintStyle: TextStyle(fontSize: 11.sp),
                textStyle: TextStyle(fontSize: 11.sp),
                height: 50,
                cornerRadius: 15,
                keyboardType: TextInputType.number,
                fillColor: Colors.lightBlue[100],
                onChanged: (text) {},
                onFieldSubmitted: (p0) {
                  if (controller.code.text.isNotEmpty) {
                    if (controller.selectedOption.value == "For myself") {
                      controller.verifyAndroid(
                          code: controller.code.text,
                          amount: controller.amountTextField.text,
                          msisdn: Get.find<StorageServices>()
                              .storage
                              .read('msisdn'));
                    } else {
                      controller.verifyAndroid(
                          code: controller.code.text,
                          amount: controller.amountTextField.text,
                          msisdn: controller.numberTextField.text);
                    }
                  } else {
                    Get.snackbar("Message", "Entrées manquantes",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
                  }
                },
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: FluButton.text(
                'Continuer',
                suffixIcon: FluIcons.passwordCheck,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (controller.code.text.isNotEmpty) {
                    if (controller.selectedOption.value == "For myself") {
                      controller.verifyAndroid(
                          code: controller.code.text,
                          amount: controller.amountTextField.text,
                          msisdn: Get.find<StorageServices>()
                              .storage
                              .read('msisdn'));
                    } else {
                      controller.verifyAndroid(
                          code: controller.code.text,
                          amount: controller.amountTextField.text,
                          msisdn: controller.numberTextField.text);
                    }
                  } else {
                    Get.snackbar("Message", "Entrées manquantes",
                        backgroundColor: Colors.lightBlue,
                        colorText: Colors.white);
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
          ],
        ),
      ),
    ));
  }
}
