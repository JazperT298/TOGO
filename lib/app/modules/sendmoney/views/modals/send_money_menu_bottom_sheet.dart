import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/sendmoney/controller/send_money_controller.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/send_money_input_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:sizer/sizer.dart';

class SendMoneyMenuBottomSheet {
  static void showBottomSheetSendMoneyMenu() {
    final controller = Get.put(SendMoneyController());
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: 38.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strWalletSend.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          LocaleKeys.strMoneyTransferTitle.tr,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                        )),
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
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          AppGlobal.siOTPPage = false;
                          AppGlobal.dateNow = '';
                          AppGlobal.timeNow = '';
                          controller.clearInputAndData();
                          SendMoneyInputBottomSheet.showBottomSheetSendMoneyNationaInputNumber();
                        },
                        child: Container(
                            height: 9.h,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                            decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: const BoxDecoration(color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    child: const Text('Send money', style: TextStyle(color: Colors.black))),
                                const SizedBox(height: 12),
                                Text(
                                  LocaleKeys.strNationalTransfer.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                                ),
                              ],
                            )),
                      ).paddingOnly(bottom: 12),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          AppGlobal.siOTPPage = false;
                          AppGlobal.dateNow = '';
                          AppGlobal.timeNow = '';
                          controller.clearInputAndData();
                          SendMoneyInputBottomSheet.showBottomSheetSendMoneyInterationaInputNumber();
                        },
                        child: Container(
                            height: 9.h,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                            decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: const BoxDecoration(color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    child: const Text('Send money', style: TextStyle(color: Colors.black))),
                                const SizedBox(height: 12),
                                Text(
                                  LocaleKeys.strInternationalTransfer.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                                ),
                              ],
                            )),
                      ).paddingOnly(bottom: 12),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                    //         backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                    //   },
                    //   child: Container(
                    //       height: 9.h,
                    //       width: MediaQuery.of(context).size.width,
                    //       padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    //       decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //               decoration: const BoxDecoration(color: Color(0xFFDBE4FB), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    //               child: Text(LocaleKeys.strWalletSend.tr, style: const TextStyle(color: Colors.black))),
                    //           const SizedBox(height: 12),
                    //           Text(
                    //             LocaleKeys.strReversal.tr,
                    //             style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.bold),
                    //           ),
                    //         ],
                    //       )),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
