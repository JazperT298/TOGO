// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
// import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';
// import 'package:ibank/app/modules/withdrawal/modals/withdraw_otp_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/fontsize_config.dart';

class WithdrawInputBottomSheet {
  static void showBottomSheetWithdrawalNormalInputNumber() {
    final controller = Get.find<WithdrawalController>();
    Get.bottomSheet(
      Wrap(
        children: [
          bottomSheetDivider(),
          Container(
            // height: 30.h,
            width: 100.w,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 2.5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "Withdraw normal".toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFB6404),
                          fontSize: FontSizes.headerMediumText),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "Yorem ipsum dolor sit amet, adipiscing elit.",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: FontSizes.headerLargeText),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
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
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF27303F),
                          fontSize: FontSizes.headerMediumText),
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showBottomSheetWithdrawalCollectioInputNumber() {
    final controller = Get.find<WithdrawalController>();
    Get.bottomSheet(
      Container(
        // height: 30.h,
        width: 100.w,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
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
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFB6404),
                      fontSize: FontSizes.headerMediumText),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Yorem ipsum dolor sit amet, adipiscing elit.",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: FontSizes.headerLargeText),
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
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF27303F),
                      fontSize: FontSizes.headerSmallText),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showBottomSheeCountertWithdrawalInputNumber() {
    final controller = Get.find<WithdrawalController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                // height: isKeyboardVisible ? 33.h : 42.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 2.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Counter withdrawal".toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFB6404),
                              fontSize: FontSizes.headerMediumText),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                MediaQuery.of(Get.context!).size.height * .025),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'You will withdraw money from the ATM ', // 'Vous allez envoyer de l’argent à ',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: FontSizes.headerLargeText),
                              ),
                              TextSpan(
                                text: '\nEcobank',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF124DE5),
                                    fontSize: FontSizes.headerLargeText),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(Get.context!).size.height * .025),
                        child: FluTextField(
                          inputController: controller.counterWithdrawalAmount,
                          hint: 'Amount to withdraw', // "Montant à envoyer",
                          hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF27303F),
                              fontSize: FontSizes.textFieldText),
                          textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: FontSizes.textFieldText),
                          height: 6.5.h,
                          cornerRadius: 15,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],

                          onFieldSubmitted: (p0) async {
                            if (controller
                                .counterWithdrawalAmount.value.text.isEmpty) {
                              Get.snackbar("Message", 'Please input an amount',
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            } else {
                              controller.amount.value =
                                  controller.counterWithdrawalAmount.text;
                              // WithdrawOtpBottomSheet.showBottomSheetCounterWithdrawnOTP();
                              controller.getCounterTransactionFee(
                                  amounts: controller.amount.value,
                                  selectedMessageType: controller
                                      .counterWithdrawalSelectedMessage.value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Visibility(
                          visible: isKeyboardVisible ? false : true,
                          child: FluButton.text(
                            'Continue',
                            suffixIcon: FluIcons.arrowRight,
                            iconStrokeWidth: 1.8,
                            onPressed: () async {
                              if (controller
                                  .counterWithdrawalAmount.value.text.isEmpty) {
                                Get.snackbar(
                                    "Message", 'Please input an amount',
                                    backgroundColor: Colors.lightBlue,
                                    colorText: Colors.white);
                              } else {
                                String input = controller
                                    .counterWithdrawalAmount.value.text
                                    .replaceAll(RegExp('^0+'), '');
                                controller.counterWithdrawalAmount.text = input;
                                // input = input.replaceAll(RegExp('^0+'), '');
                                if (input.length < 4 || input.length > 6) {
                                  log('less than 4');
                                  Get.snackbar("Message",
                                      'Input amount is not accepted.',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                } else if (input[1] == '0' &&
                                        StringHelper.validateThousandInput(
                                            input, 3) ||
                                    StringHelper.validateThousandInput(
                                        input, 4) ||
                                    StringHelper.validateThousandInput(
                                        input, 5)) {
                                  // controller.counterWithdrawalAmount.value.text.replaceAll(RegExp('^0+'), '');
                                  log('Passed');
                                  log('Passed ${input[1]}');
                                  controller.amount.value =
                                      controller.counterWithdrawalAmount.text;
                                  // WithdrawOtpBottomSheet.showBottomSheetCounterWithdrawnOTP();
                                  controller.getCounterTransactionFee(
                                      amounts: controller.amount.value,
                                      selectedMessageType: controller
                                          .counterWithdrawalSelectedMessage
                                          .value);
                                } else {
                                  log('Failed');
                                  Get.snackbar(
                                      "Message", 'Please input only thousands.',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                }
                              }

                              // if (controller.code.text.isNotEmpty) {
                              //   AppGlobal.dateNow = DateTime.now().toString();
                              //   AppGlobal.timeNow = DateTime.now().toString();
                              //   controller.enterPinToTransactWithdrawal(code: controller.code.text);
                              // } else {
                              //   Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                              // }
                            },
                            height: 7.h,
                            width: 100.w,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: Colors.blue[900],
                            foregroundColor: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 25,
                                spreadRadius: 3,
                                offset: Offset(0, 5),
                              )
                            ],
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: FontSizes.buttonText),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
