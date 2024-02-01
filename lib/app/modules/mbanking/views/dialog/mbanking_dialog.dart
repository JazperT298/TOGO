import 'package:ibank/app/modules/mbanking/controller/mbanking_controller.dart';
// ignore_for_file: unnecessary_new, prefer_const_constructors, sized_box_for_whitespace, avoid_print, unused_import, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/app/data/models/transac_reponse.dart';
import 'package:ibank/app/data/models/transaction_fee.dart';
import 'package:ibank/app/modules/sendmoney/controller/send_money_controller.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_international_bottom_sheet.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_national_bottom_sheet.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class MBankingMenuDialog {
  static void showRecapOperationDialog(context) async {
    // flutter defined function
    final controller = Get.find<MBankingController>();

    Map<String, String> extractedValues = extractValues(controller.thisDsonString.value);
    Map<String, dynamic> jsonData = jsonDecode(controller.thisDsonString.value);

    String amount = extractedValues['amount'] ?? '';
    String beneficiaire = extractedValues['beneficiaire'] ?? '';
    String date = extractedValues['date'] ?? '';
    String codeRetait = extractedValues['codeRetait'] ?? '';
    String nouveauSolde = extractedValues['nouveauSolde'] ?? '';
    String txnId = extractedValues['txnId'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object

        return AlertDialog(
          insetPadding: EdgeInsets.all(12), // Outside Padding
          contentPadding: EdgeInsets.all(12),

          content: Container(
            width: MediaQuery.of(context).size.width - 60,
            height: 530,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Operation Recap",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: FluIcon(
                        FluIcons.closeCircle,
                        size: 30,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),

                Text(
                  LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 13.sp),
                ),

                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Container(
                      height: 7.h,
                      width: 100.w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                      child: Center(
                        child: Text(
                          "Moi meme",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 13.sp),
                        ),
                      ),
                    )),

                // Text(
                //   'Bénéficiaire'.toUpperCase(),
                //   style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                // ),
                // const SizedBox(height: 18),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: Text(
                //         'Bank',
                //         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                //       ),
                //     ),
                //     Expanded(
                //       child: Text(
                //         StringHelper.capitalizeFirstLetter(controller.selectedMenu.value.toString()),
                //         style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 18),
                // Obx(
                //   () => controller.firstname.value.isEmpty
                //       ? SizedBox.shrink()
                //       : Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Expanded(
                //               child: Text(
                //                 'Name',
                //                 style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                //               ),
                //             ),
                //             Expanded(
                //               child: Text(
                //                 '${controller.firstname.value} ${controller.lastname.value}',
                //                 style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                //               ),
                //             ),
                //           ],
                //         ),
                // ),
                const SizedBox(height: 24),
                const LineSeparator(color: Colors.grey),
                const SizedBox(height: 24),
                Text(
                  'DETAILS'.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Amount',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.amountTextField.text.isEmpty
                            ? '0 FCFA'
                            : '${StringHelper.formatNumberWithCommas(int.parse(controller.amountTextField.text.toString().replaceAll(',', '')))} FCFA',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.totalFess.value == 0
                            ? '0 FCFA'
                            : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.senderkeycosttva.value.isEmpty
                            ? '0 FCFA'
                            : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.totalAmount.value == 0
                            ? '0 FCFA'
                            : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const LineSeparator(color: Colors.grey),
                const SizedBox(height: 24),
                Text(
                  'Operation information'.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Date',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        DateFormat.yMMMd().format(DateTime.now()),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        DateFormat.jm().format(DateTime.now()),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.transactionID.value,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${controller.senderBalance.value} FCFA",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Map<String, String> extractValues(String message) {
    String amountPattern = r'Montant: (\d+ FCFA)';
    String beneficiairePattern = r'Beneficiaire: ([^\r\n]+)';
    String datePattern = r'Date: (\d+-[A-Za-z]+-\d+ \d+:\d+:\d+)';
    String codeRetraitPattern = 'rCode de retrait ([^ \r\n]+)';
    String nouveauSoldePattern = r'Nouveau solde Flooz: ([^ \r\n]+)';
    String txnIdPattern = r'Txn ID: (\d+)';

    RegExp amountRegExp = RegExp(amountPattern);
    RegExp beneficiaireRegExp = RegExp(beneficiairePattern);
    RegExp dateRegExp = RegExp(datePattern);
    RegExp codeRetraitRegExp = RegExp(codeRetraitPattern);
    RegExp nouveauSoldeRegExp = RegExp(nouveauSoldePattern);
    RegExp txnIdRegExp = RegExp(txnIdPattern);

    Match? amountMatch = amountRegExp.firstMatch(message);
    Match? beneficiaireMatch = beneficiaireRegExp.firstMatch(message);
    Match? dateMatch = dateRegExp.firstMatch(message);
    Match? codeRetraitMatch = codeRetraitRegExp.firstMatch(message);
    Match? nouveauSoldeMatch = nouveauSoldeRegExp.firstMatch(message);
    Match? txnIdMatch = txnIdRegExp.firstMatch(message);

    String amount = amountMatch != null ? amountMatch.group(1)! : '';
    String beneficiaire = beneficiaireMatch != null ? beneficiaireMatch.group(1)! : '';
    String date = dateMatch != null ? dateMatch.group(1)! : '';
    String codeRetait = codeRetraitMatch != null ? codeRetraitMatch.group(1)! : '';
    String nouveauSolde = nouveauSoldeMatch != null ? nouveauSoldeMatch.group(1)! : '';
    String txnId = txnIdMatch != null ? txnIdMatch.group(1)! : '';

    return {
      'amount': amount,
      'beneficiaire': beneficiaire,
      // 'codeRetait': codeRetait,
      'date': date,
      'nouveauSolde': nouveauSolde,
      'txnId': txnId,
    };
  }
}
