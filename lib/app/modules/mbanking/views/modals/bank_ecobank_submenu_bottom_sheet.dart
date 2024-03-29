// ignore_for_file: unused_local_variable, unused_import

import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/models/mbank_sub_model.dart';
import 'package:ibank/app/modules/mbanking/controller/mbanking_controller.dart';
import 'package:ibank/app/modules/mbanking/views/modals/bank_ecobank_input_amount_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/fontsize_config.dart';

class MBankingEcoSubMenuBottomSheet {
  static void showMBankingEcoSubMenuBottomSheet() {
    final controller = Get.find<MBankingController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 50.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
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
                          "BANK".toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFB6404),
                              fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Ecobank",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Operate your transactions between Moov Money Flooz and your Ecobank account with complete peace of mind",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: FontSizes.headerSmallText),
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
                      Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 24),
                              itemCount: controller.mBankSubModel.length,
                              itemBuilder: (context, index) {
                                MBankSubModel option =
                                    controller.mBankSubModel[index];
                                bool isLogout = controller.lastIsLogout.value &&
                                    index ==
                                        controller.mBankSubModel.length - 1;

                                return FluButton(
                                  onPressed: () async {
                                    if (index == 0) {
                                      FullScreenLoading
                                          .fullScreenLoadingWithTextAndTimer(
                                              'Verifying. . .');
                                      await Future.delayed(
                                          const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        controller.selectedSubMenu.value =
                                            'Flooz to Ecobank';
                                        controller.destmsisdn.value =
                                            'ECOBANK_MAINBANK';
                                        controller.keyword.value = 'W2BE';
                                        MBankingEcobankInputAmountBottomSheet
                                            .showBottomSheetEcobankInputAmount(
                                                selectedMenu: controller
                                                    .selectedSubMenu.value);
                                      });
                                    } else if (index == 1) {
                                      FullScreenLoading
                                          .fullScreenLoadingWithTextAndTimer(
                                              'Verifying. . .');
                                      await Future.delayed(
                                          const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        controller.selectedSubMenu.value =
                                            'Ecobank to Flooz';
                                        controller.destmsisdn.value =
                                            'ECOBANK_MAINBANK';
                                        controller.keyword.value = 'B2WE';
                                        MBankingEcobankInputAmountBottomSheet
                                            .showBottomSheetEcobankInputAmount(
                                                selectedMenu: controller
                                                    .selectedSubMenu.value);
                                      });
                                    }
                                  },
                                  backgroundColor:
                                      context.colorScheme.background,
                                  margin:
                                      EdgeInsets.only(top: .7.h, bottom: .7.h),
                                  padding: EdgeInsets.zero,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                                height: 10.h,
                                                width: 20.w,
                                                child: RotatedBox(
                                                  quarterTurns: 2,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 1.5,
                                                    value: .25,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      (isLogout
                                                              ? Colors.red
                                                              : context
                                                                  .colorScheme
                                                                  .primary)
                                                          .withOpacity(.1),
                                                    ),
                                                  ),
                                                )),
                                            Container(
                                              height: 9.h,
                                              width: 20.w,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFFDBE4FB),
                                                  shape: BoxShape.circle),
                                              child: FluIcon(option.icon,
                                                  size: 24,
                                                  strokeWidth: 1.6,
                                                  color: isLogout
                                                      ? Colors.red
                                                      : Colors.black),
                                            ),
                                          ],
                                        ),
                                      ).paddingOnly(right: 10),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text(
                                              option.mBankType,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF27303F),
                                                  fontSize: FontSizes
                                                      .headerMediumText),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              option.mBankType,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xFF687997),
                                                  fontSize: FontSizes
                                                      .headerMediumText),
                                            ),
                                          ])),
                                      // const SizedBox(width: 15),
                                      // FluIcon(
                                      //   FluIcons.arrowRight1,
                                      //   size: 18,
                                      //   color: isLogout ? Colors.red : context.colorScheme.onBackground,
                                      // ),
                                    ],
                                  ),
                                );
                              })),
                      SizedBox(height: 3.0.h),
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
