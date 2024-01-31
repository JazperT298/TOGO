import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/app/modules/sendmoney/controller/send_money_controller.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/string_helper.dart';
import 'package:sizer/sizer.dart';

class SendMoneyOtpsBottomSheet {
  static void showBottomSheetSendMoneyNationalOtp() {
    final controller = Get.find<SendMoneyController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Wrap(
        children: [
          bottomSheetDivider(),
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return Container(
              height: isKeyboardVisible ? 77.h : 80.h,
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
                        LocaleKeys.strTransferSummary.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 13.sp),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        'National transfer',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 19.sp),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => controller.firstname.value.isEmpty && controller.lastname.value.isEmpty
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Name',
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${controller.firstname.value} ${controller.lastname.value}',
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.strTransferNumber.tr, //       'Numéro',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.numberController.text.toString(),
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    const LineSeparator(color: Colors.grey),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strTransferDetails.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.strTransferAmount.tr,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.amountController.value.text.isEmpty
                                  ? '0 FCFA'
                                  : '${StringHelper.formatNumberWithCommas(int.parse(controller.amountController.value.text.toString().replaceAll(',', '')))} FCFA',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Fees',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.totalFess.value == 0
                                    ? '0 FCFA'
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Tax',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.senderkeycosttva.isEmpty
                                    ? '0 FCFA'
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'TTC ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.totalAmount.value == 0
                                    ? '0 FCFA'
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() =>
                        controller.firstname.value.isEmpty && controller.lastname.value.isEmpty ? SizedBox(height: 6.h) : SizedBox(height: 3.h)),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: FluTextField(
                          inputController: controller.otpController,
                          hint: LocaleKeys.strCodeSecret.tr, // "Votre code secret",
                          height: 6.5.h,
                          cornerRadius: 15,
                          onTap: () {
                            controller.isInvalidCode.value = false;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 12.sp),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 12.sp),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                          ],
                          onChanged: (p0) {
                            controller.isInvalidCode.value = false;
                            controller.invalidCodeString.value = '';
                          },
                          onFieldSubmitted: (p0) async {
                            if (controller.otpController.value.text.isNotEmpty) {
                              if (controller.otpController.value.text.isEmpty) {
                                controller.isInvalidCode.value = true;
                                controller.invalidCodeString.value = LocaleKeys.strCodeSecretEmpty.tr;
                              } else {
                                AppGlobal.dateNow = DateTime.now().toString();
                                AppGlobal.timeNow = DateTime.now().toString();
                                controller.addNumberFromReceiver(controller.numberController.value.text, Get.find<DevicePlatformServices>().deviceID);
                              }
                            }
                          }),
                    ),
                    Obx(
                      () => controller.isInvalidCode.value == true
                          ? Center(
                              child: Container(
                                height: 5.h,
                                padding: EdgeInsets.only(top: 1.h),
                                child: Text(
                                  controller.invalidCodeString.value,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: context.colorScheme.secondary,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(height: 5.h),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          LocaleKeys.strvalidate.tr,
                          suffixIcon: FluIcons.checkCircleUnicon,
                          iconStrokeWidth: 1.8,
                          onPressed: () async {
                            if (controller.otpController.value.text.isNotEmpty) {
                              controller.addNumberFromReceiver(controller.amountController.value.text, Get.find<DevicePlatformServices>().deviceID);
                              // "Code invalide. S'il vous plaît essayer à nouveau";
                            } else if (controller.otpController.value.text.isEmpty) {
                              controller.isInvalidCode.value = true;
                              controller.invalidCodeString.value = LocaleKeys.strCodeSecretEmpty.tr;
                            }
                          },
                          height: 7.h,
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
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 13.sp),
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
      isScrollControlled: true,
    );
  }

  static void showBottomSheetSendMoneyInterationalOtp({required String countryName}) {
    final controller = Get.find<SendMoneyController>();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Wrap(
        children: [
          bottomSheetDivider(),
          KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
            return Container(
              height: isKeyboardVisible ? 77.h : 80.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strTransferSummary.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 13.sp),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        'International transfer',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 19.sp),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => controller.firstname.value.isEmpty
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Name',
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${controller.firstname.value} ${controller.lastname.value}',
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Country", //       'Country',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              countryName,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.strTransferNumber.tr, //       'Numéro',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${controller.selectedCountryCode.value} ${controller.numberController.text}",
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    const LineSeparator(color: Colors.grey),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        LocaleKeys.strTransferDetails.tr.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.strTransferAmount.tr,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.amountController.value.text.isEmpty
                                  ? '0 FCFA'
                                  : '${StringHelper.formatNumberWithCommas(int.parse(controller.amountController.value.text.toString().replaceAll(',', '')))} FCFA',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Fees',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.totalFess.value == 0
                                    ? '0 FCFA'
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalFess.value.toString().replaceAll(',', '')))} FCFA', //'${controller.fees.value} FCFA',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Tax',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.senderkeycosttva.isEmpty
                                    ? '0 FCFA'
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.senderkeycosttva.value.toString().replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'TTC ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 12.sp),
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.totalAmount.value == 0
                                    ? '0 FCFA'
                                    : '${StringHelper.formatNumberWithCommas(int.parse(controller.totalAmount.value.toString().replaceAll(',', '')))} FCFA',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: FluTextField(
                          inputController: controller.otpController,
                          hint: LocaleKeys.strCodeSecret.tr, // "Votre code secret",
                          height: 6.5.h,
                          cornerRadius: 15,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onTap: () {
                            controller.isInvalidCode.value = false;
                          },
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 12.sp),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 12.sp),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]')),
                          ],
                          onChanged: (p0) {
                            controller.isInvalidCode.value = false;
                            controller.invalidCodeString.value = '';
                          },
                          onFieldSubmitted: (p0) async {
                            if (controller.otpController.value.text.isNotEmpty) {
                              if (controller.otpController.value.text.isEmpty) {
                                controller.isInvalidCode.value = true;
                                controller.invalidCodeString.value = LocaleKeys.strCodeSecretEmpty.tr;
                              } else {
                                AppGlobal.dateNow = DateTime.now().toString();
                                AppGlobal.timeNow = DateTime.now().toString();
                                // controller.addNumberFromReceiver(
                                //     controller.numberController.value.text,
                                //     Get.find<DevicePlatformServices>()
                                //         .deviceID);
                                controller.sendMoneyInternationFinalHit(
                                    destinationMSISDN: controller.numberController.text,
                                    amount: controller.amountController.text,
                                    selectedCountryCode: controller.selectedCountryCode.value,
                                    code: controller.otpController.value.text);
                              }
                            }
                          }),
                    ),
                    Obx(
                      () => controller.isInvalidCode.value == true
                          ? Center(
                              child: Container(
                                height: 5.h,
                                padding: EdgeInsets.only(top: 1.h),
                                child: Text(
                                  controller.invalidCodeString.value,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: context.colorScheme.secondary,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(height: 5.h),
                    ),
                    // Obx(() => controller.isInvalidCode.value
                    //     ? SizedBox(
                    //         height: 3.h,
                    //       )
                    //     : const SizedBox()),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          LocaleKeys.strvalidate.tr,
                          suffixIcon: FluIcons.checkCircleUnicon,
                          iconStrokeWidth: 1.8,
                          onPressed: () async {
                            if (controller.otpController.value.text.isNotEmpty) {
                              // controller.addNumberFromReceiver(
                              //     controller.amountController.value.text,
                              //     Get.find<DevicePlatformServices>().deviceID);

                              controller.sendMoneyInternationFinalHit(
                                  destinationMSISDN: controller.numberController.text,
                                  amount: controller.amountController.text,
                                  selectedCountryCode: controller.selectedCountryCode.value,
                                  code: controller.otpController.value.text);
                              // "Code invalide. S'il vous plaît essayer à nouveau";
                            } else if (controller.otpController.value.text.isEmpty) {
                              controller.isInvalidCode.value = true;
                              controller.invalidCodeString.value = LocaleKeys.strCodeSecretEmpty.tr;
                            }
                          },
                          height: 7.h,
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
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 13.sp),
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
      isScrollControlled: true,
    );
  }
}
