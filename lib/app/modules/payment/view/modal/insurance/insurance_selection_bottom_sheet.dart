// ignore_for_file: unnecessary_string_interpolations

import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/insurance/insurance_otp_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class InsuranceSelectionBottomSheet {
  static void showBottomSheetInsuranceTypeSelectMenu(BuildContext context) {
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
                          '${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'You will pay a premium for ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                            ),
                            TextSpan(
                              text: '${controller.numberTextField.text} ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'For what type of insurance do you want to make a contribution?',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.headerMediumText),
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
                        width: 100.w,
                        child: ListView.builder(
                          itemCount: controller.insuranceTypeModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                              child: GestureDetector(
                                onTap: () async {
                                  if (controller.insuranceTypePackageRadioGroupValue.value == controller.insuranceTypeModel[index].title) {
                                    controller.insuranceTypePackageRadioGroupValue.value = '';
                                    controller.selectedInsuranceTypeModel = null;
                                  } else {
                                    controller.insuranceTypePackageRadioGroupValue.value = controller.insuranceTypeModel[index].title;
                                    controller.selectedInsuranceTypeModel = controller.insuranceTypeModel[index];
                                    await Future.delayed(const Duration(seconds: 2), () {
                                      Get.back();
                                      showBottomSheetInsurancePolicySelectMenu(context);
                                    });
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                    height: 10.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color: controller.insuranceTypePackageRadioGroupValue.value == controller.insuranceTypeModel[index].title
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
                                                controller.insuranceTypeModel[index].title,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerLargeText),
                                              ),
                                              // Text(
                                              //   controller.ceetDataList[index].reference,
                                              //   style: GoogleFonts.montserrat(
                                              //       fontWeight: FontWeight.w400,
                                              //       color: const Color(0xFF687997),
                                              //       fontSize: FontSizes.headerMediumText),
                                              // ),
                                            ],
                                          ),
                                          Obx(
                                            () => Radio(
                                                value: controller.insuranceTypeModel[index].title,
                                                groupValue: controller.insuranceTypePackageRadioGroupValue.value,
                                                onChanged: (value) {
                                                  controller.insuranceTypePackageRadioGroupValue.value = controller.insuranceTypeModel[index].title;
                                                  controller.selectedInsuranceTypeModel = controller.insuranceTypeModel[index];
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
                        ).paddingOnly(bottom: 3.h),
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

  static void showBottomSheetInsurancePolicySelectMenu(BuildContext context) {
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
                          '${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'You will pay a premium for ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                            ),
                            TextSpan(
                              text: '${controller.numberTextField.text} ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Which of your insurance policies do you want to pay for?',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.headerMediumText),
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
                        height: 35.h,
                        width: 100.w,
                        child: ListView.builder(
                          itemCount: controller.insurancePolicyModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                              child: GestureDetector(
                                onTap: () async {
                                  if (controller.insurancePolicyPackageRadioGroupValue.value == controller.insurancePolicyModel[index].title) {
                                    controller.insurancePolicyPackageRadioGroupValue.value = '';
                                    controller.selectedInsurancePolicyModel = null;
                                  } else {
                                    controller.insurancePolicyPackageRadioGroupValue.value = controller.insurancePolicyModel[index].title;
                                    controller.selectedInsurancePolicyModel = controller.insurancePolicyModel[index];
                                    await Future.delayed(const Duration(seconds: 2), () {
                                      Get.back();
                                      showBottomSheetInsuranceTermsSelectMenu(context);
                                    });
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                    height: 10.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color: controller.insurancePolicyPackageRadioGroupValue.value == controller.insurancePolicyModel[index].title
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
                                                controller.insurancePolicyModel[index].title,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerLargeText),
                                              ),
                                              // Text(
                                              //   controller.ceetDataList[index].reference,
                                              //   style: GoogleFonts.montserrat(
                                              //       fontWeight: FontWeight.w400,
                                              //       color: const Color(0xFF687997),
                                              //       fontSize: FontSizes.headerMediumText),
                                              // ),
                                            ],
                                          ),
                                          Obx(
                                            () => Radio(
                                                value: controller.insurancePolicyModel[index].title,
                                                groupValue: controller.insurancePolicyPackageRadioGroupValue.value,
                                                onChanged: (value) {
                                                  controller.insurancePolicyPackageRadioGroupValue.value =
                                                      controller.insurancePolicyModel[index].title;
                                                  controller.selectedInsurancePolicyModel = controller.insurancePolicyModel[index];
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
                        ).paddingOnly(bottom: 3.h),
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

  static void showBottomSheetInsuranceTermsSelectMenu(BuildContext context) {
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
                          '${controller.selectedOption.value}'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'You will pay a premium for ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                            ),
                            TextSpan(
                              text: '${controller.numberTextField.text} ',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, color: const Color(0xFF295fe7), fontSize: FontSizes.headerLargeText),
                            )
                          ]),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'For how long do you want to make the contribution?',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: FontSizes.headerMediumText),
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
                        height: 38.h,
                        width: 100.w,
                        child: ListView.builder(
                          itemCount: controller.insuranceTermsModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                              child: GestureDetector(
                                onTap: () async {
                                  if (controller.insuranceTermsPackageRadioGroupValue.value == controller.insuranceTermsModel[index].title) {
                                    controller.insuranceTermsPackageRadioGroupValue.value = '';
                                    controller.insuranceTermsDescPackageRadioGroupValue.value = '';
                                    controller.selectedInsuranceTermsModel = null;
                                  } else {
                                    controller.insuranceTermsPackageRadioGroupValue.value = controller.insuranceTermsModel[index].title;
                                    controller.insuranceTermsDescPackageRadioGroupValue.value =
                                        controller.insuranceTermsModel[index].description.replaceAll(' ', '');
                                    controller.selectedInsuranceTermsModel = controller.insuranceTermsModel[index];
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                    height: 10.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color: controller.insuranceTermsPackageRadioGroupValue.value == controller.insuranceTermsModel[index].title
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
                                                controller.insuranceTermsModel[index].title,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerLargeText),
                                              ),
                                              Text(
                                                '${controller.insuranceTermsModel[index].description} FCFA',
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: FontSizes.headerSmallText),
                                              ),
                                            ],
                                          ),
                                          Obx(
                                            () => Radio(
                                                value: controller.insuranceTermsModel[index].title,
                                                groupValue: controller.insuranceTermsPackageRadioGroupValue.value,
                                                onChanged: (value) {
                                                  controller.insuranceTermsPackageRadioGroupValue.value = controller.insuranceTermsModel[index].title;
                                                  controller.insuranceTermsDescPackageRadioGroupValue.value =
                                                      controller.insuranceTermsModel[index].description.replaceAll(' ', '');
                                                  controller.selectedInsuranceTermsModel = controller.insuranceTermsModel[index];
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
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluButton.text(
                          'Select',
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.insuranceTermsPackageRadioGroupValue.value.isEmpty) {
                              Get.snackbar("Message", 'Please select a reference', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            } else {
                              Get.back();
                              Get.back();
                              InsuranceOtpBottomSheet.showBottomSheetOTPInsurance();
                              // EnergiesAmountBottomSheet.showBottomSheetSolevaInputAmount();
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
                      SizedBox(height: 3.h),
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
