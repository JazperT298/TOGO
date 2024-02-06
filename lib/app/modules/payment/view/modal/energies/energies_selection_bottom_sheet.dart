import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_amount_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_enter_otp_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_inputs_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class EnergiesSelectionBottomSheet {
  static void showBottomSheetPaymentMoonSelectMenu(BuildContext context) {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 75.h,
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
                          'Payment'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'What operation do you want to perform?',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 3.h),
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
                      SizedBox(height: 3.h),
                      SizedBox(
                        height: 33.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.moonPaymentSubModel.length,
                              itemBuilder: (context, index) {
                                final option = controller.moonPaymentSubModel[index];
                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    if (index == 2) {
                                      controller.selectedMoonSubIndex.value = index;
                                      EnergiesInputsBottomSheet.showBottomSheetMoonInputNumber();
                                    } else {
                                      controller.selectedMoonSubIndex.value = index;
                                      Get.back();
                                      EnergiesEnterOtpBottomSheet.showBottomSheetOTPMoon();
                                    }

                                    // if (index == 0) {
                                    //   controller.selectedOption.value = 'CEET';
                                    //   controller.ceetPackageRadioGroupValue.value = '';
                                    //   controller.numberTextField.clear();
                                    //   controller.code.clear();
                                    //   controller.verifyGetCeetLink();
                                    // } else if (index == 3) {
                                    //   controller.selectedOption.value = 'SOLERGIE';
                                    //   controller.numberTextField.clear();
                                    //   FullScreenLoading.fullScreenLoadingWithTextAndTimer('Requesting. . .');
                                    //   await Future.delayed(const Duration(seconds: 2), () {
                                    //     Get.back();
                                    //     Get.back();
                                    //     // EnergiesInputsBottomSheet.showBottomSheetSolergieInputNumber();
                                    //   });
                                    // } else {
                                    //   Get.snackbar("Message", "Comming Soon", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    // }
                                  },
                                  backgroundColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  margin: EdgeInsets.only(top: index == 0 ? 0 : 16),
                                  child: Row(
                                    children: [
                                      FluArc(
                                        startOfArc: 90,
                                        angle: 90,
                                        strokeWidth: 1,
                                        color: context.colorScheme.primaryContainer,
                                        child: Container(
                                            height: 8.h,
                                            width: 18.w,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: const BoxDecoration(color: Color(0xFFDBE4FB), shape: BoxShape.circle),
                                            child: FluIcon(
                                              option.icon,
                                              color: Colors.black,
                                            )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                option.title,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(0xFF27303F),
                                                    fontSize: FontSizes.headerMediumText),
                                              ),
                                              Text(
                                                option.description,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: FontSizes.headerSmallText),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // FluIcon(
                                      //   FluIcons.arrowRight1,
                                      //   size: 16,
                                      //   color: context.colorScheme.onBackground,
                                      // )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        isScrollControlled: true);
  }

  static void showBottomSheetPaymentSolevaSelectMenu(BuildContext context) {
    var controller = Get.find<PaymentController>();
    controller.loadSolevaSubMenu();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 75.h,
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Please select a reference',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Which of your references would you like to pay for today?',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                        ),
                      ),
                      if (controller.solevaPaymentModelList.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: FluTextField(
                            hint: 'Card name or number',
                            suffixIcon: FluIcons.searchStatus,
                            height: UISettings.buttonSize,
                            cornerRadius: UISettings.buttonCornerRadius,
                            fillColor: const Color(0xFFF4F5FA),
                            onChanged: (query) {
                              // filterContacts(query);
                            },
                            margin: const EdgeInsets.only(top: 25),
                            textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
                            // fillColor: context.colorScheme.surface,
                          ),
                        ),
                      SizedBox(height: 3.h),
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
                      SizedBox(height: 3.h),
                      if (controller.solevaPaymentModelList.isEmpty)
                        SizedBox(
                          height: 33.h,
                          child: const Center(
                            child: Text('Soleva List is Empty'),
                          ),
                        ),
                      if (controller.solevaPaymentModelList.isNotEmpty)
                        SizedBox(
                          height: 33.h,
                          width: 100.w,
                          child: Obx(
                            () => ListView.builder(
                              itemCount: controller.solevaPaymentModelList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.solevaPackageRadioGroupValue.value == controller.solevaPaymentModelList[index].title) {
                                        controller.solevaPackageRadioGroupValue.value = '';
                                        controller.selectedSolevaSubIndex.value = 0;
                                      } else {
                                        controller.solevaPackageRadioGroupValue.value = controller.solevaPaymentModelList[index].title;
                                        controller.selectedSolevaSubIndex.value = index;
                                      }
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 11.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: controller.solevaPackageRadioGroupValue.value == controller.solevaPaymentModelList[index].title
                                              ? const Color(0xFFFEE8D9)
                                              : const Color(0xFFF4F5FA),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.w, right: 1.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.solevaPaymentModelList[index].title,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(0xFF27303F),
                                                        fontSize: FontSizes.headerLargeText),
                                                  ).paddingOnly(bottom: 0.7.h),
                                                  Text(
                                                    controller.solevaPaymentModelList[index].description,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xFF687997),
                                                        fontSize: FontSizes.headerSmallText),
                                                  ),
                                                ],
                                              ),
                                              Obx(
                                                () => Radio(
                                                    value: controller.solevaPaymentModelList[index].title,
                                                    groupValue: controller.solevaPackageRadioGroupValue.value,
                                                    onChanged: (value) {
                                                      controller.solevaPackageRadioGroupValue.value = controller.solevaPaymentModelList[index].title;
                                                      controller.selectedSolevaSubMenu = controller.solevaPaymentModelList[index];
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (controller.solevaPaymentModelList.isNotEmpty)
                        SizedBox(
                          height: 2.h,
                        ),
                      if (controller.solevaPaymentModelList.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: FluButton.text(
                            'Confirm',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              if (controller.solevaPackageRadioGroupValue.value.isEmpty) {
                                Get.snackbar("Message", 'Please select a reference', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              } else {
                                Get.back();
                                Get.back();
                                EnergiesAmountBottomSheet.showBottomSheetSolevaInputAmount();
                              }
                              // controller.numberTextField.text = controller.selectedSolevaSubMenu!.title;

                              // if (controller.selectedIndex.value == 1) {
                              //   Get.back();
                              //   MBankingSubMenuBottomSheet.showMBankingSubMenuBottomSheet();
                              // } else if (controller.selectedIndex.value == 2 ||
                              //     controller.selectedIndex.value == 23 ||
                              //     controller.selectedIndex.value == 4) {
                              //   Get.snackbar("Message", 'Comming soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // } else {
                              //   Get.snackbar("Message", 'Please select a bank', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // }
                            },
                            height: 5.8.h,
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
                            textStyle:
                                GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: FontSizes.buttonText),
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
        ),
        isScrollControlled: true);
  }

  static void showBottomSheetPaymentCashPowerSelectMenu(BuildContext context) {
    var controller = Get.find<PaymentController>();
    controller.loadCashPowerSubMenu();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 75.h,
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
                                  '${controller.selectedSubOption.value} ${controller.selectedOption.value}'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                )
                              : Text(
                                  '${controller.selectedOption.value} ${controller.selectedSubOption.value}'.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                                ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(() => controller.selectedSubOption.value == 'Purchase'
                            ? Text(
                                'Select a counter',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              )
                            : Text(
                                'Enter your code to receive your duplicate',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                              )),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Which of your references would you like to pay for today?',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                        ),
                      ),
                      if (controller.cashPowerSubModelList.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: FluTextField(
                            hint: 'Card name or number',
                            suffixIcon: FluIcons.searchStatus,
                            height: UISettings.buttonSize,
                            cornerRadius: UISettings.buttonCornerRadius,
                            fillColor: const Color(0xFFF4F5FA),
                            onChanged: (query) {
                              // filterContacts(query);
                            },
                            margin: const EdgeInsets.only(top: 25),
                            textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
                            // fillColor: context.colorScheme.surface,
                          ),
                        ),
                      SizedBox(height: 3.h),
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
                      SizedBox(height: 3.h),
                      if (controller.cashPowerSubModelList.isEmpty)
                        SizedBox(
                          height: 33.h,
                          child: const Center(
                            child: Text('Cash Power List is Empty'),
                          ),
                        ),
                      if (controller.cashPowerSubModelList.isNotEmpty)
                        SizedBox(
                          height: 33.h,
                          width: 100.w,
                          child: Obx(
                            () => ListView.builder(
                              itemCount: controller.cashPowerSubModelList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.cashPowerPackageRadioGroupValue.value == controller.cashPowerSubModelList[index].title) {
                                        controller.cashPowerPackageRadioGroupValue.value = '';
                                        controller.selectedCashPowerSubIndex.value = 0;
                                      } else {
                                        controller.cashPowerPackageRadioGroupValue.value = controller.cashPowerSubModelList[index].title;
                                        controller.selectedCashPowerSubIndex.value = index;
                                      }
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 11.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: controller.cashPowerPackageRadioGroupValue.value == controller.cashPowerSubModelList[index].title
                                              ? const Color(0xFFFEE8D9)
                                              : const Color(0xFFF4F5FA),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.w, right: 1.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.cashPowerSubModelList[index].title,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(0xFF27303F),
                                                        fontSize: FontSizes.headerLargeText),
                                                  ).paddingOnly(bottom: 0.7.h),
                                                  Text(
                                                    controller.cashPowerSubModelList[index].description,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xFF687997),
                                                        fontSize: FontSizes.headerSmallText),
                                                  ),
                                                ],
                                              ),
                                              Obx(
                                                () => Radio(
                                                    value: controller.solevaPaymentModelList[index].title,
                                                    groupValue: controller.solevaPackageRadioGroupValue.value,
                                                    onChanged: (value) {
                                                      controller.cashPowerPackageRadioGroupValue.value =
                                                          controller.cashPowerSubModelList[index].title;
                                                      controller.selectedCashPowerSubMenu = controller.cashPowerSubModelList[index];
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (controller.cashPowerSubModelList.isNotEmpty)
                        SizedBox(
                          height: 2.h,
                        ),
                      if (controller.cashPowerSubModelList.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: FluButton.text(
                            'Confirm',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              if (controller.solevaPackageRadioGroupValue.value.isEmpty) {
                                Get.snackbar("Message", 'Please select a reference', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              } else {
                                Get.back();
                                Get.back();
                                EnergiesAmountBottomSheet.showBottomSheetCashPowerInputAmount();
                              }
                              // controller.numberTextField.text = controller.selectedSolevaSubMenu!.title;

                              // if (controller.selectedIndex.value == 1) {
                              //   Get.back();
                              //   MBankingSubMenuBottomSheet.showMBankingSubMenuBottomSheet();
                              // } else if (controller.selectedIndex.value == 2 ||
                              //     controller.selectedIndex.value == 23 ||
                              //     controller.selectedIndex.value == 4) {
                              //   Get.snackbar("Message", 'Comming soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // } else {
                              //   Get.snackbar("Message", 'Please select a bank', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // }
                            },
                            height: 5.8.h,
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
                            textStyle:
                                GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: FontSizes.buttonText),
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
        ),
        isScrollControlled: true);
  }

  static void showBottomSheetPaymentBBoxCizoSelectMenu(BuildContext context) {
    var controller = Get.find<PaymentController>();
    controller.loadBBoxCozeSubMenu();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 75.h,
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Select an account number',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Which of your references would you like to pay for today?',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                        ),
                      ),
                      if (controller.bboxCizoSubModelList.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: FluTextField(
                            hint: 'Card name or number',
                            suffixIcon: FluIcons.searchStatus,
                            height: UISettings.buttonSize,
                            cornerRadius: UISettings.buttonCornerRadius,
                            fillColor: const Color(0xFFF4F5FA),
                            onChanged: (query) {
                              // filterContacts(query);
                            },
                            margin: const EdgeInsets.only(top: 25),
                            textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
                            // fillColor: context.colorScheme.surface,
                          ),
                        ),
                      SizedBox(height: 3.h),
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
                      SizedBox(height: 3.h),
                      if (controller.bboxCizoSubModelList.isEmpty)
                        SizedBox(
                          height: 33.h,
                          child: const Center(
                            child: Text('BBox Cizo List is Empty'),
                          ),
                        ),
                      if (controller.bboxCizoSubModelList.isNotEmpty)
                        SizedBox(
                          height: 33.h,
                          width: 100.w,
                          child: Obx(
                            () => ListView.builder(
                              itemCount: controller.bboxCizoSubModelList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.bboxCizoackageRadioGroupValue.value == controller.bboxCizoSubModelList[index].title) {
                                        controller.bboxCizoackageRadioGroupValue.value = '';
                                        controller.selectedBBoxCizeSubIndex.value = 0;
                                      } else {
                                        controller.bboxCizoackageRadioGroupValue.value = controller.bboxCizoSubModelList[index].title;
                                        controller.selectedBBoxCizeSubIndex.value = index;
                                      }
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 11.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: controller.bboxCizoackageRadioGroupValue.value == controller.bboxCizoSubModelList[index].title
                                              ? const Color(0xFFFEE8D9)
                                              : const Color(0xFFF4F5FA),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.w, right: 1.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.bboxCizoSubModelList[index].title,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(0xFF27303F),
                                                        fontSize: FontSizes.headerLargeText),
                                                  ).paddingOnly(bottom: 0.7.h),
                                                  Text(
                                                    controller.bboxCizoSubModelList[index].description,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xFF687997),
                                                        fontSize: FontSizes.headerSmallText),
                                                  ),
                                                ],
                                              ),
                                              Obx(
                                                () => Radio(
                                                    value: controller.bboxCizoSubModelList[index].title,
                                                    groupValue: controller.bboxCizoackageRadioGroupValue.value,
                                                    onChanged: (value) {
                                                      controller.bboxCizoackageRadioGroupValue.value = controller.bboxCizoSubModelList[index].title;
                                                      controller.selectedBBoxCizoSubMenu = controller.bboxCizoSubModelList[index];
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (controller.bboxCizoSubModelList.isNotEmpty)
                        SizedBox(
                          height: 2.h,
                        ),
                      if (controller.bboxCizoSubModelList.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: FluButton.text(
                            'Confirm',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              if (controller.bboxCizoackageRadioGroupValue.value.isEmpty) {
                                Get.snackbar("Message", 'Please select a reference', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              } else {
                                Get.back();
                                Get.back();
                                EnergiesAmountBottomSheet.showBottomSheetBBoxCizoInputAmount();
                              }
                              // controller.numberTextField.text = controller.selectedSolevaSubMenu!.title;

                              // if (controller.selectedIndex.value == 1) {
                              //   Get.back();
                              //   MBankingSubMenuBottomSheet.showMBankingSubMenuBottomSheet();
                              // } else if (controller.selectedIndex.value == 2 ||
                              //     controller.selectedIndex.value == 23 ||
                              //     controller.selectedIndex.value == 4) {
                              //   Get.snackbar("Message", 'Comming soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // } else {
                              //   Get.snackbar("Message", 'Please select a bank', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // }
                            },
                            height: 5.8.h,
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
                            textStyle:
                                GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: FontSizes.buttonText),
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
        ),
        isScrollControlled: true);
  }

  static void showBottomSheetPaymentTDESelectMenu(BuildContext context) {
    var controller = Get.find<PaymentController>();
    controller.loadTDESubMenu();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 75.h,
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Select a subscriber reference',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Which of your references would you like to pay for today?',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                        ),
                      ),
                      if (controller.tdeSubModelList.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: FluTextField(
                            hint: 'Card name or number',
                            suffixIcon: FluIcons.searchStatus,
                            height: UISettings.buttonSize,
                            cornerRadius: UISettings.buttonCornerRadius,
                            fillColor: const Color(0xFFF4F5FA),
                            onChanged: (query) {
                              // filterContacts(query);
                            },
                            margin: const EdgeInsets.only(top: 25),
                            textStyle: const TextStyle(fontSize: M3FontSizes.bodyMedium),
                            // fillColor: context.colorScheme.surface,
                          ),
                        ),
                      SizedBox(height: 3.h),
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
                      SizedBox(height: 3.h),
                      if (controller.tdeSubModelList.isEmpty)
                        SizedBox(
                          height: 33.h,
                          child: const Center(
                            child: Text('TDE List is Empty'),
                          ),
                        ),
                      if (controller.tdeSubModelList.isNotEmpty)
                        SizedBox(
                          height: 33.h,
                          width: 100.w,
                          child: Obx(
                            () => ListView.builder(
                              itemCount: controller.tdeSubModelList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (controller.tdePackageRadioGroupValue.value == controller.tdeSubModelList[index].title) {
                                        controller.tdePackageRadioGroupValue.value = '';
                                        controller.selectedTDESubIndex.value = 0;
                                      } else {
                                        controller.tdePackageRadioGroupValue.value = controller.tdeSubModelList[index].title;
                                        controller.selectedTDESubIndex.value = index;
                                      }
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 11.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: controller.tdePackageRadioGroupValue.value == controller.tdeSubModelList[index].title
                                              ? const Color(0xFFFEE8D9)
                                              : const Color(0xFFF4F5FA),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.w, right: 1.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.tdeSubModelList[index].title,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(0xFF27303F),
                                                        fontSize: FontSizes.headerLargeText),
                                                  ).paddingOnly(bottom: 0.7.h),
                                                  Text(
                                                    controller.tdeSubModelList[index].description,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xFF687997),
                                                        fontSize: FontSizes.headerSmallText),
                                                  ),
                                                ],
                                              ),
                                              Obx(
                                                () => Radio(
                                                    value: controller.tdeSubModelList[index].title,
                                                    groupValue: controller.solevaPackageRadioGroupValue.value,
                                                    onChanged: (value) {
                                                      controller.tdePackageRadioGroupValue.value = controller.tdeSubModelList[index].title;
                                                      controller.selectTDESubMenu = controller.tdeSubModelList[index];
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      if (controller.tdeSubModelList.isNotEmpty)
                        SizedBox(
                          height: 2.h,
                        ),
                      if (controller.tdeSubModelList.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: FluButton.text(
                            'Confirm',
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              if (controller.solevaPackageRadioGroupValue.value.isEmpty) {
                                Get.snackbar("Message", 'Please select a reference', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              } else {
                                Get.back();
                                Get.back();
                                EnergiesAmountBottomSheet.showBottomSheetSolevaInputAmount();
                              }
                              // controller.numberTextField.text = controller.selectedSolevaSubMenu!.title;

                              // if (controller.selectedIndex.value == 1) {
                              //   Get.back();
                              //   MBankingSubMenuBottomSheet.showMBankingSubMenuBottomSheet();
                              // } else if (controller.selectedIndex.value == 2 ||
                              //     controller.selectedIndex.value == 23 ||
                              //     controller.selectedIndex.value == 4) {
                              //   Get.snackbar("Message", 'Comming soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // } else {
                              //   Get.snackbar("Message", 'Please select a bank', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // }
                            },
                            height: 5.8.h,
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
                            textStyle:
                                GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: FontSizes.buttonText),
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
        ),
        isScrollControlled: true);
  }
}
