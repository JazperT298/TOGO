// ignore_for_file: unused_import

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/line_separator.dart';
// import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/fontsize_config.dart';

class WithdrawOtpBottomSheet {
  static showBottomSheetWithdrawNormalOTP() {
    final controller = Get.find<WithdrawalController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: isKeyboardVisible ? 60.h : 70.h,
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
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text(
                        LocaleKeys.strTransferSummary.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFB6404),
                            fontSize: FontSizes.headerMediumText),
                      ),
                    ),
                    SizedBox(height: .5.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Withdraw ', // 'Vous allez envoyer de l’argent à ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: FontSizes.headerLargeText),
                            ),
                            TextSpan(
                              text: 'Normal',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF124DE5),
                                  fontSize: FontSizes.headerLargeText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text(
                        'Point of sale'.toUpperCase(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF27303F),
                            fontSize: FontSizes.headerMediumText),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Name',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.nickname.value,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(Get.context!).size.height * .025),
                      child: const LineSeparator(color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
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
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.strTransferAmount.tr,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.amount.isEmpty
                                    ? '0 FCFA'
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.amount.toString()))} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Fees',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
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
                                    fontSize: FontSizes.headerMediumText),
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
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Tax',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
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
                                    fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'TTC ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
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
                                    fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(Get.context!).size.height * .025),
                      child: FluTextField(
                          inputController: controller.code,
                          hint: LocaleKeys
                              .strCodeSecret.tr, // "Votre code secret",
                          height: 6.5.h,
                          cornerRadius: 15,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.textFieldText),
                          textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: FontSizes.textFieldText),
                          onFieldSubmitted: (p0) async {
                            if (controller.code.text.isNotEmpty) {
                              AppGlobal.dateNow = DateTime.now().toString();
                              AppGlobal.timeNow = DateTime.now().toString();
                              controller.enterPinToTransactWithdrawal(
                                  code: controller.code.text);
                            } else {
                              Get.snackbar("Message", "Entrées manquantes",
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            }
                          }),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
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
                              AppGlobal.dateNow = DateTime.now().toString();
                              AppGlobal.timeNow = DateTime.now().toString();
                              controller.enterPinToTransactWithdrawal(
                                  code: controller.code.text);
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
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSizes.buttonText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      isScrollControlled: true,
    );
  }

  static showBottomSheetWithdrawCollectionOTP() {
    final controller = Get.find<WithdrawalController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: isKeyboardVisible ? 55.h : 65.h,
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
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text(
                        LocaleKeys.strTransferSummary.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFB6404),
                            fontSize: FontSizes.headerMediumText),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Withdraw ', // 'Vous allez envoyer de l’argent à ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: FontSizes.headerLargeText),
                            ),
                            TextSpan(
                              text: 'Collection',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF124DE5),
                                  fontSize: FontSizes.headerLargeText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text(
                        'Point of sale'.toUpperCase(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF27303F),
                            fontSize: FontSizes.headerMediumText),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Name',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.nickname.value,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(Get.context!).size.height * .025),
                      child: const LineSeparator(color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
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
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Fees',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.fees.value.isEmpty
                                    ? '0 FCFA'
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.fees.value.replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.strTransferAmount.tr,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.amounts.value.text.isEmpty
                                  ? '0 FCFA'
                                  : '${StringHelper.formatNumberWithCommas(int.parse(controller.amounts.value.text.toString().replaceAll(',', '')))} FCFA',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(Get.context!).size.height * .025),
                      child: FluTextField(
                          inputController: controller.code,
                          hint: LocaleKeys
                              .strCodeSecret.tr, // "Votre code secret",
                          height: 6.5.h,
                          cornerRadius: 15,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.textFieldText),
                          textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: FontSizes.textFieldText),
                          onFieldSubmitted: (p0) async {
                            if (controller.code.text.isNotEmpty) {
                              AppGlobal.dateNow = DateTime.now().toString();
                              AppGlobal.timeNow = DateTime.now().toString();
                              controller.enterPinToTransactWithdrawal(
                                  code: controller.code.text);
                            } else {
                              Get.snackbar("Message", "Entrées manquantes",
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            }
                          }),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
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
                              AppGlobal.dateNow = DateTime.now().toString();
                              AppGlobal.timeNow = DateTime.now().toString();
                              controller.enterPinToTransactWithdrawal(
                                  code: controller.code.text);
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
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSizes.buttonText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      isScrollControlled: true,
    );
  }

  static showBottomSheetCounterWithdrawnOTP() {
    final controller = Get.find<WithdrawalController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: isKeyboardVisible ? 51.h : 61.h,
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
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text(
                        LocaleKeys.strTransferSummary.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFB6404),
                            fontSize: FontSizes.headerMediumText),
                      ),
                    ),
                    SizedBox(height: .3.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Withdrawal ', // 'Vous allez envoyer de l’argent à ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: FontSizes.headerLargeText),
                            ),
                            TextSpan(
                              text: 'Counter',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF124DE5),
                                  fontSize: FontSizes.headerLargeText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Obx(
                        () => Text(
                          controller.selectedBank.value.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Name',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.nickname.value,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF27303F),
                                    fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(Get.context!).size.height * .025),
                      child: const LineSeparator(color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
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
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.strTransferAmount.tr,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.amounts.value.text.isEmpty
                                  ? '0 FCFA'
                                  : '${StringHelper.formatNumberWithCommas(int.parse(controller.amounts.value.text.toString().replaceAll(',', '')))} FCFA',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(Get.context!).size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Fees',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerMediumText),
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
                                    fontSize: FontSizes.headerMediumText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(Get.context!).size.height * .025),
                      child: FluTextField(
                          inputController: controller.code,
                          hint: LocaleKeys
                              .strCodeSecret.tr, // "Votre code secret",
                          height: 6.5.h,
                          cornerRadius: 15,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.textFieldText),
                          textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: FontSizes.textFieldText),
                          onFieldSubmitted: (p0) async {
                            if (controller.code.text.isNotEmpty) {
                              AppGlobal.dateNow = DateTime.now().toString();
                              AppGlobal.timeNow = DateTime.now().toString();
                              controller.enterPinToTransactWithdrawal(
                                  code: controller.code.text);
                            } else {
                              Get.snackbar("Message", "Entrées manquantes",
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            }
                          }),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          'Validate',
                          suffixIcon: FluIcons.checkCircleUnicon,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            // Get.back();
                            // Get.toNamed(AppRoutes.WITHDRAWPROGRESS);
                            if (controller.code.text.isNotEmpty) {
                              AppGlobal.dateNow = DateTime.now().toString();
                              AppGlobal.timeNow = DateTime.now().toString();
                              controller.enterPinToTransactWithdrawal(
                                  code: controller.code.text);
                            } else {
                              Get.snackbar("Message", "Entrées manquantes",
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            }
                            // if (controller.code.text.isNotEmpty) {
                            //   AppGlobal.dateNow = DateTime.now().toString();
                            //   AppGlobal.timeNow = DateTime.now().toString();
                            //   controller.enterPinToTransactWithdrawal(code: controller.code.text);
                            // } else {
                            //   Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            // }
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
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSizes.buttonText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      isScrollControlled: true,
    );
  }
}
