import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/modules/payment/controller/payment_controller.dart';
import 'package:ibank/app/modules/payment/view/modal/merchant_payment/merchant_payment_service_link_bottom_sheet.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class MerchantPaymentSubMenuBottomSheet {
  static void showBottomSheetPaymentMerchantSubMenu(BuildContext context) {
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
                          'Pay your merchants',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'On site or online, make your purchases easily with Moov Money Flooz',
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
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.paymentMerchatList.length,
                              itemBuilder: (context, index) {
                                final option = controller.paymentMerchatList[index];

                                return FluButton(
                                  // onPressed: toNextStep,
                                  onPressed: () async {
                                    if (index == 0) {
                                      controller.numberTextField.clear();
                                      controller.selectedOption.value = 'Contactless payment';
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Requesting. . .');
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        MerchantPaymentServiceLinkBottomSheet.showBottomSheetPaymentMerchantSelectMenu(context);
                                      });
                                    } else if (index == 1) {
                                      controller.numberTextField.clear();
                                      controller.selectedOption.value = 'Online payment';
                                      FullScreenLoading.fullScreenLoadingWithTextAndTimer('Requesting. . .');
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        Get.back();
                                        Get.back();
                                        showBottomSheetMerchantOnlinePayment();
                                      });
                                    } else {
                                      Get.snackbar("Message", "Comming Soon", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                    }
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

  static void showBottomSheetMerchantOnlinePayment() {
    var controller = Get.find<PaymentController>();
    Get.bottomSheet(backgroundColor: Colors.transparent, KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              // height: isKeyboardVisible ? 25.h : 32.h,
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
                        child: Obx(() => Text(
                              controller.selectedOption.value.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: FontSizes.headerMediumText),
                            ))),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Pay for your groceries online with ease",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: FontSizes.headerLargeText),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
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
                      height: 15.h,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        child: Center(
                          child: Text(
                            'You have no pending online payments',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
                          ),
                        ),
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
      );
    }), isScrollControlled: true);
  }
}
