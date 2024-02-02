import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/fontsize_config.dart';
import 'package:sizer/sizer.dart';

class MBankingSelectBankBottomSheet {
  static void showMBankingSelectBankBottomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                height: 70.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                child: Stack(
                  children: [
                    SingleChildScrollView(
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
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: FontSizes.headerSmallText),
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
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
                          ),
                          SizedBox(
                            height: 60.h,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                    child: InkWell(
                                      onTap: () async {
                                        Get.back();
                                      },
                                      child: Container(
                                          height: 10.h,
                                          width: 100.w,
                                          padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                          decoration:
                                              const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                  child: Text('Bank', style: TextStyle(fontSize: 10.sp, color: Colors.black))),
                                              Text(
                                                "EcoBank",
                                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18.sp),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                      child: InkWell(
                                        onTap: () async {
                                          Get.back();
                                        },
                                        child: Container(
                                            height: 10.h,
                                            width: 100.w,
                                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                            decoration:
                                                const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    decoration: const BoxDecoration(
                                                        color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                    child: Text('Bank', style: TextStyle(fontSize: 10.sp, color: Colors.black))),
                                                Text(
                                                  "La Poste",
                                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18.sp),
                                                ),
                                              ],
                                            )),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                      child: InkWell(
                                        onTap: () async {
                                          Get.back();
                                        },
                                        child: Container(
                                            height: 10.h,
                                            width: 100.w,
                                            padding: EdgeInsets.only(
                                              left: 2.w,
                                              right: 2.w,
                                            ),
                                            decoration:
                                                const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    decoration: const BoxDecoration(
                                                        color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                    child: Text('Bank', style: TextStyle(fontSize: 10.sp, color: Colors.black))),
                                                Text(
                                                  "Bank Atlantique",
                                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18.sp),
                                                ),
                                              ],
                                            )),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                      child: InkWell(
                                        onTap: () async {
                                          Get.back();
                                        },
                                        child: Container(
                                            height: 11.h,
                                            width: 100.w,
                                            padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                            decoration:
                                                const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    decoration: const BoxDecoration(
                                                        color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                    child: Text('Bank', style: TextStyle(fontSize: 10.sp, color: Colors.black))),
                                                Text(
                                                  "Orabank",
                                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18.sp),
                                                ),
                                              ],
                                            )),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      left: 0,
                      right: 0,
                      child: FluButton.text(
                        'Continue',
                        iconStrokeWidth: 1.8,
                        onPressed: () {},
                        height: 55,
                        width: 100.w,
                        cornerRadius: UISettings.minButtonCornerRadius,
                        backgroundColor: Colors.blue[900],
                        foregroundColor: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25,
                            spreadRadius: 3,
                            offset: Offset(0, 5),
                          )
                        ],
                        textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.white, fontSize: FontSizes.headerSmallText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
