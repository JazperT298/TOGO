// ignore_for_file: avoid_print, unused_local_variable

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class RechargeMenuDialog {
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

  static void showRecapOperationDialog(context) async {
    // flutter defined function
    final controller = Get.find<RechargeController>();
    print("Amount: ${controller.thisHsonString.value}");

    Map<String, String> extractedValues =
        extractValuesFromJson2(controller.thisHsonString.value);

    String amount = extractedValues['amount'] ?? '';
    String trais = extractedValues['trais'] ?? '';
    String taf = extractedValues['taf'] ?? '';
    String nom = extractedValues['nom'] ?? '';
    String nouveauSolde = extractedValues['nouveauSolde'] ?? '';
    String txnId = extractedValues['txnId'] ?? '';

    print("DOL: $nouveauSolde");
    print("nom: $nom");
    print("TXN: $txnId");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object

        return AlertDialog(
          insetPadding: const EdgeInsets.all(12), // Outside Padding
          contentPadding: const EdgeInsets.all(12),

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
                          "Operation Recap",
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
                    const SizedBox(height: 24),
                    Text(
                      'Beneficiary'.toUpperCase(),
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
                            'Name',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            // controller.nickname.value,
                            controller.selectedOption.value == "For myself"
                                ? 'Moi-même'
                                : controller.numberTextField.text,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 6),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'Number',
                    //         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         msisdn,
                    //         style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
                            controller.totalAmount.value == 0
                                ? '0 FCFA'
                                : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
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
                            controller.totalFess.value == 0
                                ? '0 FCFA'
                                : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA',
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
                            controller.senderkeycosttva.value.isEmpty
                                ? '0 FCFA'
                                : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString()))} FCFA',
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
                            controller.totalAmount.value == 0
                                ? '0 FCFA'
                                : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
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
                            DateFormat('dd/MM/yyyy')
                                .format(DateTime.parse(AppGlobal.dateNow)),
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
                            'Hour',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat('hh:mm:ss')
                                .format(DateTime.parse(AppGlobal.timeNow)),
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
                            'Txn ID',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            controller.transactionID.value,
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
                            'New Balance',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF27303F),
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${controller.senderBalance.value} FCFA',
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
