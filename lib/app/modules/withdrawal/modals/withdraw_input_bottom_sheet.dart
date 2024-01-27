// ignore_for_file: unused_local_variable

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:sizer/sizer.dart';

class WithdrawInputBottomSheet {
  static void showBottomSheetInputNumber() {
    var controller = Get.put(WithdrawalController());
    Get.bottomSheet(
      Container(
        height: 30.h,
        width: 100.w,
        decoration:
            const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Withdraw normal".toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Yorem ipsum dolor sit amet, adipiscing elit.",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                ),
              ),
              SizedBox(
                height: 4.h,
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
              SizedBox(
                height: 4.h,
              ),
              Center(
                child: Text(
                  'You have no pending withdrawals',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
   
   );
  }
}
