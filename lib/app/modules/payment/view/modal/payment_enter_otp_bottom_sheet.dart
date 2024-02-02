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
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/fontsize_config.dart';

class PaymentEnterOtpBottomSheet {
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
                height: isKeyboardVisible ? 67.h : 74.h,
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
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                // controller.textSplitterPackageName(text: controller.selectedProduct!.description),
                                // controller.selectDatum!.reference,
                                controller.billPayment!.message[0].productname,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.price.value.isEmpty
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.price.value.replaceAll(',', '')))} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.totalFess.value == 0
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.senderkeycosttva.isEmpty
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                                    fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.totalAmount.value == 0
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
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
                          onFieldSubmitted: (p0) {
                            if (controller.code.text.isNotEmpty) {
                              if (controller.selectedOption.value == "CEET") {
                                AppGlobal.dateNow = DateTime.now().toString();
                                AppGlobal.timeNow = DateTime.now().toString();
                                controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                    controller.price.value, controller.code.text);
                              } else {}
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
                            onPressed: () {
                              if (controller.code.text.isNotEmpty) {
                                if (controller.selectedOption.value == "CEET") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  controller.sentBillPaymentRequest(controller.billType.value, controller.billPayment!.message[0].productname,
                                      controller.price.value, controller.code.text);
                                } else {}
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
