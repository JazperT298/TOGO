// ignore_for_file: unused_local_variable

import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/models/mbank_model.dart';
import 'package:ibank/app/modules/mbanking/controller/mbanking_controller.dart';
import 'package:ibank/app/modules/mbanking/views/modals/mbanking_select_bank_bottom_sheet.dart';
// import 'package:ibank/app/modules/mbanking/views/modals/mbanking_submenu_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class MBankingMenuBottomSheet {
  static void showMBankingMenuBottomSheet() {
    final controller = Get.find<MBankingController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 65.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                child: SingleChildScrollView(
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
                              fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "My online bank",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Securely transact between Moov Money and your affiliated bank accounts.",
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
                      // Center(
                      //   child: Padding(
                      //     padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      //     child: Text(
                      //       "You don't have an account linked yet",
                      //       textAlign: TextAlign.center,
                      //       style: GoogleFonts.montserrat(
                      //           fontWeight: FontWeight.w700,
                      //           color: Colors.black,
                      //           fontSize: 24),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 2.h),
                      // Center(
                      //   child: Padding(
                      //     padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      //     child: Text(
                      //       "Porem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero.",
                      //       textAlign: TextAlign.center,
                      //       style: GoogleFonts.montserrat(
                      //           fontWeight: FontWeight.w400,
                      //           color: Colors.black,
                      //           fontSize: 14),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 0.w, right: 0.w),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.mBankModel.length,
                            itemBuilder: (context, index) {
                              MBankModel option = controller.mBankModel[index];
                              bool isLogout = controller.lastIsLogout.value && index == controller.mBankModel.length - 1;

                              return Padding(
                                padding: EdgeInsets.only(top: .75.h, bottom: .75.h),
                                child: FluButton(
                                  onPressed: () async {
                                    if (index == 0) {
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Processing. . .');
                                      await Future.delayed(const Duration(seconds: 1), () {
                                        Get.back();
                                        Get.back();
                                        controller.selectedMenu.value = 'EcoBank';
                                        controller.amountTextField.clear();
                                        controller.codeTextField.clear();
                                        // MBankingSubMenuBottomSheet.showMBankingSubMenuBottomSheet();
                                        MBankingSelectBankBottomSheet.showMBankingSelectBankBottomSheet();
                                      });
                                    } else {
                                      Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                                          backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                                    }
                                  },
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.5.h, bottom: 1.5.h),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(
                                        option.mBankType,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: FontSizes.headerMediumText),
                                      ),
                                      SizedBox(height: .1.h),
                                      Text(
                                        option.mBankTypeDesc,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: FontSizes.headerMediumText),
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            }),
                      ),
                      // SizedBox(height: 4.h),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      //   child: FluButton.text(
                      //     'Link a bank',
                      //     iconStrokeWidth: 1.8,
                      //     onPressed: () {
                      //       FullScreenLoading.fullScreenLoadingWithText('Processing. . .');
                      //     },
                      //     height: 7.h,
                      //     width: 100.w,
                      //     cornerRadius: UISettings.minButtonCornerRadius,
                      //     backgroundColor: const Color(0xFF124DE5),
                      //     foregroundColor: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(
                      //         color: Colors.grey,
                      //         blurRadius: 25,
                      //         spreadRadius: 3,
                      //         offset: Offset(0, 5),
                      //       )
                      //     ],
                      //     textStyle:
                      //         GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: FontSizes.buttonText),
                      //   ),
                      // ),
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
