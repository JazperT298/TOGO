import 'package:dotted_line/dotted_line.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class RechargeVoiceOTPBottomSheet {
  static showBottomSheetOTP() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Container(
          height: 70.h,
          width: 100.w,
          decoration:
              const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Text(
                    "SUMMARY".toUpperCase(),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Obx(() => controller.selectedOption.value == "For myself"
                      ? RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Purchase of ',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 24),
                              ),
                              TextSpan(
                                text: 'All Network Package ',
                                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF124DE5), fontSize: 24),
                              ),
                              // TextSpan(
                              //   text: 'account using ',
                              //   style: TextStyle(
                              //     fontSize: 14.sp,
                              //     fontWeight: FontWeight.w600,
                              //     color: Colors.black,
                              //   ),
                              // ),
                              // TextSpan(
                              //   text: 'Flooz.',
                              //   style: TextStyle(
                              //     fontSize: 14.sp,
                              //     fontWeight: FontWeight.w600,
                              //     color: const Color(0xFFfb6708),
                              //   ),
                              // )
                            ],
                          ),
                        )
                      : RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Purchase of ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 24),
                            ),
                            TextSpan(
                              text: 'All Network Package ',
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF124DE5), fontSize: 24),
                            ),
                            // TextSpan(
                            //   text: 'account using ',
                            //   style: TextStyle(
                            //     fontSize: 14.sp,
                            //     fontWeight: FontWeight.w600,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            // TextSpan(
                            //   text: 'Flooz.',
                            //   style: TextStyle(
                            //     fontSize: 14.sp,
                            //     fontWeight: FontWeight.w600,
                            //     color: const Color(0xFFfb6708),
                            //   ),
                            // )
                          ]),
                        )),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Text(
                    LocaleKeys.strTransferBeneficiary.tr.toUpperCase(),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: controller.selectedOption.value == "For myself"
                      ? Container(
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                          child: Center(
                            child: Text(
                              "Moi meme",
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                            ),
                          ),
                        )
                      : Container(
                          height: 7.h,
                          width: 100.w,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                          child: Center(
                            child: Text(
                              controller.numberTextField.text,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 4.h),
                Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: DottedLine(
                      dashLength: 5.w,
                      dashColor: Colors.grey,
                    )),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Text(
                    LocaleKeys.strTransferDetails.tr.toUpperCase(),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFF27303F), fontSize: 14),
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
                          "Package",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          controller.textSplitterPackageName(text: controller.selectedVoice!.description),
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                          "Validity",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          controller.textSplitterPrice(text: controller.selectedVoice!.description),
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                          "Fees",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '0 FCFA',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
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
                          LocaleKeys.strTransferAmount.tr,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${controller.selectedVoice!.price} FCFA',
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: FluTextField(
                    textAlign: TextAlign.center,
                    inputController: controller.code,
                    hint: "Enter PIN code", // "Montant à envoyer",
                    hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                    textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                    height: 50,
                    cornerRadius: 15,
                    keyboardType: TextInputType.number,
                    fillColor: const Color(0xFFf4f5fa),
                    onChanged: (text) {},
                    onFieldSubmitted: (p0) {
                      if (controller.code.text.isNotEmpty) {
                        if (controller.selectedOption.value == "For myself") {
                        } else {}
                      } else {
                        Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
                      'Validate',
                      suffixIcon: FluIcons.checkCircleUnicon,
                      iconStrokeWidth: 1.8,
                      onPressed: () {
                        if (controller.code.text.isNotEmpty) {
                          if (controller.selectedOption.value == "For myself") {
                            controller.verifyAndroidVoice(code: controller.code.text, msisdn: Get.find<StorageServices>().storage.read('msisdn'));
                          } else {
                            controller.verifyAndroidVoice(code: controller.code.text, msisdn: controller.numberTextField.text);
                          }
                        } else {
                          Get.snackbar("Message", "Entrées manquantes", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                        }
                      },
                      height: 55,
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
                      textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      isScrollControlled: true,
    );
  }
}
