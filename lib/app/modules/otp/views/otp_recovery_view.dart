// ignore_for_file: unnecessary_null_comparison

import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/modules/otp/controller/otp_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class OtpRecoveryView extends GetView<OtpController> {
  const OtpRecoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OtpController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(statusBarIconBrightness: Brightness.dark),
      body: SafeArea(
        child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
          return SizedBox(
            width: double.infinity,
            height: isKeyboardVisible ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'OTP code recovery'.toUpperCase(),
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF687997), fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Your informations'.toUpperCase(),
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 26),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          "Enter your account information to receive the OTP code",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
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
                        child: Text(
                          'Your first name',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluTextField(
                          hint: 'First name', // "Numéro du destinataire",
                          inputController: controller.firstname,
                          focusNode: controller.focusNodeFirstname,
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          height: 50,
                          cornerRadius: 15,
                          keyboardType: TextInputType.name,

                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          onFieldSubmitted: (text) {
                            controller.firstname.text = text;
                          },
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Your name',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluTextField(
                          hint: 'Your name',
                          inputController: controller.lastname,
                          focusNode: controller.focusNodeLastname,
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          height: 50,
                          cornerRadius: 15,
                          keyboardType: TextInputType.name,
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          onFieldSubmitted: (text) {
                            controller.lastname.text = text;
                          },
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Your date of birth',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: FluTextField(
                                hint: 'Date of birth', // "Numéro du destinataire",
                                inputController: controller.dateofbirth,
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
                                iconSize: 26,
                                onChanged: (text) {},
                                onFieldSubmitted: (text) {
                                  controller.dateofbirth.text = text;
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                showDateOfBirthDatePicker(context).then((value) {
                                  controller.dateofbirth.text = DateFormat("MM/dd/yyyy").format(controller.selectedDate).toString();
                                  controller.selectedDate = DateTime.now();
                                });
                              },
                              child: Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width / 7.8,
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                                  decoration: const BoxDecoration(color: Color(0xFFF4F5FA), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child: const FluIcon(
                                    FluIcons.calendar,
                                    size: 26,
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Text(
                          'Your Last Balance',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluTextField(
                          hint: 'Your last balance', // "Numéro du destinataire",
                          inputController: controller.lastbalance,
                          focusNode: controller.focusNodeLastbalance,
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          height: 50,
                          cornerRadius: 15,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ThousandsFormatter(),
                          ],
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          onChanged: (text) {},
                          onFieldSubmitted: (text) {
                            controller.lastbalance.text = text.trim();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Visibility(
                    visible: isKeyboardVisible ? false : true,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .09,
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: UISettings.pagePadding.copyWith(top: 8, left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FluButton.text(
                              LocaleKeys.strCancel.tr,
                              iconStrokeWidth: 1.8,
                              onPressed: () {
                                Get.back();
                              },
                              height: 5.8.h,
                              width: MediaQuery.of(context).size.width * .40,
                              cornerRadius: UISettings.minButtonCornerRadius,
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              border: const BorderSide(color: Color(0xFFFB6404)),
                              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp, color: const Color(0xFFFB6404)),
                            ),
                            FluButton.text(
                              LocaleKeys.strvalidate.tr,
                              iconStrokeWidth: 1.8,
                              onPressed: () {
                                if (controller.firstname.text.startsWith(" ") && controller.firstname.value.text.trim().isNotEmpty) {
                                  controller.firstname.text.toUpperCase().trim().replaceAll(" ", "_");
                                } else if (controller.lastname.text.startsWith(" ") && controller.lastname.value.text.trim().isNotEmpty) {
                                  controller.lastname.text.toUpperCase().trim().replaceAll(" ", "_");
                                } else if (controller.lastbalance.text.contains(",")) {
                                  controller.lastbalance.text.replaceAll(',', '');
                                } else if (controller.dateofbirth.text.length < 10 || controller.dateofbirth.text.length > 10) {
                                  Get.snackbar("Message", 'Invalid date', backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
                                }
                                if (controller.firstname.text.isNotEmpty &&
                                    controller.lastname.text.isNotEmpty &&
                                    controller.dateofbirth.text.isNotEmpty &&
                                    controller.lastbalance.text.isNotEmpty) {
                                  controller.recoverUsersInfo(
                                      firstname: controller.firstname.text.toUpperCase().trim().replaceAll(" ", "_"),
                                      lastname: controller.lastname.text.toUpperCase().trim().replaceAll(" ", "_"),
                                      birthdate: controller.dateofbirth.text.trim().replaceAll("/", ""),
                                      lastbalance: controller.lastbalance.text.replaceAll(',', ''));
                                } else {
                                  Get.snackbar("Message", 'All field must not be empty',
                                      backgroundColor: const Color(0xFFE60000), colorText: Colors.white);
                                }
                              },
                              height: 5.8.h,
                              width: MediaQuery.of(context).size.width * .40,
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
                              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> showDateOfBirthDatePicker1() async {
    final DateTime picked = await showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: controller.selectedDate,
          onDateTimeChanged: (DateTime newDate) {
            controller.selectedDate = newDate;
          },
        );
      },
    );

    if (picked != null && picked != controller.selectedDate) {
      controller.selectedDate = picked;
    }
  }

  Future<void> showDateOfBirthDatePicker(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: controller.selectedDate, firstDate: DateTime(1981), lastDate: DateTime(2050));
    if (picked != null && picked != controller.selectedDate) {
      controller.selectedDate = picked;
    }
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final formattedValue = _format(newText);

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(
        offset: formattedValue.length,
      ),
    );
  }

  String _format(String text) {
    if (text.isEmpty) return '';

    final number = int.parse(text);

    final formatter = NumberFormat('#,###');

    return formatter.format(number);
  }
}
