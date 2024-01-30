// ignore_for_file: unnecessary_new, prefer_const_constructors, sized_box_for_whitespace, avoid_print, unused_import, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
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

class SendMenuDialog {
  static void showMenuDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        if (!Platform.isIOS) {
          return AlertDialog(
            title: Text(LocaleKeys.strMoneyTransferTitle.tr),
            content: Container(
              height: 100.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text('Transfert National'),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      AppGlobal.siOTPPage = false;
                      AppGlobal.dateNow = '';
                      AppGlobal.timeNow = '';
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => _ModalBottomSheet(
                                sendType: LocaleKeys.strNationalTransfer.tr,
                                siOTPPage: AppGlobal.siOTPPage,
                                child: EnvoiModalBottomSheet(
                                  sendType: LocaleKeys.strNationalTransfer.tr,
                                ),
                              ));
                    },
                    child: Container(
                      height: 20,
                      child: Text(LocaleKeys.strNationalTransfer.tr),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      AppGlobal.siOTPPage = false;
                      AppGlobal.dateNow = '';
                      AppGlobal.timeNow = '';
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => _ModalBottomSheet(
                                sendType: LocaleKeys.strInternationalTransfer.tr,
                                siOTPPage: AppGlobal.siOTPPage,
                                child: EnvoiInternationalBottomSheet(
                                  sendType: LocaleKeys.strInternationalTransfer.tr,
                                ),
                              ));
                    },
                    child: Container(
                      height: 20,
                      child: Text(LocaleKeys.strInternationalTransfer.tr),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.snackbar("Message", LocaleKeys.strLoading.tr,
                          backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                    },
                    child: Container(
                      height: 20,
                      child: Text(LocaleKeys.strReversal.tr),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return CupertinoAlertDialog(
          title: Text(LocaleKeys.strMoneyTransferTitle.tr),
          content: Container(
            height: 120.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text('Transfert National'),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      AppGlobal.siOTPPage = false;
                      AppGlobal.dateNow = '';
                      AppGlobal.timeNow = '';
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => _ModalBottomSheet(
                                sendType: LocaleKeys.strNationalTransfer.tr,
                                siOTPPage: AppGlobal.siOTPPage,
                                child: EnvoiModalBottomSheet(
                                  sendType: LocaleKeys.strNationalTransfer.tr,
                                ),
                              ));
                    },
                    child: Container(
                      height: 20,
                      child: Text(LocaleKeys.strNationalTransfer.tr),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      AppGlobal.siOTPPage = false;
                      AppGlobal.dateNow = '';
                      AppGlobal.timeNow = '';
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => _ModalBottomSheet(
                                sendType: LocaleKeys.strInternationalTransfer.tr,
                                siOTPPage: AppGlobal.siOTPPage,
                                child: EnvoiInternationalBottomSheet(
                                  sendType: LocaleKeys.strInternationalTransfer.tr,
                                ),
                              ));
                    },
                    child: Container(
                      height: 20,
                      child: Text(LocaleKeys.strInternationalTransfer.tr),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.snackbar("Message", LocaleKeys.strComingSoon.tr,
                          backgroundColor: Colors.lightBlue, colorText: Colors.white, duration: const Duration(seconds: 3));
                    },
                    child: Container(
                      height: 20,
                      child: Text(LocaleKeys.strReversal.tr),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showMenuModal(context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          LocaleKeys.strMoneyTransferTitle.tr,
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'Option 1');
            },
            child: Text(LocaleKeys.strNationalTransfer.tr),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'Option 2');
            },
            child: Text(LocaleKeys.strInternationalTransfer.tr),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 'Option 3');
            },
            child: Text(LocaleKeys.strReversal.tr),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          isDefaultAction: true,
          child: Text(LocaleKeys.strCancel.tr),
        ),
      ),
    ).then((value) {
      // Handle the selected option
      if (value != null) {
        print('Selected: $value');
      }
    });
  }

  static void showRecapOperationDialog(context) async {
    // flutter defined function
    final controller = Get.put(SendMoneyController());

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
            height: 480,
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
                  'Bénéficiaire'.toUpperCase(),
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                ),
                const SizedBox(height: 18),
                Obx(
                  () => controller.firstname.value.isEmpty
                      ? SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Name',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'N/A',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Number',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.numberController.value.text,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                      ),
                    ),
                  ],
                ),
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
                        controller.amountController.text.isEmpty
                            ? '0 FCFA'
                            : '${StringHelper.formatNumberWithCommas(int.parse(controller.amountController.text.toString().replaceAll(',', '')))} FCFA',
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
                const SizedBox(height: 6),
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
                        'New Balance',
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

  static void showTransacCompleteDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
          insetPadding: EdgeInsets.all(12), // Outside Padding
          contentPadding: EdgeInsets.all(12), // Content Padding
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                Container(
                  height: 70,
                  width: double.infinity,
                  color: Colors.green.shade200,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Votre opération a été e\nffectué avec succès.'.toUpperCase(),
                        style: TextStyle(color: context.colorScheme.onSurface, fontSize: 11.sp),
                      ),
                      FluIcon(
                        FluIcons.checkCircleUnicon,
                        size: 48,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Récapitulatif'.toUpperCase(),
                  style: TextStyle(
                    color: context.colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  'Transfert International',
                  style: TextStyle(
                    fontSize: M3FontSizes.headlineMedium,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Bénéficiaire'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 18),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Expanded(
                //       child: Text(
                //         'Nom',
                //         style: TextStyle(fontSize: 11.sp color: Colors.grey),
                //       ),
                //     ),
                //     Expanded(
                //       child: Text(
                //         'Karim Razack',
                //         style: TextStyle(
                //           fontSize: 11.sp
                //           color: context.colorScheme.onSurface,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Prénom',
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Razack',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
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
                        'Numéro',
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '99 77 77 77',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const LineSeparator(color: Colors.grey),
                const SizedBox(height: 24),
                Text(
                  'DETAILS'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const Expanded(
                    //   child: Text(
                    //     'Frais',
                    //     style: TextStyle(fontSize: 11.sp color: Colors.grey),
                    //   ),
                    // ),
                    Expanded(
                      child: Text(
                        '0 FCFA',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
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
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '20 000 FCFA',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const LineSeparator(color: Colors.grey),
                const SizedBox(height: 24),
                Text(
                  'Infos operation'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Date',
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '01/02/2024',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
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
                        'Heure',
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '09:30:10',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Txn ID',
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '12469081234',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
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
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '70 000 FCFA',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Spacer(),
                FluButton.text(
                  'Fermer',
                  iconStrokeWidth: 1.8,
                  onPressed: () {
                    Get.toNamed(AppRoutes.BOTTOMNAV);
                  },
                  height: 55,
                  width: MediaQuery.of(context).size.width * 16,
                  cornerRadius: UISettings.minButtonCornerRadius,
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withOpacity(.35),
                      blurRadius: 25,
                      spreadRadius: 3,
                      offset: const Offset(0, 5),
                    )
                  ],
                  textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static List<String> separateDateTime(String dateTimeString) {
    List<String> parts = dateTimeString.split(' ');

    if (parts.length == 2) {
      String formattedDate = parts[0];
      String formattedTime = parts[1];

      return [formattedDate, formattedTime];
    } else {
      return [];
    }
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

class _ModalBottomSheet extends StatelessWidget {
  const _ModalBottomSheet({required this.child, required this.sendType, required this.siOTPPage});

  final Widget child;
  final String sendType;
  final bool siOTPPage;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: isKeyboardVisible
                ? AppGlobal.siOTPPage == true
                    ? MediaQuery.of(context).size.height * .4
                    : MediaQuery.of(context).size.height * .3
                : AppGlobal.siOTPPage == true
                    ? MediaQuery.of(context).size.height * .47
                    : MediaQuery.of(context).size.height * .35,
            decoration: BoxDecoration(
              color: context.colorScheme.background,
            ),
            child: child),
      );
    });
  }
}
