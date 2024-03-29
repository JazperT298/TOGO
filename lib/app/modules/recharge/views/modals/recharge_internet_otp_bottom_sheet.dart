// ignore_for_file: unused_import

import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/app/services/android_verify_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/fontsize_config.dart';
import '../../../../../utils/helpers/string_helper.dart';
import '../../../../data/local/getstorage_services.dart';

class RechargeInternetOTPBottomSheet {
  static showBottomSheetOTP() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 86.h,
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
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "SUMMARY".toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFB6404),
                              fontSize: 13.sp),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() =>
                            controller.selectedOption.value == "For myself"
                                ? RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Recharge your ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 19.sp),
                                      ),
                                      TextSpan(
                                        text: 'Moov ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF295fe7),
                                            fontSize: 19.sp),
                                      ),
                                      TextSpan(
                                        text: 'account using ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 19.sp),
                                      ),
                                      TextSpan(
                                        text: 'Flooz.',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFfb6708),
                                            fontSize: 19.sp),
                                      )
                                    ]),
                                  )
                                : RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Recharge other ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 19.sp),
                                      ),
                                      TextSpan(
                                        text: 'Moov ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF295fe7),
                                            fontSize: 19.sp),
                                      ),
                                      TextSpan(
                                        text: 'account using ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 19.sp),
                                      ),
                                      TextSpan(
                                        text: 'Flooz.',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFfb6708),
                                            fontSize: 19.sp),
                                      )
                                    ]),
                                  )),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF27303F),
                              fontSize: 13.sp),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: controller.selectedOption.value == "For myself"
                            ? Container(
                                height: 7.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: const Color(0xFFe7edfc)),
                                child: Center(
                                  child: Text(
                                    "Moi meme",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: FontSizes.headerSmallText),
                                  ),
                                ),
                              )
                            : Container(
                                height: 7.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: const Color(0xFFf4f5fa)),
                                child: Center(
                                  child: Text(
                                    controller.numberTextField.text,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: FontSizes.headerSmallText),
                                  ),
                                ),
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
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.headerMediumText),
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
                                "Package",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.textSplitterPackageName(
                                    text: controller
                                        .selectedProduct!.description),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Validity",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.textSplitterPrice(
                                    text: controller
                                        .selectedProduct!.description),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                LocaleKeys.strTransferAmount.tr,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${controller.selectedProduct!.price} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerSmallText),
                              ),
                            ),
                          ],
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
                      SizedBox(height: 2.h),
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
                      SizedBox(height: 2.h),
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
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluTextField(
                          textAlign: TextAlign.center,
                          inputController: controller.code,
                          hint: "Enter PIN code", // "Montant à envoyer",

                          hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.textFieldText),
                          textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: FontSizes.textFieldText),
                          height: 6.5.h,
                          cornerRadius: 15,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFf4f5fa),
                          onChanged: (text) {},
                          onFieldSubmitted: (p0) async {
                            if (controller.code.text.isNotEmpty) {
                              bool verified =
                                  await Get.find<AndroidVerifyServices>()
                                      .verifyAndroid();
                              if (verified) {
                                if (controller.selectedOption.value ==
                                    "For myself") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  await controller.transactInternetRechargeOwn(
                                      code: controller.code.text,
                                      msisdn: Get.find<StorageServices>()
                                          .storage
                                          .read('msisdn'));
                                } else {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  await controller
                                      .transactInternetRechargeOthers(
                                          code: controller.code.text,
                                          msisdn:
                                              controller.numberTextField.text);
                                }
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
                          'Validate',
                          suffixIcon: FluIcons.checkCircleUnicon,
                          iconStrokeWidth: 1.8,
                          onPressed: () async {
                            if (controller.code.text.isNotEmpty) {
                              bool verified =
                                  await Get.find<AndroidVerifyServices>()
                                      .verifyAndroid();
                              if (verified) {
                                if (controller.selectedOption.value ==
                                    "For myself") {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  await controller.transactInternetRechargeOwn(
                                      code: controller.code.text,
                                      msisdn: Get.find<StorageServices>()
                                          .storage
                                          .read('msisdn'));
                                } else {
                                  AppGlobal.dateNow = DateTime.now().toString();
                                  AppGlobal.timeNow = DateTime.now().toString();
                                  await controller
                                      .transactInternetRechargeOthers(
                                          code: controller.code.text,
                                          msisdn:
                                              controller.numberTextField.text);
                                }
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
                          textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFF4F5FA),
                              fontSize: FontSizes.buttonText),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
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
