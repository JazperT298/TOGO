import 'dart:developer';
import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/data/models/bbox_cizo_sub_model.dart';
import 'package:ibank/app/data/models/cash_power_sub_model.dart';
import 'package:ibank/app/data/models/soleva_payment_sub_model.dart';
import 'package:ibank/app/data/models/tde_sub_model.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_amount_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class EnergiesSaveInputBottomSheet {
  static void showBottomSheetSolevaInputTitle() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () => Text(
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "New reference detected. Save ?",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
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
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: FluTextField(
                              inputController: controller.titleTextField,
                              hint: 'Add a name',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.name,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(top: 8, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FluButton.text(
                            'No',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              Get.back();
                              EnergiesAmountBottomSheet.showBottomSheetSolevaInputAmount();
                            },
                            height: 5.8.h,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            border: BorderSide(color: context.colorScheme.primary),
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp, color: context.colorScheme.primary),
                          ),
                          FluButton.text(
                            'Register',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              controller.addSolevaSubMenu(
                                SolevaPaymentSubModel(
                                    title: controller.titleTextField.text,
                                    description: controller.numberTextField.text,
                                    icon: FluIcons.tvRetroUnicon),
                              );
                              controller.loadSolevaSubMenu();
                              Get.back();
                              EnergiesAmountBottomSheet.showBottomSheetSolevaInputAmount();
                            },
                            height: 5.8.h,
                            suffixIcon: FluIcons.bookmarkUnicon,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: context.colorScheme.primary,
                            foregroundColor: context.colorScheme.onPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: context.colorScheme.primary.withOpacity(.35),
                                blurRadius: 25,
                                spreadRadius: 3,
                                offset: const Offset(0, 5),
                              )
                            ],
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }), isScrollControlled: true);
  }

  static void showBottomSheetCashPowerInputTitle() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () => Text(
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "New counter detected. Save?",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
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
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: FluTextField(
                              inputController: controller.titleTextField,
                              hint: 'Add a name',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.name,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(top: 8, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FluButton.text(
                            'No',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              Get.back();
                              EnergiesAmountBottomSheet.showBottomSheetCashPowerInputAmount();
                            },
                            height: 5.8.h,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            border: BorderSide(color: context.colorScheme.primary),
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp, color: context.colorScheme.primary),
                          ),
                          FluButton.text(
                            'Register',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              controller.addCashPowerSubMenu(
                                CashPowerSubModel(
                                    title: controller.titleTextField.text,
                                    description: controller.numberTextField.text,
                                    icon: FluIcons.tvRetroUnicon),
                              );
                              controller.loadCashPowerSubMenu();
                              EnergiesAmountBottomSheet.showBottomSheetCashPowerInputAmount();
                            },
                            height: 5.8.h,
                            suffixIcon: FluIcons.bookmarkUnicon,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: context.colorScheme.primary,
                            foregroundColor: context.colorScheme.onPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: context.colorScheme.primary.withOpacity(.35),
                                blurRadius: 25,
                                spreadRadius: 3,
                                offset: const Offset(0, 5),
                              )
                            ],
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }), isScrollControlled: true);
  }

  static void showBottomSheetBBoxCizoInputTitle() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () => Text(
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "New reference detected. Save ?",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
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
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: FluTextField(
                              inputController: controller.titleTextField,
                              hint: 'Add a name',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.name,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(top: 8, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FluButton.text(
                            'No',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              Get.back();
                              EnergiesAmountBottomSheet.showBottomSheetBBoxCizoInputAmount();
                            },
                            height: 5.8.h,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            border: BorderSide(color: context.colorScheme.primary),
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp, color: context.colorScheme.primary),
                          ),
                          FluButton.text(
                            'Register',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              controller.addBBoxCizeSubMenu(
                                BBoxCizoSubModel(
                                    title: controller.titleTextField.text,
                                    description: controller.numberTextField.text,
                                    icon: FluIcons.tvRetroUnicon),
                              );
                              controller.loadBBoxCozeSubMenu();
                              Get.back();
                              EnergiesAmountBottomSheet.showBottomSheetBBoxCizoInputAmount();
                            },
                            height: 5.8.h,
                            suffixIcon: FluIcons.bookmarkUnicon,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: context.colorScheme.primary,
                            foregroundColor: context.colorScheme.onPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: context.colorScheme.primary.withOpacity(.35),
                                blurRadius: 25,
                                spreadRadius: 3,
                                offset: const Offset(0, 5),
                              )
                            ],
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }), isScrollControlled: true);
  }

  static void showBottomSheetTDEInputTitle() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Obx(
                        () => Text(
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "New reference detected. Save ?",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
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
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: FluTextField(
                              inputController: controller.titleTextField,
                              hint: 'Add a name',
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.name,
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                log('NUM ${controller.numberTextField.text.length.toString()}');
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //   child: Container(width: .5.w, color: Colors.grey, height: 3.5.h),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(top: 8, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FluButton.text(
                            'No',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              Get.back();
                              EnergiesAmountBottomSheet.showBottomSheetTDEInputAmount();
                            },
                            height: 5.8.h,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            border: BorderSide(color: context.colorScheme.primary),
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp, color: context.colorScheme.primary),
                          ),
                          FluButton.text(
                            'Register',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              controller.addTDESubMenu(
                                TDESubModel(
                                    title: controller.titleTextField.text,
                                    description: controller.numberTextField.text,
                                    icon: FluIcons.tvRetroUnicon),
                              );
                              controller.loadTDESubMenu();
                              EnergiesAmountBottomSheet.showBottomSheetTDEInputAmount();
                            },
                            height: 5.8.h,
                            suffixIcon: FluIcons.bookmarkUnicon,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: context.colorScheme.primary,
                            foregroundColor: context.colorScheme.onPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: context.colorScheme.primary.withOpacity(.35),
                                blurRadius: 25,
                                spreadRadius: 3,
                                offset: const Offset(0, 5),
                              )
                            ],
                            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }), isScrollControlled: true);
  }
}
