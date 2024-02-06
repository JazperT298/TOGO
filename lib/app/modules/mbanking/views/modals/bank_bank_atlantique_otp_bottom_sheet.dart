import 'dart:ui';
import 'package:dotted_line/dotted_line.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/mbanking/controller/mbanking_controller.dart';
import 'package:ibank/app/services/android_verify_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/fontsize_config.dart';

class MBankingBankAtlantiqueOTpBottomSheet {
  static void showMBankingBankAtlantiqueOtpBottomSheet() {
    var controller = Get.find<MBankingController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
          return Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: isKeyboardVisible ? 64.h : 73.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "SUMMARY".toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFB6404),
                              fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(
                          () => Text.rich(
                            controller.selectedSubMenu.value ==
                                    "Flooz to Bank Atlantique"
                                ? TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Flooz ', // 'Vous allez envoyer de l’argent à ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF124DE5),
                                            fontSize:
                                                FontSizes.headerLargeText),
                                      ),
                                      TextSpan(
                                        text: 'transfer to  ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize:
                                                FontSizes.headerLargeText),
                                      ),
                                      TextSpan(
                                        text: 'Bank Atlantique ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFFB6404),
                                            fontSize:
                                                FontSizes.headerLargeText),
                                      ),
                                      TextSpan(
                                        text: 'account',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize:
                                                FontSizes.headerLargeText),
                                      ),
                                    ],
                                  )
                                : TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Bank Atlantique ', // 'Vous allez envoyer de l’argent à ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFFB6404),
                                            fontSize:
                                                FontSizes.headerLargeText),
                                      ),
                                      TextSpan(
                                        text: 'transfer to  ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize:
                                                FontSizes.headerLargeText),
                                      ),
                                      TextSpan(
                                        text: 'Flooz ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF124DE5),
                                            fontSize:
                                                FontSizes.headerLargeText),
                                      ),
                                      TextSpan(
                                        text: 'account',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize:
                                                FontSizes.headerLargeText),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Container(
                            height: 7.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "Moi meme",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                          )),
                      SizedBox(height: 3.h),
                      Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: DottedLine(
                            dashLength: 5.w,
                            dashColor: Colors.grey,
                          )),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          LocaleKeys.strTransferDetails.tr.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Amount',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${StringHelper.formatNumberWithCommas(int.parse(controller.amountTextField.value.text.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
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
                                'Fees',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.totalFess.value == 0
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF27303F),
                                      fontSize: FontSizes.headerSmallText),
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
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.senderkeycosttva.isEmpty
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF27303F),
                                      fontSize: FontSizes.headerSmallText),
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
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => Text(
                                  controller.totalAmount.value == 0
                                      ? '0 FCFA'
                                      : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF27303F),
                                      fontSize: FontSizes.headerSmallText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluTextField(
                          textAlign: TextAlign.center,
                          inputController: controller.codeTextField,
                          hint: "Enter PIN code", // "Montant à envoyer",
                          hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.textFieldText),
                          textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: FontSizes.textFieldText),
                          height: 6.5.h,
                          cornerRadius: 15,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFf4f5fa),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\s]')),
                          ],

                          onFieldSubmitted: (p0) async {
                            if (controller.codeTextField.text.isNotEmpty) {
                              bool verified =
                                  await Get.find<AndroidVerifyServices>()
                                      .verifyAndroid();
                              if (verified) {
                                if (controller.selectedSubMenu.value ==
                                    "Flooz to Bank Atlantique") {
                                  controller.sendBankAtlantiqueFinalTransaction(
                                      controller.keyword.value,
                                      controller.selectedLinkedBank.value,
                                      controller.amountTextField.text,
                                      "",
                                      controller.codeTextField.value.text);
                                } else {
                                  controller.sendBankAtlantiqueFinalTransaction(
                                      controller.keyword.value,
                                      controller.selectedLinkedBank.value,
                                      controller.amountTextField.text,
                                      AppGlobal.MSISDN,
                                      controller.codeTextField.value.text);
                                }
                                AppGlobal.dateNow = DateTime.now().toString();
                                AppGlobal.timeNow = DateTime.now().toString();
                              }
                            } else {
                              Get.snackbar("Message", "Entrées manquantes",
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Visibility(
                          visible: isKeyboardVisible ? false : true,
                          child: FluButton.text(
                            'Validate',
                            suffixIcon: FluIcons.checkCircleUnicon,
                            iconStrokeWidth: 1.8,
                            onPressed: () async {
                              if (controller.codeTextField.text.isNotEmpty) {
                                bool verified =
                                    await Get.find<AndroidVerifyServices>()
                                        .verifyAndroid();
                                if (verified) {
                                  if (controller.selectedSubMenu.value ==
                                      "Flooz to Bank Atlantique") {
                                    controller
                                        .sendBankAtlantiqueFinalTransaction(
                                            controller.keyword.value,
                                            controller.selectedLinkedBank.value,
                                            controller.amountTextField.text,
                                            "",
                                            controller
                                                .codeTextField.value.text);
                                  } else {
                                    controller
                                        .sendBankAtlantiqueFinalTransaction(
                                            controller.keyword.value,
                                            controller.selectedLinkedBank.value,
                                            controller.amountTextField.text,
                                            AppGlobal.MSISDN,
                                            controller
                                                .codeTextField.value.text);
                                  }
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                }
                              } else {
                                Get.snackbar("Message", "Entrées manquantes",
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              }
                            },
                            height: 7.h,
                            width: 100.w,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: const Color(0xFF124DE5),
                            foregroundColor: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 25,
                                spreadRadius: 3,
                                offset: Offset(0, 5),
                              )
                            ],
                            textStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFF4F5FA),
                                fontSize: FontSizes.buttonText),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h)
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      isScrollControlled: true,
    );
  }
}
