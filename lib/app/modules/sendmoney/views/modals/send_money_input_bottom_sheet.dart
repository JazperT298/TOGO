// ignore_for_file: avoid_print, unused_local_variable

import 'dart:developer';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/sendmoney/controller/send_money_controller.dart';
import 'package:ibank/app/modules/sendmoney/views/modals/send_money_contacts_bottom_sheet.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class SendMoneyInputBottomSheet {
  static void showBottomSheetSendMoneyNationaInputNumber() {
    final controller = Get.put(SendMoneyController());
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Wrap(
        children: [
          bottomSheetDivider(),
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return Container(
              height: isKeyboardVisible ? 30.h : 35.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
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
                        LocaleKeys.strTransferHeader.tr,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strTransferHeaderDesc.tr,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                      ),
                    ),
                    // ),
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
                      child: Row(
                        // widget.sendType.contains('Transfert National')
                        children: [
                          Expanded(
                            child: FluTextField(
                                hint: LocaleKeys.strTransferRecipientNumber.tr, // "Numéro du destinataire",
                                inputController: controller.numberController,
                                hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                                textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                                height: 50,
                                cornerRadius: 15,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                                ],
                                fillColor: const Color(0xFFF4F5FA),
                                cursorColor: const Color(0xFF27303F),
                                onChanged: (text) {
                                  // Remove any existing spaces
                                  text = text.replaceAll(" ", "");
                                  // Add a space after every two characters
                                  if (text.length % 2 == 0) {
                                    text = text.replaceAllMapped(
                                      RegExp(r'.{2}'),
                                      (match) => '${match.group(0)} ',
                                    );
                                  }
                                  controller.numberController.value = controller.numberController.value.copyWith(
                                    text: text,
                                    selection: TextSelection.collapsed(offset: text.length),
                                  );

                                  controller.isTextFieldEmpty.value = false;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(width: 1.5, color: Colors.grey, height: 20),
                          ),
                          InkWell(
                            onTap: () async {
                              SendMoneyContactsBottomSheet.showBottomSheetSendMoneyNationaContacts();
                            },
                            child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 7.8,
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: const FluIcon(
                                  FluIcons.userSearch,
                                  size: 20,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => controller.isTextFieldEmpty.value == true
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                LocaleKeys.strPhoneNumberRequired.tr,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: context.colorScheme.secondary,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          LocaleKeys.strContinue.tr, //   'Saisir le montant',
                          suffixIcon: FluIcons.arrowRight,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            print(controller.numberController.value.text.trim().toString().length);
                            if (controller.numberController.value.text.isNotEmpty &&
                                controller.numberController.value.text.trim().toString().length == 11) {
                              if (controller.numberController.value.text.contains(" ")) {
                                print("wala ge input ang 228");
                                String replacedString = controller.numberController.value.text.replaceAll(" ", "").trim().toString();
                                String msisdn = (controller.selectedCountryCode.value + replacedString).replaceAll("+", "").toString();
                                print(msisdn);
                                print(controller.selectedCountryCode.value);

                                if (msisdn.substring(0, 3) == controller.selectedCountryCode.value.replaceAll("+", "")) {
                                  controller.onVerifySmidnSubmit(msisdn, context);
                                } else {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
                              } else {
                                print("ge input ang 228");
                                print(controller.numberController.value.text);
                                if (controller.numberController.value.text.substring(0, 3) ==
                                    controller.selectedCountryCode.value.replaceAll("+", "")) {
                                  String stringRemoveCountryCode = controller.numberController.value.text.substring(3);
                                  String formattedMSISDN = stringRemoveCountryCode.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
                                  controller.onVerifySmidnSubmit(controller.numberController.value.text, context);
                                } else {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
                              }

                              controller.isTextFieldEmpty.value = false;
                            } else if (controller.numberController.value.text.isEmpty) {
                              controller.isTextFieldEmpty.value = true;
                            } else if (controller.numberController.value.text.trim().toString().length != 11) {
                              Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            }
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
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  static void showBottomSheetSendMoneyNationaInputAmount() {
    final controller = Get.put(SendMoneyController());
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Wrap(
        children: [
          bottomSheetDivider(),
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return Container(
              height: isKeyboardVisible ? 28.h : 34.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
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
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.strTransferInfo.tr, // 'Vous allez envoyer de l’argent à ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                            ),
                            controller.numberController.value.text.length <= 11
                                ? TextSpan(
                                    text: '\n+${controller.numberController.value.text.toString()}',
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                                  )
                                : TextSpan(
                                    text: '\n+228 ${controller.numberController.value.text.toString()}',
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF124DE5), fontSize: 22),
                                  ),
                          ],
                        ),
                      ),
                    ),

                    // ),
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
                      child: Row(
                        // widget.sendType.contains('Transfert National')
                        children: [
                          Expanded(
                            child: FluTextField(
                              hint: LocaleKeys.strAmountSend.tr, // "Numéro du destinataire",
                              inputController: controller.amountController,
                              hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                              textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                              height: 50,
                              cornerRadius: 15,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                              ],
                              fillColor: const Color(0xFFF4F5FA),
                              cursorColor: const Color(0xFF27303F),
                              onFieldSubmitted: (p0) {
                                if (controller.amountController.text.isNotEmpty) {
                                  var asd = '228${controller.numberController.value.text.replaceAll(" ", "")}';
                                  if (controller.messageType.value == 'CASHOFF') {
                                    controller.getNationalTransactionFee(
                                        'WITHDRAW', controller.amountController.value.text, controller.messageType.value);
                                  } else {
                                    controller.getNationalTransactionFee(asd, controller.amountController.value.text, controller.messageType.value);
                                  }
                                  controller.isTextFieldEmpty.value = false;
                                } else {
                                  controller.isTextFieldEmpty.value = true;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => controller.isTextFieldEmpty.value == true
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                LocaleKeys.strPhoneNumberRequired.tr,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: context.colorScheme.secondary,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          LocaleKeys.strContinue.tr, //    'Continuer',
                          suffixIcon: FluIcons.arrowRight,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.amountController.value.text.isNotEmpty) {
                              var asd = '228${controller.numberController.value.text.replaceAll(" ", "")}';
                              if (controller.messageType.value == 'CASHOFF') {
                                controller.getNationalTransactionFee(
                                    'WITHDRAW', controller.amountController.value.text, controller.messageType.value);
                              } else {
                                controller.getNationalTransactionFee(asd, controller.amountController.value.text, controller.messageType.value);
                              }
                              controller.isTextFieldEmpty.value = false;
                            } else {
                              controller.isTextFieldEmpty.value = true;
                            }
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
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  static void showBottomSheetSendMoneyInterationaInputNumber() {
    final controller = Get.put(SendMoneyController());
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Wrap(
        children: [
          bottomSheetDivider(),
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return Container(
              height: isKeyboardVisible ? 30.h : 35.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
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
                        LocaleKeys.strTransferHeader.tr,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strTransferHeaderDesc.tr,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                      ),
                    ),
                    // ),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: FluTextField(
                                hint: LocaleKeys.strTransferRecipientNumber.tr, // "Numéro du destinataire",
                                inputController: controller.numberController,
                                hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                                textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                                height: 50,
                                cornerRadius: 15,
                                keyboardType: TextInputType.number,
                                prefix: GestureDetector(
                                  onTap: () async {
                                    final picked = await controller.countryPicker.showPicker(context: context);
                                    // Null check
                                    if (picked != null) {
                                      print(picked.dialCode);
                                      controller.selectedCountryCode.value = picked.dialCode;
                                    } else {
                                      controller.selectedCountryCode.value = '+228';
                                    }
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width / 5,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: controller.selectedCountryCode.value.length <= 3 ? 18.0 : 12.0, vertical: 4.0),
                                      decoration:
                                          const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(controller.selectedCountryCode.value.isEmpty ? '+228' : controller.selectedCountryCode.value,
                                              style: const TextStyle(color: Colors.black)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: Container(width: 1.5, color: Colors.grey, height: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                                ],
                                fillColor: const Color(0xFFF4F5FA),
                                cursorColor: const Color(0xFF27303F),
                                onChanged: (text) {
                                  // Remove any existing spaces
                                  text = text.replaceAll(" ", "");
                                  // Add a space after every two characters
                                  if (text.length % 2 == 0) {
                                    text = text.replaceAllMapped(
                                      RegExp(r'.{2}'),
                                      (match) => '${match.group(0)} ',
                                    );
                                  }
                                  controller.numberController.value = controller.numberController.value.copyWith(
                                    text: text,
                                    selection: TextSelection.collapsed(offset: text.length),
                                  );

                                  controller.isTextFieldEmpty.value = false;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(width: 1.5, color: Colors.grey, height: 20),
                          ),
                          GestureDetector(
                            onTap: () async {
                              SendMoneyContactsBottomSheet.showBottomSheetSendMoneyNationaContacts();
                            },
                            child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 7.8,
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: const FluIcon(
                                  FluIcons.userSearch,
                                  size: 20,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => controller.isTextFieldEmpty.value == true
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                LocaleKeys.strPhoneNumberRequired.tr,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: context.colorScheme.secondary,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          LocaleKeys.strContinue.tr, //   'Saisir le montant',
                          suffixIcon: FluIcons.arrowRight,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.numberController.value.text.isNotEmpty &&
                                controller.numberController.value.text.trim().toString().length == 11) {
                              if (controller.numberController.value.text.contains(" ")) {
                                log("wala ge input ang 228");
                                String replacedString = controller.numberController.value.text.replaceAll(" ", "").trim().toString();
                                String msisdn = (controller.selectedCountryCode.value + replacedString).replaceAll("+", "").toString();

                                if (msisdn.substring(0, 3) == controller.selectedCountryCode.value.replaceAll("+", "")) {
                                  log("MSISDN ---> 1 {$msisdn}");
                                  log(controller.selectedCountryCode.value);
                                  controller.onVerifySmidnSubmitInt(msisdn, controller.selectedCountryCode.value);
                                } else {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
                              } else {
                                log("ge input ang 228");
                                if (controller.numberController.value.text.substring(0, 3) ==
                                    controller.selectedCountryCode.value.replaceAll("+", "")) {
                                  String stringRemoveCountryCode = controller.numberController.value.text.substring(3);
                                  String formattedMSISDN = stringRemoveCountryCode.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
                                  log("MSISDN ---> 2 ${controller.numberController.value.text}");
                                  log(controller.selectedCountryCode.value);
                                  controller.onVerifySmidnSubmitInt(controller.numberController.value.text, controller.selectedCountryCode.value);
                                } else {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
                              }

                              controller.isTextFieldEmpty.value = false;
                            } else if (controller.numberController.value.text.isEmpty) {
                              controller.isTextFieldEmpty.value = true;
                            } else if (controller.numberController.value.text.trim().toString().length != 11) {
                              Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            }
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
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  static void showBottomSheetSendMoneyInterationaInputAmount() {
    final controller = Get.put(SendMoneyController());
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Wrap(
        children: [
          bottomSheetDivider(),
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return Container(
              height: isKeyboardVisible ? 30.h : 35.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.5.h),
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
                        LocaleKeys.strTransferHeader.tr,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strTransferHeaderDesc.tr,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                      ),
                    ),
                    // ),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: FluTextField(
                                hint: LocaleKeys.strTransferRecipientNumber.tr, // "Numéro du destinataire",
                                inputController: controller.numberController,
                                hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                                textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                                height: 50,
                                cornerRadius: 15,
                                keyboardType: TextInputType.number,
                                prefix: GestureDetector(
                                  onTap: () async {
                                    final picked = await controller.countryPicker.showPicker(context: context);
                                    // Null check
                                    if (picked != null) {
                                      print(picked.dialCode);
                                      controller.selectedCountryCode.value = picked.dialCode;
                                    } else {
                                      controller.selectedCountryCode.value = '+228';
                                    }
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width / 5,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: controller.selectedCountryCode.value.length <= 3 ? 18.0 : 12.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                          color: context.colorScheme.primaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(controller.selectedCountryCode.value.isEmpty ? '+228' : controller.selectedCountryCode.value,
                                              style: const TextStyle(color: Colors.black)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: Container(width: 1.5, color: Colors.grey, height: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                                ],
                                fillColor: const Color(0xFFF4F5FA),
                                cursorColor: const Color(0xFF27303F),
                                onChanged: (text) {
                                  // Remove any existing spaces
                                  text = text.replaceAll(" ", "");
                                  // Add a space after every two characters
                                  if (text.length % 2 == 0) {
                                    text = text.replaceAllMapped(
                                      RegExp(r'.{2}'),
                                      (match) => '${match.group(0)} ',
                                    );
                                  }
                                  controller.numberController.value = controller.numberController.value.copyWith(
                                    text: text,
                                    selection: TextSelection.collapsed(offset: text.length),
                                  );

                                  controller.isTextFieldEmpty.value = false;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(width: 1.5, color: Colors.grey, height: 20),
                          ),
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 7.8,
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: const FluIcon(
                                  FluIcons.userSearch,
                                  size: 20,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => controller.isTextFieldEmpty.value == true
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                LocaleKeys.strPhoneNumberRequired.tr,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: context.colorScheme.secondary,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          LocaleKeys.strContinue.tr, //   'Saisir le montant',
                          suffixIcon: FluIcons.arrowRight,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.numberController.value.text.isNotEmpty &&
                                controller.numberController.value.text.trim().toString().length == 11) {
                              if (controller.numberController.value.text.contains(" ")) {
                                log("wala ge input ang 228");
                                String replacedString = controller.numberController.value.text.replaceAll(" ", "").trim().toString();
                                String msisdn = (controller.selectedCountryCode.value + replacedString).replaceAll("+", "").toString();

                                if (msisdn.substring(0, 3) == controller.selectedCountryCode.value.replaceAll("+", "")) {
                                  log("MSISDN ---> 1 {$msisdn}");
                                  log(controller.selectedCountryCode.value);
                                  controller.onVerifySmidnSubmitInt(msisdn, controller.selectedCountryCode.value);
                                } else {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
                              } else {
                                log("ge input ang 228");
                                if (controller.numberController.value.text.substring(0, 3) ==
                                    controller.selectedCountryCode.value.replaceAll("+", "")) {
                                  String stringRemoveCountryCode = controller.numberController.value.text.substring(3);
                                  String formattedMSISDN = stringRemoveCountryCode.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ");
                                  log("MSISDN ---> 2 ${controller.numberController.value.text}");
                                  log(controller.selectedCountryCode.value);
                                  controller.onVerifySmidnSubmitInt(controller.numberController.value.text, controller.selectedCountryCode.value);
                                } else {
                                  Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
                              }

                              controller.isTextFieldEmpty.value = false;
                            } else if (controller.numberController.value.text.isEmpty) {
                              controller.isTextFieldEmpty.value = true;
                            } else if (controller.numberController.value.text.trim().toString().length != 11) {
                              Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            }
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
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
