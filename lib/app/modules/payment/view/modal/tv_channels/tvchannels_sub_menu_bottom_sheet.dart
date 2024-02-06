import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/tv_channels/tvchannels_inputs_bottom_sheet.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class TvChannelsSubMenuBottomSheet {
  static void showBottomSheetPaymentTvChannelsSubMenu(BuildContext context) {
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
                          'TV Channels',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Select your TV provider and pay for the package that reflects your desires in a few seconds.',
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
                        height: 26.h,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.tvChannelsMode.length,
                              itemBuilder: (context, index) {
                                final option = controller.tvChannelsMode[index];

                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    if (index == 0) {
                                      controller.selectedOption.value = 'Canal +';
                                      controller.ceetPackageRadioGroupValue.value = '';
                                      controller.numberTextField.clear();
                                      controller.code.clear();
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Requesting. . .');
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        TvChannelsInputsBottomSheet.showBottomSheetTvChannelsInputNumber();
                                      });
                                    } else if (index == 2) {
                                      controller.selectedOption.value = 'New World TV';
                                      controller.numberTextField.clear();
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Requesting. . .');
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        TvChannelsInputsBottomSheet.showBottomSheetTvChannelsInputNumber();
                                      });
                                    } else {
                                      Get.snackbar("Message", "Comming Soon", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    }
                                  },
                                  backgroundColor: Colors.transparent,
                                  splashFactory: NoSplash.splashFactory,
                                  margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                                  child: Row(
                                    children: [
                                      FluArc(
                                        startOfArc: 90,
                                        angle: 90,
                                        strokeWidth: 1,
                                        color: context.colorScheme.primaryContainer,
                                        child: Container(
                                            height: 9.h,
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
                                              Padding(
                                                padding: EdgeInsets.only(bottom: .5.h),
                                                child: Text(
                                                  option.title,
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF27303F),
                                                      fontSize: FontSizes.headerMediumText),
                                                ),
                                              ),
                                              Text(
                                                option.description,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(0xFF687997),
                                                    fontSize: FontSizes.headerMediumText),
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
