import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
// import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_inputs_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_selection_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class EnergiesServiceLinksBottomSheet {
  static void showBottomSheetCeetServicePackageTo() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                height: isKeyboardVisible ? 60.h : 70.h,
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
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Select an Invoice",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Which of your references would you like to pay for today?",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluTextField(
                          hint: "Reference name or number",
                          height: 6.5.h,
                          cornerRadius: 15,
                          keyboardType: TextInputType.name,
                          fillColor: const Color(0xFFF4F5FA),
                          hintStyle:
                              GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.textFieldText),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.textFieldText),
                          suffixIcon: FluIcons.refresh,
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
                      SizedBox(height: 1.h),
                      SizedBox(
                        height: 27.h,
                        width: 100.w,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: controller.ceetDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.ceetPackageRadioGroupValue.value = controller.ceetDataList[index].reference;
                                    controller.selectDatum = controller.ceetDataList[index];
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 8.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        color: controller.ceetPackageRadioGroupValue.value == controller.ceetDataList[index].reference
                                            ? const Color(0xFFFEE8D9)
                                            : const Color(0xFFe7edfc),
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
                                                  controller.ceetDataList[index].reference,
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF27303F),
                                                      fontSize: FontSizes.headerMediumText),
                                                ),
                                                Text(
                                                  controller.ceetDataList[index].reference,
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w400,
                                                      color: const Color(0xFF687997),
                                                      fontSize: FontSizes.headerMediumText),
                                                ),
                                              ],
                                            ),
                                            Obx(
                                              () => Radio(
                                                  value: controller.ceetDataList[index].reference,
                                                  groupValue: controller.ceetPackageRadioGroupValue.value,
                                                  onChanged: (value) {
                                                    controller.ceetPackageRadioGroupValue.value = controller.ceetDataList[index].reference;
                                                    controller.selectDatum = controller.ceetDataList[index];
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
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Visibility(
                          visible: isKeyboardVisible ? false : true,
                          child: FluButton.text(
                            'Continue',
                            suffixIcon: FluIcons.arrowRight,
                            iconStrokeWidth: 1.8,
                            onPressed: () {
                              if (controller.selectDatum != null) {
                                Get.back();
                                Get.back();
                                // PaymentEnterOtpBottomSheet.showBottomSheetOTPCEET();
                                controller.verifyCeetRefIDfromInput(refId: controller.ceetPackageRadioGroupValue.value);
                                controller.ceetPackageRadioGroupValue.value = '';
                              } else {
                                Get.snackbar("Message", "Please select a service", backgroundColor: Colors.lightBlue, colorText: Colors.white);
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

  static void showBottomSheetPaymentSolevaSubMenu(BuildContext context) {
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Who do you want to make payment for?',
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
                        height: 24.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.solevaPaymentModel.length,
                              itemBuilder: (context, index) {
                                final option = controller.solevaPaymentModel[index];

                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    controller.selectedSolevaIndex.value = index;
                                    Get.back();
                                    if (index == 0) {
                                      controller.selectedOption.value = 'Soleva';
                                      controller.solevaPackageRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.amountTextField.clear();
                                      controller.namneTextField.clear();
                                      controller.code.clear();
                                      Get.back();
                                      EnergiesInputsBottomSheet.showBottomSheetSolevaInputNumber();
                                      controller.loadSolevaSubMenu();
                                    } else {
                                      Get.back();
                                      controller.selectedOption.value = 'Soleva';
                                      controller.solevaPackageRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.amountTextField.clear();
                                      controller.titleTextField.clear();
                                      controller.code.clear();
                                      EnergiesInputsBottomSheet.showBottomSheetSolevaInputNumber();
                                    }
                                    // EnergiesSelectionBottomSheet.showBottomSheetPaymentMoonSelectMenu(context);
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

  static void showBottomSheetPaymentCashPowerSubMenu(BuildContext context) {
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
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
                        height: 24.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.cashPowerModel.length,
                              itemBuilder: (context, index) {
                                final option = controller.cashPowerModel[index];

                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    controller.selectedCashPowerIndex.value = index;
                                    Get.back();
                                    if (index == 0) {
                                      controller.selectedSubOption.value = 'Purchase';
                                      controller.cashPowerPackageRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.namneTextField.clear();
                                      controller.amountTextField.clear();
                                      controller.code.clear();
                                      Get.back();
                                      EnergiesInputsBottomSheet.showBottomSheetCashPowerInputNumber();
                                      controller.loadSolevaSubMenu();
                                    } else {
                                      Get.back();
                                      controller.selectedSubOption.value = 'Duplicate';
                                      controller.cashPowerPackageRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.titleTextField.clear();
                                      controller.amountTextField.clear();
                                      controller.code.clear();
                                      EnergiesInputsBottomSheet.showBottomSheetCashPowerInputNumber();
                                    }
                                    // EnergiesSelectionBottomSheet.showBottomSheetPaymentMoonSelectMenu(context);
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

  static void showBottomSheetPaymentBBoxCizoSubMenu(BuildContext context) {
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Who do you want to make payment for?',
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
                        height: 24.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.bboxCizoModel.length,
                              itemBuilder: (context, index) {
                                final option = controller.bboxCizoModel[index];

                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    controller.selectedBBoxCizeIndex.value = index;
                                    Get.back();
                                    if (index == 0) {
                                      controller.selectedOption.value = 'BBox Cizo';
                                      controller.bboxCizoackageRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.namneTextField.clear();
                                      controller.code.clear();
                                      Get.back();
                                      EnergiesInputsBottomSheet.showBottomSheetBBoxCizoInputNumber();
                                      controller.loadSolevaSubMenu();
                                    } else {
                                      Get.back();
                                      controller.selectedOption.value = 'BBox Cizo';
                                      controller.bboxCizoackageRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.titleTextField.clear();
                                      controller.code.clear();
                                      EnergiesInputsBottomSheet.showBottomSheetBBoxCizoInputNumber();
                                    }
                                    // EnergiesSelectionBottomSheet.showBottomSheetPaymentMoonSelectMenu(context);
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

  static void showBottomSheetPaymentTDESubMenu(BuildContext context) {
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
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
                        height: 32.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.tdeModel.length,
                              itemBuilder: (context, index) {
                                final option = controller.tdeModel[index];

                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    controller.selectedTDESubIndex.value = index;
                                    Get.back();
                                    if (index == 0) {
                                      controller.selectedOption.value = 'TDE';
                                      controller.tdePackageRadioGroupValue.value = '';
                                      controller.tdePaymentRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.namneTextField.clear();
                                      controller.code.clear();
                                      Get.back();
                                      EnergiesInputsBottomSheet.showBottomSheetTDEInputNumber();
                                      controller.loadTDESubMenu();
                                    } else {
                                      Get.back();
                                      controller.selectedOption.value = 'TDE';
                                      controller.tdePackageRadioGroupValue.value = '';
                                      controller.tdePaymentRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.titleTextField.clear();
                                      controller.code.clear();
                                      EnergiesInputsBottomSheet.showBottomSheetTDEInputNumber();
                                    }
                                    // EnergiesSelectionBottomSheet.showBottomSheetPaymentMoonSelectMenu(context);
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

  static void showBottomSheetPaymentMoonSubMenu(BuildContext context) {
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
                          'Payment ${controller.selectedOption.value}'.toUpperCase(),
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
                        height: 24.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.moonPaymentModel.length,
                              itemBuilder: (context, index) {
                                final option = controller.moonPaymentModel[index];

                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    controller.selectedMoonIndex.value = index;
                                    Get.back();
                                    controller.selectedOption.value = 'Moon';
                                    EnergiesSelectionBottomSheet.showBottomSheetPaymentMoonSelectMenu(context);
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
                                            width: 20.w,
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
}
