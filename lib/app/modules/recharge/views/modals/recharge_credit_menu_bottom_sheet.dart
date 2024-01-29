import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/app/modules/recharge/views/modals/recharge_credit_input_amount_bottom_sheet.dart';
import 'package:ibank/app/modules/recharge/views/modals/recharge_credit_input_number_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class RechargeCreditMainMenuBottomSheet {
  static void showBottomSheetRechargeCreditTo() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: 38.h,
              width: 100.w,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Communication credit".toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Yorem ipsum dolor sit amet, adipiscing elit.", //  "CREDIT",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                        )),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    //   child: Text(
                    //     "Do you want to recharge for yourself or others?",
                    //     style: TextStyle(
                    //       fontSize: 10.sp,
                    //     ),
                    //   ),
                    // ),
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
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          controller.amountTextField.clear();
                          controller.code.clear();
                          controller.numberTextField.clear();
                          controller.selectedOption.value = 'For myself';
                          RechargeCreditInputAmountBottomSheet.showBottomSheetInputAmount(selectedMenu: "OWN");
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              margin: const EdgeInsets.only(right: 15),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 67,
                                    width: 67,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(color: Color(0xFFDBE4FB), shape: BoxShape.circle),
                                    child: const FluIcon(FluIcons.userCircleUnicon, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'For myself', //  "OWN",
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                                ),
                                Text(
                                  "Recharge your Moov account.",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          controller.amountTextField.clear();
                          controller.code.clear();
                          controller.numberTextField.clear();
                          controller.selectedOption.value = 'For others';
                          RechargeCreditInputNumberBottomSheet.showBottomSheetInputNumber();
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              margin: const EdgeInsets.only(right: 15),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 67,
                                    width: 67,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(color: Color(0xFFDBE4FB), shape: BoxShape.circle),
                                    child: const FluIcon(FluIcons.userCirlceAdd, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'For another person', //   "OTHERS",
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                                  ),
                                  Text(
                                    "Enter the number and recharge for others.",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
