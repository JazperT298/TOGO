import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:sizer/sizer.dart';

class MBankingSelectBankBottomSheet {
  static void showMBankingSelectBankBottomSheet() {
    Get.bottomSheet(
      Wrap(
        children: [
          bottomSheetDivider(),
          Container(
            height: 48.h,
            width: 100.w,
            decoration:
                const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
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
                  SizedBox(height: 2.h),
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
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                      },
                      child: Container(
                          height: 11.h,
                          width: 100.w,
                          padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                          decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: const BoxDecoration(color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  child: Text('Bank', style: TextStyle(fontSize: 12.sp, color: Colors.black))),
                              SizedBox(height: 1.h),
                              Text(
                                "EcoBank",
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 19.sp),
                              ),
                            ],
                          )),
                    ).paddingOnly(bottom: 2.h),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  //   child: InkWell(
                  //     onTap: () async {
                  //       Get.back();
                  //     },
                  //     child: Container(
                  //         height: 11.h,
                  //         width: 100.w,
                  //         padding: EdgeInsets.only(
                  //             left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                  //         decoration: const BoxDecoration(
                  //             color: Color(0xFFF4F5FA),
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10.0))),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //                 decoration: const BoxDecoration(
                  //                     color: Color(0xFFDBE4FB),
                  //                     borderRadius: BorderRadius.all(
                  //                         Radius.circular(10.0))),
                  //                 padding: const EdgeInsets.symmetric(
                  //                     horizontal: 10, vertical: 2),
                  //                 child: Text('Bank',
                  //                     style: TextStyle(
                  //                         fontSize: 12.sp,
                  //                         color: Colors.black))),
                  //             SizedBox(height: 1.h),
                  //             Text(
                  //               "OraBank",
                  //               style: GoogleFonts.montserrat(
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Colors.black,
                  //                   fontSize: 19.sp),
                  //             ),
                  //           ],
                  //         )),
                  //   ).paddingOnly(bottom: 2.h),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
