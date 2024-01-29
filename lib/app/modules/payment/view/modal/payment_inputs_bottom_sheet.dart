import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_service_link_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class PaymentInputsBottomSheet {
  static void showBottomSheetCeetInputNumber() {
    var controller = Get.put(PaymentController());
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Wrap(
        children: [
          bottomSheetDivider(),
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
                    child: Obx(
                      () => Text(
                        'Payment ${controller.selectedOption.value}'.toUpperCase(),
                        style: TextStyle(
                          color: const Color(0xFFfb6708),
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "Select or Enter an invoice reference",
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
                    child: Row(
                      children: [
                        Expanded(
                          child: FluTextField(
                            inputController: controller.numberTextField,
                            hint: 'Enter the Ref of your invoice',
                            hintStyle: TextStyle(fontSize: 11.sp),
                            textStyle: TextStyle(fontSize: 11.sp),
                            height: 50,
                            cornerRadius: 15,
                            keyboardType: TextInputType.number,
                            fillColor: const Color(0xFFf4f5fa),
                            onChanged: (text) {},
                            onFieldSubmitted: (p0) {
                              log('NUM ${controller.numberTextField.text.length.toString()}');
                              if (controller.numberTextField.text.isEmpty) {
                                Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              } else {
                                // if (controller.numberTextField.text.length == 4) {
                                controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                                // if (controller.numberTextField.text.length == 8) {
                                //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                                //   Get.back();
                                //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                // } else {
                                //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                                //     Get.back();
                                //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                                //   } else {
                                //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                //   }
                                // }
                                // } else {
                                //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                // }
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(width: 1.5, color: Colors.grey, height: 20),
                        ),
                        GestureDetector(
                          onTap: () async {
                            PaymentServiceLinksBottomSheet.showBottomSheetCeetServicePackageTo();
                            // Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                            // backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                          },
                          child: Container(
                              height: 45,
                              width: MediaQuery.of(Get.context!).size.width / 7.8,
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                  color: Get.context!.colorScheme.primaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                              child: const FluIcon(FluIcons.userSearch, size: 20)),
                        ),
                      ],
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
                      LocaleKeys.strContinue.tr, //   'Continuer',
                      suffixIcon: FluIcons.arrowRight,
                      iconStrokeWidth: 1.8,
                      onPressed: () {
                        if (controller.numberTextField.text.isEmpty) {
                          Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                        } else {
                          if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                            // if (controller.numberTextField.text.length == 8) {
                            //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                            //   Get.back();
                            //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                            // } else {
                            //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                            //     Get.back();
                            //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                            //   } else {
                            //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            //   }
                            // }
                            controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                          } else {
                            Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
        ],
      ),
    );
  }

  static void showBottomSheetSolergieInputNumber() {
    var controller = Get.put(PaymentController());
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
                child: Obx(
                  () => Text(
                    'Payment ${controller.selectedOption.value}'.toUpperCase(),
                    style: TextStyle(
                      color: const Color(0xFFfb6708),
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Enter a reference",
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
                child: Row(
                  children: [
                    Expanded(
                      child: FluTextField(
                        inputController: controller.numberTextField,
                        hint: 'Reference',
                        hintStyle: TextStyle(fontSize: 11.sp),
                        textStyle: TextStyle(fontSize: 11.sp),
                        height: 50,
                        cornerRadius: 15,
                        keyboardType: TextInputType.number,
                        fillColor: const Color(0xFFf4f5fa),
                        onChanged: (text) {},
                        onFieldSubmitted: (p0) {
                          log('NUM ${controller.numberTextField.text.length.toString()}');
                          if (controller.numberTextField.text.isEmpty) {
                            Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                          } else {
                            // if (controller.numberTextField.text.length == 4) {
                            controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                            // if (controller.numberTextField.text.length == 8) {
                            //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                            //   Get.back();
                            //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                            // } else {
                            //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                            //     Get.back();
                            //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                            //   } else {
                            //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            //   }
                            // }
                            // } else {
                            //   Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            // }
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(width: 1.5, color: Colors.grey, height: 20),
                    ),
                    GestureDetector(
                      onTap: () async {
                        PaymentServiceLinksBottomSheet.showBottomSheetCeetServicePackageTo();
                        // Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                        // backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                      },
                      child: Container(
                          height: 45,
                          width: MediaQuery.of(Get.context!).size.width / 7.8,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                          decoration: BoxDecoration(
                              color: Get.context!.colorScheme.primaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                          child: const FluIcon(FluIcons.userSearch, size: 20)),
                    ),
                  ],
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
                  LocaleKeys.strContinue.tr, //   'Continuer',
                  suffixIcon: FluIcons.arrowRight,
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    if (controller.numberTextField.text.isEmpty) {
                      Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                    } else {
                      if (controller.numberTextField.text.length == 4 || controller.numberTextField.text.length == 4) {
                        // if (controller.numberTextField.text.length == 8) {
                        //   controller.numberTextField.text = "228${controller.numberTextField.text}";
                        //   Get.back();
                        //   // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                        // } else {
                        //   if (controller.numberTextField.text.substring(0, 3) == "228") {
                        //     Get.back();
                        //     // RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
                        //   } else {
                        //     Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                        //   }
                        // }
                        controller.verifyCeetRefIDfromInput(refId: controller.numberTextField.text);
                      } else {
                        Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
