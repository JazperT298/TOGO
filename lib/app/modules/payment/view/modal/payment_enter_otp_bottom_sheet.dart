import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class PaymentEnterOtpBottomSheet {
  static showBottomSheetOTPCEET() {
    var controller = Get.find<PaymentController>();
    log(controller.selectedOption.value);
    Get.bottomSheet(
      Container(
        height: 65.h,
        width: 100.w,
        decoration:
            const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
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
                child: Obx(() => controller.selectedOption.value == "CEET"
                    ? RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Bill payment ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '\n${controller.selectedOption.value} ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF295fe7),
                            ),
                          ),
                          TextSpan(
                            text: 'of ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: Flu.formatDate(DateTime.now(), 'MM/yyyy').toUpperCase(),
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
                            text: 'Recharge other ',
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
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  'Equipment'.toUpperCase(),
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Expanded(
              //         child: Text(
              //           "Name",
              //           style: TextStyle(fontSize: M3FontSizes.bodyLarge, color: Colors.grey),
              //         ),
              //       ),
              //       Expanded(
              //         child: Text(
              //           // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
              //           '',
              //           style: TextStyle(
              //             fontSize: 14.sp,
              //             // color: context.colorScheme.onSurface,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 1.h,
              // ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Number",
                        style: TextStyle(fontSize: M3FontSizes.bodyLarge, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                        // controller.selectDatum!.reference,
                        controller.billPayment!.message[0].productname,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Get.context!.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: DottedLine(
                    dashLength: 5.w,
                    dashColor: Colors.grey,
                  )),
              SizedBox(
                height: 4.h,
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
                    const Expanded(
                      child: Text(
                        "Frais",
                        style: TextStyle(fontSize: M3FontSizes.bodyLarge, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                        '${controller.billPayment!.message[0].price} FCFA',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Get.context!.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Montant",
                        style: TextStyle(fontSize: M3FontSizes.bodyLarge, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                        '${controller.billPayment!.message[0].price} FCFA',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Get.context!.colorScheme.onSurface,
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
                child: FluTextField(
                  textAlign: TextAlign.center,
                  inputController: controller.code,
                  hint: "Enter PIN code", // "Montant à envoyer",
                  hintStyle: TextStyle(fontSize: 11.sp),
                  textStyle: TextStyle(fontSize: 11.sp),
                  height: 50,
                  cornerRadius: 15,
                  keyboardType: TextInputType.number,
                  fillColor: const Color(0xFFf4f5fa),
                  onChanged: (text) {},
                  onFieldSubmitted: (p0) {
                    if (controller.code.text.isNotEmpty) {
                      if (controller.selectedOption.value == "CEET") {
                      } else {}
                    } else {
                      Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
                  'Validate',
                  suffixIcon: FluIcons.checkCircleUnicon,
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    if (controller.code.text.isNotEmpty) {
                      if (controller.selectedOption.value == "For myself") {
                        // controller.verifyAndroidInternet(code: controller.code.text, msisdn: Get.find<StorageServices>().storage.read('msisdn'));
                      } else {
                        // controller.verifyAndroidInternet(code: controller.code.text, msisdn: controller.numberTextField.text);
                      }
                    } else {
                      Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
