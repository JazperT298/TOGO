// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unused_local_variable, avoid_print, unused_import

import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:intl/intl.dart';

class WithdrawalDialog {
  static void showRecapOperationDialog(context, msisdn, amounts, trimString) async {
    // flutter defined function
    final controller = Get.put(WithdrawalController());
    print("Amount: $trimString");

    Map<String, String> extractedValues = extractValues(trimString);

    String amount = extractedValues['amount'] ?? '';
    String trais = extractedValues['trais'] ?? '';
    String taf = extractedValues['taf'] ?? '';
    String nom = extractedValues['nom'] ?? '';
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
            height: 440,
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
                  'Point of sale'.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Name',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => Text(
                          controller.nickname.value,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
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
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Frais',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.fees.value.isEmpty
                            ? '0 FCFA'
                            : '${StringHelper.formatNumberWithCommas(int.parse(controller.fees.value.replaceAll(',', '')))} FCFA',
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
                        'Montant',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.amount.value.isEmpty
                            ? '0 FCFA'
                            : '${StringHelper.formatNumberWithCommas(int.parse(controller.amount.value.replaceAll(',', '')))} FCFA',
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
                        DateFormat('dd/MM/yyyy').format(DateTime.parse(AppGlobal.dateNow)),
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
                        DateFormat('hh:mm:ss').format(DateTime.parse(AppGlobal.timeNow)),
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
                        txnId.isEmpty ? '' : txnId,
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
                        'Nouveau solde',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        nouveauSolde.isEmpty ? '' : '${StringHelper.formatNumberWithCommas(int.parse(nouveauSolde.replaceAll(',', '')))} FCFA',
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
    String fraisPattern = r'Frais HT: ([^\r\n]+)';
    String tafPattern = r'TAF: (\d+-[A-Za-z]+-\d+ \d+:\d+:\d+)';
    String nomPDVPattern = r'Nom PDV: ([^ \r\n]+)';
    String nouveauSoldePattern = r'Nouveau solde Flooz: ([^ \r\n]+)';
    String trxIdPattern = r'Trx id: (\d+)';

    RegExp amountRegExp = RegExp(amountPattern);
    RegExp fraisRegExp = RegExp(fraisPattern);
    RegExp tafRegExp = RegExp(tafPattern);
    RegExp nomRegExp = RegExp(nomPDVPattern);
    RegExp nouveauSoldeRegExp = RegExp(nouveauSoldePattern);
    RegExp trxIdRegExp = RegExp(trxIdPattern);

    Match? amountMatch = amountRegExp.firstMatch(message);
    Match? fraisMatch = fraisRegExp.firstMatch(message);
    Match? tafMatch = tafRegExp.firstMatch(message);
    Match? nomMatch = nomRegExp.firstMatch(message);
    Match? nouveauSoldeMatch = nouveauSoldeRegExp.firstMatch(message);
    Match? trxIdMatch = trxIdRegExp.firstMatch(message);

    String amount = amountMatch != null ? amountMatch.group(1)! : '';
    String frais = fraisMatch != null ? fraisMatch.group(1)! : '';
    String taf = tafMatch != null ? tafMatch.group(1)! : '';
    String nom = nomMatch != null ? nomMatch.group(1)! : '';
    String nouveauSolde = nouveauSoldeMatch != null ? nouveauSoldeMatch.group(1)! : '';
    String txnId = trxIdMatch != null ? trxIdMatch.group(1)! : '';

    return {
      'amount': amount,
      'trais': frais,
      'taf': taf,
      'nom': nom,
      'nouveauSolde': nouveauSolde,
      'txnId': txnId,
    };
  }
}
