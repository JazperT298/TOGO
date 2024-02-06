// ignore_for_file: unrelated_type_equality_checks

import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/mbanking/controller/mbanking_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

import 'bank_bank_atlantique_submenu_bottom_sheet.dart';
import 'bank_laposte_submenu_bottom_sheet.dart';

class MBankingSelectLinkBankBottomSheet {
  static void showMBankingSelectLinkedBankBottomSheet(
      {required String bankName,
      required List bankList,
      required String fieldName}) {
    final controller = Get.find<MBankingController>();
    RxList linkedBanks = bankList.obs;
    RxList linkedBanksMasterList = bankList.obs;

    searchLinkedBanks({required String word}) async {
      linkedBanks.clear();
      if (word.isNotEmpty) {
        for (var i = 0; i < linkedBanksMasterList.length; i++) {
          if (linkedBanksMasterList[i][fieldName]
              .toLowerCase()
              .toString()
              .contains(word.toLowerCase().toString())) {
            linkedBanks.add(linkedBanksMasterList[i]);
          }
        }
      } else {
        linkedBanks.assignAll(linkedBanksMasterList);
      }
    }

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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
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
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFB6404),
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      bankName,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      'Make transactions between your Flooz account and your bank accounts.',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF27303F),
                          fontSize: FontSizes.headerSmallText),
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
                      onChanged: (value) {
                        // filterContacts(query);
                        searchLinkedBanks(word: value);
                      },
                      margin: const EdgeInsets.only(top: 25),
                      textStyle:
                          const TextStyle(fontSize: M3FontSizes.bodyMedium),
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
                  SizedBox(
                    height: 40.h,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: linkedBanks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 5.w, right: 5.w, bottom: 1.h),
                            child: InkWell(
                              onTap: () async {
                                if (controller.selectedLinkedBank.value == "") {
                                  controller.selectedLinkedBank.value =
                                      linkedBanks[index][fieldName];
                                } else {
                                  controller.selectedLinkedBank.value = "";
                                }
                                // Get.back();
                                // Get.snackbar("Message", 'Comming Soon', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              },
                              child: Obx(
                                () => Container(
                                    height: 12.h,
                                    width: 100.w,
                                    padding:
                                        EdgeInsets.only(left: 3.w, right: 3.w),
                                    decoration: BoxDecoration(
                                        color: controller
                                                    .selectedLinkedBank.value ==
                                                linkedBanks[index][fieldName]
                                            ? const Color(0xFFFEE8D9)
                                            : const Color(0xFFF4F5FA),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                    decoration: BoxDecoration(
                                                        color: controller
                                                                    .selectedLinkedBank
                                                                    .value ==
                                                                linkedBanks[index]
                                                                    [fieldName]
                                                            ? const Color(
                                                                0xFFFECFB1)
                                                            : const Color(
                                                                0xFFDBE4FB),
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 2),
                                                    child: Text('Bank',
                                                        style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: const Color(0xFF27303F))))
                                                .paddingOnly(bottom: 1.5.h),
                                            Text(
                                              bankName == "La Poste"
                                                  ? ('X' *
                                                          (linkedBanks[index][
                                                                      fieldName]
                                                                  .length -
                                                              4) +
                                                      linkedBanks[index]
                                                              [fieldName]
                                                          .substring(linkedBanks[
                                                                          index]
                                                                      [
                                                                      fieldName]
                                                                  .length -
                                                              4))
                                                  : linkedBanks[index]
                                                      [fieldName],
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 18.sp),
                                            ).paddingOnly(bottom: 1.5.h),
                                          ],
                                        ),
                                        controller.selectedLinkedBank.value ==
                                                linkedBanks[index][fieldName]
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    left: .3.w,
                                                    right: .3.w,
                                                    top: .2.h,
                                                    bottom: .2.h),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFFFB6404),
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 15.sp,
                                                ),
                                              )
                                            : const FluIcon(
                                                FluIcons.circleUnicon)
                                      ],
                                    )),
                              ),
                            ),
                          );
                        },
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
                        if (controller.selectedLinkedBank.value != "") {
                          Get.back();
                          if (bankName == "La Poste") {
                            MBankingLaposteSubMenuBottomSheet
                                .showMBankingLaPosteSubMenuBottomSheet();
                          }
                          if (bankName == "Bank Atlantique") {
                            MBankingBankAtlantiqueSubMenuBottomSheet
                                .showMBankingBankAtlantiqueSubMenuBottomSheet();
                          }
                          if (bankName == "Orabank") {
                            Get.snackbar("Message", 'Comming soon',
                                backgroundColor: Colors.lightBlue,
                                colorText: Colors.white);
                          }
                        } else {
                          Get.snackbar("Message", 'Please select a bank',
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
