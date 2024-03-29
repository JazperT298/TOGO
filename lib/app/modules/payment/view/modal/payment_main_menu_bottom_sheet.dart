// ignore_for_file: unrelated_type_equality_checks, unused_import

import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/payment/view/modal/energies/energies_sub_menu_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/insurance/insurance_sub_menu_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/merchant_payment/merchant_payment_sub_menu_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_sub_menu_bottom_sheet.dart';
import 'package:ibank/app/modules/payment/view/modal/tv_channels/tvchannels_sub_menu_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class PaymentMainMenuBottomSheet {
  static void showBottomSheetPaymentMenu(BuildContext context) {
    final action = WalletAction.getAll()[2];
    // var controller = Get.find<PaymentController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: 60.h,
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
                          'Easy and Practical',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Select the services to pay for and simplify your financial life in just a few clicks.',
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
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
                        child: SizedBox(
                          height: 45.h,
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: action.children.length,
                              itemBuilder: (context, index) {
                                final option = action.children[index];
                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    if (index == 0) {
                                      AppGlobal.dateNow = '';
                                      AppGlobal.timeNow = '';
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Processing. . .');
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        MerchantPaymentSubMenuBottomSheet.showBottomSheetPaymentMerchantSubMenu(context);
                                      });
                                    } else if (index == 1) {
                                      AppGlobal.dateNow = '';
                                      AppGlobal.timeNow = '';
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Processing. . .');
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        TvChannelsSubMenuBottomSheet.showBottomSheetPaymentTvChannelsSubMenu(context);
                                      });
                                    } else if (index == 2) {
                                      AppGlobal.dateNow = '';
                                      AppGlobal.timeNow = '';
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Processing. . .');
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        EnergiesSubMenuBottomSheet.showBottomSheetPaymentCeetSubMenu(context);
                                      });
                                    } else if (index == 4) {
                                      AppGlobal.dateNow = '';
                                      AppGlobal.timeNow = '';
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Processing. . .');
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        InsuranceSubMenuBottomSheet.showBottomSheetInsuranceSubMenu(context);
                                      });
                                    } else {
                                      Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                                          backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    }
                                  },
                                  backgroundColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  margin: EdgeInsets.only(top: index == 0 ? 0 : 16),
                                  child: Row(
                                    children: [
                                      FluArc(
                                        startOfArc: 90,
                                        angle: 80,
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
                                                option.name,
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
