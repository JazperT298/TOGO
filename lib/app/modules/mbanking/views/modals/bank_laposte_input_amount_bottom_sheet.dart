import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../../utils/configs.dart';
import '../../../../../utils/fontsize_config.dart';
import '../../controller/mbanking_controller.dart';

class MBankingLaPosteInputAmountBottomSheet {
  static void showBottomSheetLaPosteInputAmount(
      {required String selectedMenu}) {
    var controller = Get.find<MBankingController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return Wrap(
                children: [
                  bottomSheetDivider(),
                  Container(
                    // height: isKeyboardVisible ? 30.h : 38.h,
                    width: 100.w,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.5.h),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Text(
                              controller.selectedSubMenu.value.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFFB6404),
                                  fontSize: FontSizes.headerMediumText),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Text.rich(
                              controller.selectedSubMenu.value ==
                                      "Flooz to La Poste"
                                  ? TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Flooz ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF124DE5),
                                              fontSize:
                                                  FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text:
                                              'transfer to ', // 'Vous allez envoyer de l’argent à ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize:
                                                  FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text: 'La Poste ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFFB6404),
                                              fontSize:
                                                  FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text: 'account ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize:
                                                  FontSizes.headerLargeText),
                                        ),
                                      ],
                                    )
                                  : TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'La Poste ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF124DE5),
                                              fontSize:
                                                  FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text:
                                              'transfer to ', // 'Vous allez envoyer de l’argent à ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize:
                                                  FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text: 'Flooz ',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFFB6404),
                                              fontSize:
                                                  FontSizes.headerLargeText),
                                        ),
                                        TextSpan(
                                          text: 'account',
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize:
                                                  FontSizes.headerLargeText),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
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
                            child: FluTextField(
                              inputController: controller.amountTextField,
                              hint: LocaleKeys
                                  .strEnterAmounts.tr, // "Enter amount",
                              hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF27303F),
                                  fontSize: FontSizes.headerSmallText),
                              textStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: FontSizes.headerSmallText),
                              height: 6.5.h,
                              cornerRadius: 15,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9\s]')),
                              ],
                              fillColor: const Color(0xFFf4f5fa),
                              onChanged: (text) {},
                              onFieldSubmitted: (p0) {
                                if (controller.amountTextField.text.isEmpty) {
                                  Get.snackbar(
                                      "Message", LocaleKeys.strInvalidNumber.tr,
                                      backgroundColor: Colors.lightBlue,
                                      colorText: Colors.white);
                                } else if (controller
                                        .amountTextField.text.length >
                                    8) {
                                  Get.snackbar(
                                      "Message", LocaleKeys.strInvalidNumber.tr,
                                      backgroundColor: Colors.lightBlue,
                                      colorText: Colors.white);
                                } else if (double.parse(
                                        controller.amountTextField.text) <=
                                    0) {
                                  Get.snackbar(
                                      "Message", LocaleKeys.strInvalidNumber.tr,
                                      backgroundColor: Colors.lightBlue,
                                      colorText: Colors.white);
                                } else {
                                  controller.getBankingLaPosteTransactionFee(
                                      controller.destmsisdn.value,
                                      controller.amountTextField.text,
                                      controller.keyword.value);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: Visibility(
                              visible: isKeyboardVisible ? false : true,
                              child: FluButton.text(
                                LocaleKeys.strContinue.tr.toString(),
                                suffixIcon: FluIcons.arrowRight,
                                iconStrokeWidth: 1.8,
                                onPressed: () {
                                  if (controller.amountTextField.text.isEmpty) {
                                    Get.snackbar("Message",
                                        LocaleKeys.strInvalidNumber.tr,
                                        backgroundColor: Colors.lightBlue,
                                        colorText: Colors.white);
                                  } else if (controller
                                          .amountTextField.text.length >
                                      8) {
                                    Get.snackbar("Message",
                                        LocaleKeys.strInvalidNumber.tr,
                                        backgroundColor: Colors.lightBlue,
                                        colorText: Colors.white);
                                  } else if (double.parse(
                                          controller.amountTextField.text) <=
                                      0) {
                                    Get.snackbar("Message",
                                        LocaleKeys.strInvalidNumber.tr,
                                        backgroundColor: Colors.lightBlue,
                                        colorText: Colors.white);
                                  } else {
                                    controller.getBankingLaPosteTransactionFee(
                                        controller.destmsisdn.value,
                                        controller.amountTextField.text,
                                        controller.keyword.value);
                                  }
                                },
                                height: 7.h,
                                width: 100.w,
                                cornerRadius: UISettings.minButtonCornerRadius,
                                backgroundColor: const Color(0xFF124DE5),
                                foregroundColor: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 25,
                                    spreadRadius: 3,
                                    offset: Offset(0, 5),
                                  )
                                ],
                                textStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFF4F5FA),
                                    fontSize: FontSizes.buttonText),
                              ),
                            ),
                          ).paddingOnly(bottom: 3.h),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        isScrollControlled: true);
  }
}
