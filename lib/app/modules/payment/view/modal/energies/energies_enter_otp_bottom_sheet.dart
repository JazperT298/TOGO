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

class EnergiesEnterOtpBottomSheet {
  static showBottomSheetOTPCEET() {
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
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() => controller.selectedOption.value == "CEET"
                            ? RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Bill payment ',
                                    style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                  ),
                                  TextSpan(
                                    text: '\n${controller.selectedOption.value} ',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                  ),
                                  TextSpan(
                                    text: 'of ',
                                    style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                  ),
                                  TextSpan(
                                    text: Flu.formatDate(controller.parsedDate!, 'MM/yyyy').toUpperCase(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600, color: const Color(0xFFFB6404), fontSize: FontSizes.headerLargeText),
                                  )
                                ]),
                              )
                            : RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Recharge other ',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Moov ',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF295fe7),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'account using ',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Flooz.',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFfb6708),
                                    ),
                                  )
                                ]),
                              )),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Equipment'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                "Number",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                // controller.selectDatum!.reference,
                                controller.billPayment!.message[0].productname,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
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
                                "Amount",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.price.value.isEmpty
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.price.value.replaceAll(',', '')))} FCFA',
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
                          hint: "Enter PIN code", // "Montant à envoyer",
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
                                if (controller.selectedOption.value == "CEET") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                      controller.price.value, controller.code.text);
                                }
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
                                  if (controller.selectedOption.value == "CEET") {
                                    AppGlobal.dateNow = DateTime.now().toString();
                                    AppGlobal.timeNow = DateTime.now().toString();
                                    controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                        controller.price.value, controller.code.text);
                                  }
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

  static showBottomSheetOTPCashPower() {
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
                        child: Obx(
                          () => controller.selectedSubOption.value == 'Purchase'
                              ? Text(
                                  "SUMMARY".toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                )
                              : Text(
                                  "${controller.selectedOption.value} ${controller.selectedSubOption.value}".toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Obx(
                            () => controller.selectedSubOption.value == 'Purchase'
                                ? RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Buying ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedOption.value} ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                      )
                                    ]),
                                  )
                                : RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Enter your code to receive your duplicate ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                      ),
                                    ]),
                                  ),
                          )),
                      Obx(() => controller.selectedSubOption.value == 'Purchase' ? SizedBox(height: 4.h) : SizedBox(height: 3.h)),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Text(
                                'Equipment'.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            )
                          : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase' ? SizedBox(height: 1.h) : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Number",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                      // controller.selectDatum!.reference,
                                      controller.amountTextField.text,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase' ? SizedBox(height: 4.h) : const SizedBox.shrink()),
                      Obx(
                        () => controller.selectedSubOption.value == 'Purchase'
                            ? const LineSeparator(color: Colors.grey)
                            : Row(
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
                      ),
                      Obx(() => controller.selectedSubOption.value == 'Purchase' ? SizedBox(height: 4.h) : SizedBox(height: 3.h)),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Text(
                                LocaleKeys.strTransferDetails.tr.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            )
                          : SizedBox.fromSize()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? SizedBox(
                              height: 2.h,
                            )
                          : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? Padding(
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
                                    child: Obx(
                                      () => Text(
                                        controller.price.value.isEmpty
                                            ? '0 FCFA'
                                            : '${StringHelper.formatNumberWithCommas(int.parse(controller.price.value.replaceAll(',', '')))} FCFA',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase' ? SizedBox(height: 1.h) : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? Padding(
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
                            )
                          : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase' ? SizedBox(height: 1.h) : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? Padding(
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
                            )
                          : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase' ? SizedBox(height: 1.h) : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? Padding(
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
                            )
                          : const SizedBox.shrink()),
                      Obx(() => controller.selectedSubOption.value == 'Purchase'
                          ? SizedBox(
                              height: 4.h,
                            )
                          : const SizedBox.shrink()),
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
                                if (controller.selectedOption.value == "CEET") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                      controller.price.value, controller.code.text);
                                }
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
                                  if (controller.selectedOption.value == "CEET") {
                                    AppGlobal.dateNow = DateTime.now().toString();
                                    AppGlobal.timeNow = DateTime.now().toString();
                                    controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                        controller.price.value, controller.code.text);
                                  }
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

  static showBottomSheetOTPTDE() {
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
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(
                          () => controller.selectedTDESubIndex.value == 0
                              ? RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: '${controller.selectedOption.value} ',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                    ),
                                    TextSpan(
                                      text: 'invoice payment of \n',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                    ),
                                    TextSpan(
                                      // text: Flu.formatDate(controller.parsedDate!, 'MM/yyyy').toUpperCase(),
                                      text: '12/2023',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFFFB6404), fontSize: FontSizes.headerLargeText),
                                    )
                                  ]),
                                )
                              : controller.selectedTDESubIndex.value == 1
                                  ? RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: '${controller.selectedOption.value} ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text: 'invoice payment of \n',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          // text: Flu.formatDate(controller.parsedDate!, 'MM/yyyy').toUpperCase(),
                                          text: '12/2023 ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600, color: const Color(0xFFFB6404), fontSize: FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text: 'for a ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text: 'third party',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                        ),
                                      ]),
                                    )
                                  : RichText(
                                      text: TextSpan(children: [
                                        // TextSpan(
                                        //   text: ' ',
                                        //   style: GoogleFonts.montserrat(
                                        //       fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                        // ),
                                        TextSpan(
                                          text: 'Consultation des impayés',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                        ),
                                        // TextSpan(
                                        //   // text: Flu.formatDate(controller.parsedDate!, 'MM/yyyy').toUpperCase(),
                                        //   text: '12/2023',
                                        //   style: GoogleFonts.montserrat(
                                        //       fontWeight: FontWeight.w600, color: const Color(0xFFFB6404), fontSize: FontSizes.headerLargeText),
                                        // )
                                      ]),
                                    ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Equipment'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                "Number",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                  // controller.selectDatum!.reference,
                                  controller.tdePaymentRadioGroupValue.value.isEmpty ? '' : controller.tdePaymentRadioGroupValue.value,
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
                                "Amount",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.price.value.isEmpty
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.price.value.replaceAll(',', '')))} FCFA',
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
                          hint: "Enter PIN code", // "Montant à envoyer",
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
                                if (controller.selectedOption.value == "CEET") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                      controller.price.value, controller.code.text);
                                }
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
                                  if (controller.selectedOption.value == "CEET") {
                                    AppGlobal.dateNow = DateTime.now().toString();
                                    AppGlobal.timeNow = DateTime.now().toString();
                                    controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                        controller.price.value, controller.code.text);
                                  }
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

  static showBottomSheetOTPSolergie() {
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
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() => controller.selectedOption.value == "Solergie"
                            ? RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Payment for ',
                                    style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                  ),
                                  TextSpan(
                                    text: '\n${controller.selectedOption.value} ',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                  ),
                                ]),
                              )
                            : RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Recharge other ',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Moov ',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF295fe7),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'account using ',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Flooz.',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFfb6708),
                                    ),
                                  )
                                ]),
                              )),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Equipment'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                "Number",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                // controller.selectDatum!.reference,
                                // controller.billPayment!.message[0].productname,
                                '',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
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
                                "Amount",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child:
                                  //  Obx(
                                  //   () =>
                                  Text(
                                '0 FCFA',
                                // controller.price.value.isEmpty
                                // ? '0 FCFA'
                                // : '${StringHelper.formatNumberWithCommas(int.parse(controller.price.value.replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                              // ),
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
                              child:
                                  //  Obx(
                                  //   () =>
                                  Text(
                                '0 FCFA',
                                // controller.totalFess.value == 0
                                //   ? '0 FCFA'
                                //     : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            // ),
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
                              child:
                                  //  Obx(
                                  //   () =>
                                  Text(
                                '0 FCFA',
                                // controller.senderkeycosttva.isEmpty
                                // ? '0 FCFA'
                                // : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                              // ),
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
                              child:
                                  // Obx(
                                  //   () =>
                                  Text(
                                //  controller.totalAmount.value == 0
                                // ?
                                '0 FCFA',
                                //: '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            // ),
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
                                if (controller.selectedOption.value == "CEET") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  // controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                  //     controller.price.value, controller.code.text);
                                }
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
                                  if (controller.selectedOption.value == "CEET") {
                                    AppGlobal.dateNow = DateTime.now().toString();
                                    AppGlobal.timeNow = DateTime.now().toString();
                                    // controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                    //     controller.price.value, controller.code.text);
                                  }
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

  static showBottomSheetOTPBBoxCizo() {
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
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() => controller.selectedBBoxCizeIndex.value == 0
                            ? RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: '\n${controller.selectedOption.value} ',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                  ),
                                  TextSpan(
                                    text: 'payment ',
                                    style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                  ),
                                ]),
                              )
                            : RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: '${controller.selectedOption.value} ',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                                  ),
                                  TextSpan(
                                    text: 'payment for a ',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'third party',
                                    style: TextStyle(
                                      fontSize: FontSizes.headerLargeText,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFfb6708),
                                    ),
                                  )
                                ]),
                              )),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Equipment'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                "Amount",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.price.value.isEmpty
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.price.value.replaceAll(',', '')))} FCFA',
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
                          hint: "Enter PIN code", // "Montant à envoyer",
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
                                if (controller.selectedOption.value == "CEET") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                      controller.price.value, controller.code.text);
                                }
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
                                  if (controller.selectedOption.value == "CEET") {
                                    AppGlobal.dateNow = DateTime.now().toString();
                                    AppGlobal.timeNow = DateTime.now().toString();
                                    controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                        controller.price.value, controller.code.text);
                                  }
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

  static showBottomSheetOTPSoleva() {
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
                      SizedBox(height: 2.h),
                      Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Payment ',
                                style: TextStyle(
                                  fontSize: FontSizes.headerLargeText,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '${controller.selectedOption.value} ',
                                style: TextStyle(
                                  fontSize: FontSizes.headerLargeText,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF295fe7),
                                ),
                              ),
                            ]),
                          )),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Equipment'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                "Number",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                // controller.selectDatum!.reference,
                                // controller.billPayment!.message[0].productname,
                                controller.numberTextField.text,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
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
                                "Amount",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child:
                                  //  Obx(
                                  //   () =>
                                  Text(
                                '0 FCFA',
                                // controller.price.value.isEmpty
                                // ? '0 FCFA'
                                // : '${StringHelper.formatNumberWithCommas(int.parse(controller.price.value.replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                              // ),
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
                              child:
                                  //  Obx(
                                  //   () =>
                                  Text(
                                '0 FCFA',
                                // controller.totalFess.value == 0
                                //   ? '0 FCFA'
                                //     : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            // ),
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
                              child:
                                  //  Obx(
                                  //   () =>
                                  Text(
                                '0 FCFA',
                                // controller.senderkeycosttva.isEmpty
                                // ? '0 FCFA'
                                // : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                              // ),
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
                              child:
                                  // Obx(
                                  //   () =>
                                  Text(
                                //  controller.totalAmount.value == 0
                                // ?
                                '0 FCFA',
                                //: '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            // ),
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
                                if (controller.selectedOption.value == "CEET") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  // controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                  //     controller.price.value, controller.code.text);
                                }
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
                                  if (controller.selectedOption.value == "CEET") {
                                    AppGlobal.dateNow = DateTime.now().toString();
                                    AppGlobal.timeNow = DateTime.now().toString();
                                    // controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                    //     controller.price.value, controller.code.text);
                                  }
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

  static showBottomSheetOTPMoon() {
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
                        child: Obx(
                          () => controller.selectedOption.value == "Moon" && controller.selectedMoonSubIndex.value == 0
                              ? Text(
                                  '${controller.selectedOption.value.toUpperCase()} CONFIRMATION SUBSCRIPTION',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                )
                              : Text(
                                  'Summary'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() => controller.selectedOption.value == "Moon" && controller.selectedMoonSubIndex.value == 0
                            ? RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'Please enter your security \ncode to validate. ',
                                    style:
                                        GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                                  ),
                                ]),
                              )
                            : controller.selectedMoonSubIndex.value == 2
                                ? RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: '${controller.selectedOption.value} ',
                                        style: TextStyle(
                                          fontSize: FontSizes.headerLargeText,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF295fe7),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'payment ',
                                        style: TextStyle(
                                          fontSize: FontSizes.headerLargeText,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'for a ',
                                        style: TextStyle(
                                          fontSize: FontSizes.headerLargeText,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'third party',
                                        style: TextStyle(
                                          fontSize: FontSizes.headerLargeText,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFfb6708),
                                        ),
                                      ),
                                    ]),
                                  )
                                : RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Payment ',
                                        style: TextStyle(
                                          fontSize: FontSizes.headerLargeText,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${controller.selectedOption.value} ',
                                        style: TextStyle(
                                          fontSize: FontSizes.headerLargeText,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF295fe7),
                                        ),
                                      ),
                                    ]),
                                  )),
                      ),
                      SizedBox(height: 4.h),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Text(
                                'Equipment'.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0 ? const SizedBox.shrink() : SizedBox(height: 1.h)),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Name",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                      // controller.selectDatum!.reference,
                                      // controller.billPayment!.message[0].productname,
                                      '',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0 ? const SizedBox.shrink() : SizedBox(height: 1.h)),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Ref. contract",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                      // controller.selectDatum!.reference,
                                      // controller.billPayment!.message[0].productname,
                                      '',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0 ? const SizedBox.shrink() : SizedBox(height: 4.h)),
                      Obx(() => controller.selectedMoonSubIndex.value == 0 ? const SizedBox.shrink() : const LineSeparator(color: Colors.grey)),
                      Obx(() => controller.selectedMoonSubIndex.value == 0 ? const SizedBox.shrink() : SizedBox(height: 4.h)),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Text(
                                LocaleKeys.strTransferDetails.tr.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: 2.h,
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : Padding(
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
                                    child:
                                        //  Obx(
                                        //   () =>
                                        Text(
                                      '0 FCFA',
                                      // controller.price.value.isEmpty
                                      // ? '0 FCFA'
                                      // : '${StringHelper.formatNumberWithCommas(int.parse(controller.price.value.replaceAll(',', '')))} FCFA',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                    // ),
                                  ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0 ? const SizedBox.shrink() : SizedBox(height: 1.h)),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : Padding(
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
                                    child:
                                        //  Obx(
                                        //   () =>
                                        Text(
                                      '0 FCFA',
                                      // controller.totalFess.value == 0
                                      //   ? '0 FCFA'
                                      //     : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0 ? const SizedBox.shrink() : SizedBox(height: 1.h)),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : Padding(
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
                                    child:
                                        //  Obx(
                                        //   () =>
                                        Text(
                                      '0 FCFA',
                                      // controller.senderkeycosttva.isEmpty
                                      // ? '0 FCFA'
                                      // : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                    // ),
                                  ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0 ? const SizedBox.shrink() : SizedBox(height: 1.h)),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : Padding(
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
                                    child:
                                        // Obx(
                                        //   () =>
                                        Text(
                                      //  controller.totalAmount.value == 0
                                      // ?
                                      '0 FCFA',
                                      //: '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            )),
                      Obx(() => controller.selectedMoonSubIndex.value == 0
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: 4.h,
                            )),
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
                                if (controller.selectedOption.value == "CEET") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  // controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                  //     controller.price.value, controller.code.text);
                                }
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
                                  if (controller.selectedOption.value == "CEET") {
                                    AppGlobal.dateNow = DateTime.now().toString();
                                    AppGlobal.timeNow = DateTime.now().toString();
                                    // controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                    //     controller.price.value, controller.code.text);
                                  }
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
