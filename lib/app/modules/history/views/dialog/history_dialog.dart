import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../../components/line_separator.dart';

class HistoryDialog {
  static void showHistoryDialog(context, message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object

        return AlertDialog(
          insetPadding: const EdgeInsets.all(12), // Outside Padding
          contentPadding: const EdgeInsets.all(12), // Content Padding
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(child: Text(message))),
        );
      },
    );
  }

  static showMessageDialog({required String message}) async {
    Get.dialog(AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 11.sp),
            ),
          ),
        )));
  }

  static void showNewHistoryDialog({
    required BuildContext context,
    required String message,
    required String service,
    required String beneficiary,
    required String amount,
    required String fees,
    required String tax,
    required String ttc,
    required String operationDate,
    required String operationHour,
    required String txnID,
    required String newBalance,
    required bool status,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object

        return AlertDialog(
          contentPadding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
          content: Wrap(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "History",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 24),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const FluIcon(
                            FluIcons.closeCircle,
                            size: 30,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF27303F),
                          fontSize: 13.sp),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Container(
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFE7EDFC)),
                          child: Center(
                            child: Text(
                              beneficiary,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 13.sp),
                            ),
                          ),
                        )),
                    const SizedBox(height: 24),
                    const LineSeparator(color: Colors.grey),
                    const SizedBox(height: 24),
                    Text(
                      'DETAILS'.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF27303F),
                          fontSize: 14),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Amount',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            amount.isEmpty
                                ? '0 FCFA'
                                : '${StringHelper.formatNumberWithCommas(int.parse(amount.toString().replaceAll(',', '')))} FCFA',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Fees',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            fees == "0" || fees == ""
                                ? '0 FCFA'
                                : '${StringHelper.formatNumberWithCommas(int.parse(fees.toString().replaceAll(',', '')))} FCFA',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Tax',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            tax.isEmpty || tax == "0"
                                ? '0 FCFA'
                                : '${StringHelper.formatNumberWithCommas(int.parse(tax.toString().replaceAll(',', '')))} FCFA',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'TTC',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ttc == "0" || ttc == ""
                                ? '0 FCFA'
                                : '${StringHelper.formatNumberWithCommas(int.parse(ttc.toString().replaceAll(',', '')))} FCFA',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const LineSeparator(color: Colors.grey),
                    const SizedBox(height: 24),
                    Text(
                      'Operation information'.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF27303F),
                          fontSize: 14),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Date',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            operationDate,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Hour',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            operationHour,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Txn ID',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            txnID,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'New Balance',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "$newBalance FCFA",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
