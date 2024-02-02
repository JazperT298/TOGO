// ignore_for_file: unrelated_type_equality_checks

import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/mbanking/controller/mbanking_controller.dart';
import 'package:ibank/app/modules/mbanking/views/modals/mbanking_submenu_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class MBankingSelectBankBottomSheet {
  static void showMBankingSelectBankBottomSheet() {
    final controller = Get.find<MBankingController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: 70.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "MBANKING".toUpperCase(),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "My online bank",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      'Make transactions between your Flooz account and your bank accounts.',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: FluTextField(
                      hint: 'Name of the bank',
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
                  SizedBox(height: 2.h),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
                    child: SizedBox(
                      height: 40.h,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
                              child: InkWell(
                                onTap: () async {
                                  // Get.back();
                                  // controller.selectedIndex.value = 1;
                                  if (controller.selectedIndex == 1) {
                                    controller.selectedIndex.value = 0;
                                  } else {
                                    controller.selectedIndex.value = 1;
                                  }
                                },
                                child: Obx(
                                  () => Container(
                                      height: 12.h,
                                      width: 100.w,
                                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                      decoration: BoxDecoration(
                                          color: controller.selectedIndex.value == 1 ? const Color(0xFFFEE8D9) : const Color(0xFFF4F5FA),
                                          borderRadius: const BorderRadius.all(Radius.circular(30.0))),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                  child: Text('Bank', style: TextStyle(fontSize: 10.sp, color: const Color(0xFF27303F))))
                                              .paddingOnly(bottom: 1.5.h),
                                          Text(
                                            "EcoBank",
                                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18.sp),
                                          ).paddingOnly(bottom: 1.5.h),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
                                child: InkWell(
                                  onTap: () async {
                                    // controller.selectedIndex.value = 2;
                                    if (controller.selectedIndex == 24) {
                                      controller.selectedIndex.value = 0;
                                    } else {
                                      controller.selectedIndex.value = 2;
                                    }
                                    // Get.back();
                                    // Get.snackbar("Message", 'Comming Soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  },
                                  child: Obx(
                                    () => Container(
                                        height: 12.h,
                                        width: 100.w,
                                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                        decoration: BoxDecoration(
                                            color: controller.selectedIndex.value == 2 ? const Color(0xFFFEE8D9) : const Color(0xFFF4F5FA),
                                            borderRadius: const BorderRadius.all(Radius.circular(30.0))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                    decoration: const BoxDecoration(
                                                        color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                                    child: Text('Bank', style: TextStyle(fontSize: 10.sp, color: const Color(0xFF27303F))))
                                                .paddingOnly(bottom: 1.5.h),
                                            Text(
                                              "La Poste",
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18.sp),
                                            ).paddingOnly(bottom: 1.5.h),
                                          ],
                                        )),
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
                                child: InkWell(
                                  onTap: () async {
                                    if (controller.selectedIndex == 3) {
                                      controller.selectedIndex.value = 0;
                                    } else {
                                      controller.selectedIndex.value = 3;
                                    }
                                    // Get.back();
                                    // Get.snackbar("Message", 'Comming Soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  },
                                  child: Obx(
                                    () => Container(
                                        height: 12.h,
                                        width: 100.w,
                                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                        decoration: BoxDecoration(
                                            color: controller.selectedIndex.value == 3 ? const Color(0xFFFEE8D9) : const Color(0xFFF4F5FA),
                                            borderRadius: const BorderRadius.all(Radius.circular(30.0))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                    decoration: const BoxDecoration(
                                                        color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                    child: Text('Bank', style: TextStyle(fontSize: 10.sp, color: const Color(0xFF27303F))))
                                                .paddingOnly(bottom: 1.5.h),
                                            Text(
                                              "Bank Atlantique",
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18.sp),
                                            ).paddingOnly(bottom: 1.5.h),
                                          ],
                                        )),
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
                                child: InkWell(
                                  onTap: () async {
                                    if (controller.selectedIndex == 4) {
                                      controller.selectedIndex.value = 0;
                                    } else {
                                      controller.selectedIndex.value = 4;
                                    }

                                    // Get.back();
                                    // Get.snackbar("Message", 'Comming Soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                  },
                                  child: Obx(() => Container(
                                        height: 11.h,
                                        width: 100.w,
                                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                        decoration: BoxDecoration(
                                            color: controller.selectedIndex.value == 4 ? const Color(0xFFFEE8D9) : const Color(0xFFF4F5FA),
                                            borderRadius: const BorderRadius.all(Radius.circular(30.0))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                    decoration: const BoxDecoration(
                                                        color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                    child: Text('Bank', style: TextStyle(fontSize: 10.sp, color: const Color(0xFF27303F))))
                                                .paddingOnly(bottom: 1.5.h),
                                            Text(
                                              "Orabank",
                                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18.sp),
                                            ).paddingOnly(bottom: 1.5.h),
                                          ],
                                        ),
                                      )),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: FluButton.text(
                      'Continue',
                      iconStrokeWidth: 1.8,
                      onPressed: () {
                        // if (controller.codeTextField.text.isNotEmpty) {
                        //   String finalPINCode = controller.selectedMenu.replaceAll(' ', '');
                        //   if (controller.selectedSubMenu.value == "Flooz to Ecobank") {
                        //     log('Flooz to bank 1 keyword ${controller.keyword.value}');
                        //     log('Flooz to bank 1 selectMenu ${controller.selectedMenu.value}');
                        //     controller.sendFinalTransaction(
                        //         controller.keyword.value, controller.selectedMenu.value, controller.amountTextField.text, finalPINCode);
                        //   } else {
                        //     log('Flooz to bank 2 keyword ${controller.keyword.value}');
                        //     log('Flooz to bank 2 selectMenu ${controller.selectedMenu.value}');
                        //     controller.sendFinalTransaction(
                        //         controller.keyword.value, controller.selectedMenu.value, controller.amountTextField.text, finalPINCode);
                        //   }
                        //   AppGlobal.dateNow = DateTime.now().toString();
                        //   AppGlobal.timeNow = DateTime.now().toString();
                        // } else {
                        //   Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                        // }
                        if (controller.selectedIndex.value == 1) {
                          Get.back();
                          MBankingSubMenuBottomSheet.showMBankingSubMenuBottomSheet();
                        } else if (controller.selectedIndex.value == 2 ||
                            controller.selectedIndex.value == 23 ||
                            controller.selectedIndex.value == 4) {
                          Get.snackbar("Message", 'Comming soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                        } else {
                          Get.snackbar("Message", 'Please select a bank', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                        }
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
                      textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: FontSizes.buttonText),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
