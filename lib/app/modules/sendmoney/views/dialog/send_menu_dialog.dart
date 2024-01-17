// ignore_for_file: unnecessary_new, prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_international_bottom_sheet.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/envoi_national_bottom_sheet.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:sizer/sizer.dart';

class SendMenuDialog {
  static void showMenuDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
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
      },
    );
  }

  static void showRecapOperationDialog(context) async {
    print('Amount: ${AppGlobal.amount}');
    print('Beneficiary: ${AppGlobal.beneficiare}');
    print('Date: ${AppGlobal.date}');
    print('New Balance: ${AppGlobal.remainingBal}');
    print('Transaction ID: ${AppGlobal.txn}');
    print('Number ID: ${AppGlobal.numbers}');

    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object

        return AlertDialog(
          insetPadding: EdgeInsets.all(12), // Outside Padding
          contentPadding: EdgeInsets.all(12), // Content Padding
          title: Text("Recap operation"),
          content: Container(
            width: MediaQuery.of(context).size.width - 60,
            height: 460,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                Text(
                  'Bénéficiaire'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.sp,
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
                // const SizedBox(height: 6),
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
                        AppGlobal.beneficiare.toString(),
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
                        AppGlobal.numbers,
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
                // const SizedBox(height: 18),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Expanded(
                //       child: Text(
                //         'Frais',
                //         style: TextStyle(fontSize: 11.sp color: Colors.grey),
                //       ),
                //     ),
                //     Expanded(
                //       child: Text(
                //         '0 FCFA',
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
                        'Montant',
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppGlobal.amount,
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
                        AppGlobal.date,
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
                        AppGlobal.time,
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
                        AppGlobal.txn,
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
                        AppGlobal.remainingBal,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
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
                    ? MediaQuery.of(context).size.height * .5
                    : MediaQuery.of(context).size.height * .3
                : AppGlobal.siOTPPage == true
                    ? MediaQuery.of(context).size.height * .63
                    : MediaQuery.of(context).size.height * .4,
            decoration: BoxDecoration(
              color: context.colorScheme.background,
            ),
            child: child),
      );
    });
  }
}
