// ignore_for_file: unrelated_type_equality_checks, unused_import

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/models/wallet.dart';
import 'package:ibank/app/modules/payment/view/modal/payment_sub_menu_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:sizer/sizer.dart';

class PaymentMainMenuBottomSheet {
  static void showBottomSheetPaymentMenu(BuildContext context) {
    final action = WalletAction.getAll()[2];
    // var controller = Get.find<PaymentController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: 60.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
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
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFB6404),
                            fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        'Easy and Practical',
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
                        'Select the services to pay for and simplify your financial life in just a few clicks.',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14),
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
                      padding:
                          EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: action.children.length,
                          itemBuilder: (context, index) {
                            final option = action.children[index];
                            return FluButton(
                              // onPressed: toNextStep,
                              onPressed: () async {
                                if (index != 2) {
                                  Get.snackbar(
                                      "Message", LocaleKeys.strComingSoon.tr,
                                      backgroundColor: Colors.lightBlue,
                                      colorText: Colors.white);
                                } else {
                                  AppGlobal.dateNow = '';
                                  AppGlobal.timeNow = '';
                                  FullScreenLoading
                                      .fullScreenLoadingWithTextAndTimer(
                                          'Processing. . .');
                                  await Future.delayed(
                                      const Duration(seconds: 2), () {
                                    Get.back();
                                    Get.back();
                                    PaymentSubMenuBottomSheet
                                        .showBottomSheetPaymentSubMenu(context);
                                  });
                                }
                              },
                              backgroundColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              margin: EdgeInsets.only(top: index == 0 ? 0 : 10),
                              child: Row(
                                children: [
                                  FluArc(
                                    startOfArc: 90,
                                    angle: 80,
                                    strokeWidth: 1,
                                    color: context.colorScheme.primaryContainer,
                                    child: Container(
                                        height: 62,
                                        width: 62,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFDBE4FB),
                                            shape: BoxShape.circle),
                                        child: FluIcon(
                                          option.icon,
                                          color: Colors.black,
                                        )),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0),
                                            child: Text(
                                              option.name,
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF27303F),
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Text(
                                            option.description,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF687997),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        isScrollControlled: true);
  }
}
