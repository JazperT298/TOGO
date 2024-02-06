// ignore_for_file: unnecessary_string_interpolations

import 'dart:developer';
import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/services/android_verify_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

class InsuranceOtpBottomSheet {
  static showBottomSheetOTPInsurance() {
    var controller = Get.find<PaymentController>();
    log(controller.selectedOption.value);
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: isKeyboardVisible ? 67.h : 74.h,
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
                          "SUMMARY".toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: RichText(
                            text: TextSpan(children: [
                              // controller.selectedOption.value == 'Ecobankpay'
                              //     ? TextSpan(
                              //         text: '${controller.selectedOption.value} ',
                              //         style: GoogleFonts.montserrat(
                              //             fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              //       )
                              //     : TextSpan(
                              //         text: 'Merchant payment ',
                              //         style: GoogleFonts.montserrat(
                              //             fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              //       ),
                              TextSpan(
                                text: '${controller.selectedOption.value} ',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                              ),
                              TextSpan(
                                text: 'Insurance Payment ',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              ),
                            ]),
                          )),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          controller.selectedOption.value == 'BLI' ? 'beneficiary'.toUpperCase() : 'Merchant'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Obx(() => controller.selectedOption.value == 'BLI'
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: controller.selectedOption.value == 'Ecobankpay'
                                        ? Text(
                                            "Terminal ID",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                          )
                                        : Text(
                                            "Number",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                          ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                      // controller.selectDatum!.reference,
                                      controller.numberTextField.text,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedOption.value == 'BLI' ? const SizedBox.shrink() : SizedBox(height: 1.h)),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Policy ",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.insurancePolicyPackageRadioGroupValue.value.isEmpty
                                      ? controller.numberTextField.text
                                      : controller.insurancePolicyPackageRadioGroupValue.value,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      const LineSeparator(color: Colors.grey),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          LocaleKeys.strTransferDetails.tr.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Obx(() => controller.selectedOption.value == 'BLI'
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Contract Type ",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => Text(
                                        controller.insuranceTypePackageRadioGroupValue.value.isEmpty
                                            ? 'N/A'
                                            : controller.insuranceTypePackageRadioGroupValue.value,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedOption.value == 'BLI' ? const SizedBox.shrink() : SizedBox(height: 1.h)),
                      Obx(() => controller.selectedOption.value == 'BLI'
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Duration ",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => Text(
                                        controller.insuranceTermsPackageRadioGroupValue.value.isEmpty
                                            ? 'N/A'
                                            : controller.insuranceTermsPackageRadioGroupValue.value,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedOption.value == 'BLI' ? const SizedBox.shrink() : SizedBox(height: 1.h)),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Amount",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.insuranceTermsDescPackageRadioGroupValue.value.isEmpty
                                    ? controller.amountTextField.text
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.insuranceTermsDescPackageRadioGroupValue.value.replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Fees",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.totalFess.value == 0
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Tax',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.senderkeycosttva.isEmpty
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'TTC ',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.totalAmount.value == 0
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
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
                        child: FluTextField(
                          textAlign: TextAlign.center,
                          inputController: controller.code,
                          hint: "Your Flooz security code", // "Montant à envoyer",
                          hintStyle:
                              GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                          height: 6.5.h,
                          cornerRadius: 15,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFf4f5fa),
                          onChanged: (text) {},
                          onFieldSubmitted: (p0) async {
                            if (controller.code.text.isNotEmpty) {
                              bool verified = await Get.find<AndroidVerifyServices>().verifyAndroid();
                              if (verified) {
                                AppGlobal.dateNow = DateTime.now().toString();
                                AppGlobal.timeNow = DateTime.now().toString();
                                // controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                //     controller.price.value, controller.code.text);
                                controller.sendMerchantPaymentFinalHit(controller.referenceTextField.text.trim(), controller.numberTextField.text,
                                    controller.amountTextField.text, controller.code.text);
                              }
                            } else {
                              Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Visibility(
                          visible: isKeyboardVisible ? false : true,
                          child: FluButton.text(
                            'Validate',
                            suffixIcon: FluIcons.checkCircleUnicon,
                            iconStrokeWidth: 1.8,
                            onPressed: () async {
                              if (controller.code.text.isNotEmpty) {
                                bool verified = await Get.find<AndroidVerifyServices>().verifyAndroid();
                                if (verified) {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  controller.sendMerchantPaymentFinalHit(controller.referenceTextField.text.trim(), controller.numberTextField.text,
                                      controller.amountTextField.text, controller.code.text);
                                }
                              } else {
                                Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              }
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
                      SizedBox(
                        height: 3.h,
                      )
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
