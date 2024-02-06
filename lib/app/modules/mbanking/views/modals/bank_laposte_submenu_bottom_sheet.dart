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
import 'bank_laposte_input_amount_bottom_sheet.dart';

class MBankingLaposteSubMenuBottomSheet {
  static void showMBankingLaPosteSubMenuBottomSheet() {
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
                          "La Poste",
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
                          "Operate your transactions between Moov Money Flooz and your La Poste account with complete peace of mind",
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
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluButton(
                          onPressed: () async {
                            controller.selectedSubMenu.value =
                                'Flooz to La Poste';
                            controller.destmsisdn.value = 'POSTAL_W2B';
                            controller.keyword.value = 'PW2B';
                            Get.back();
                            MBankingLaPosteInputAmountBottomSheet
                                .showBottomSheetLaPosteInputAmount(
                                    selectedMenu:
                                        controller.selectedSubMenu.value);
                          },
                          backgroundColor: Get.context!.colorScheme.background,
                          margin: EdgeInsets.only(top: .7.h, bottom: .7.h),
                          padding: EdgeInsets.zero,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            value: .25,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              (Get.context!.colorScheme.primary)
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
                                      child: const FluIcon(FluIcons.profile,
                                          size: 24,
                                          strokeWidth: 1.6,
                                          color: Colors.black),
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
                                      "Flooz to La Poste",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF27303F),
                                          fontSize: FontSizes.headerMediumText),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "La Poste",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF687997),
                                          fontSize: FontSizes.headerMediumText),
                                    ),
                                  ])),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluButton(
                          onPressed: () async {
                            controller.selectedSubMenu.value =
                                'La Poste to Flooz';
                            controller.destmsisdn.value = 'POSTAL_B2W';
                            controller.keyword.value = 'PB2W';
                            Get.back();
                            MBankingLaPosteInputAmountBottomSheet
                                .showBottomSheetLaPosteInputAmount(
                                    selectedMenu:
                                        controller.selectedSubMenu.value);
                          },
                          backgroundColor: Get.context!.colorScheme.background,
                          margin: EdgeInsets.only(top: .7.h, bottom: .7.h),
                          padding: EdgeInsets.zero,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            value: .25,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              (Get.context!.colorScheme.primary)
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
                                      child: const FluIcon(FluIcons.profile,
                                          size: 24,
                                          strokeWidth: 1.6,
                                          color: Colors.black),
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
                                      "La Poste to Flooz",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF27303F),
                                          fontSize: FontSizes.headerMediumText),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "Send money to Flooz",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF687997),
                                          fontSize: FontSizes.headerMediumText),
                                    ),
                                  ])),
                            ],
                          ),
                        ),
                      ),
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
