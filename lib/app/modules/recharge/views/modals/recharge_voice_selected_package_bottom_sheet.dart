import 'dart:ui';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class RechargeVoiceSelectedPackageBottomSheet {
  static void showBottomSheetSelectPackage() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(
        backgroundColor: Colors.transparent,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Wrap(
            children: [
              bottomSheetDivider(),
              Container(
                height: 80.h,
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
                          "All network package".toUpperCase(),
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 13.sp),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Obx(
                          () => controller.selectedOption.value == "For myself"
                              ? Text(
                                  "Please select a package.",
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 19.sp),
                                )
                              : Text(
                                  "Please select a package.",
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 19.sp),
                                ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: FluTextField(
                          inputController: controller.amountTextField,
                          hint: "Package name", // "Enter amount",
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 13.sp),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 13.sp),
                          height: 6.5.h,
                          cornerRadius: 15,
                          // keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFf4f5fa),
                          suffixIcon: FluIcons.refresh,
                          onChanged: (text) {},
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.voicePackageProductType.value = "All";
                                  controller.changeVoiceProductType();
                                },
                                child: Obx(
                                  () => Container(
                                    padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, left: 3.w, right: 3.w),
                                    decoration: BoxDecoration(
                                      color: controller.voicePackageProductType.value == "All" ? const Color(0xFFB6C8F7) : Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "All",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: controller.voicePackageProductType.value == "All" ? FontWeight.w500 : FontWeight.w400,
                                          color: const Color(0xFF27303F),
                                          fontSize: 12.sp),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              InkWell(
                                onTap: () {
                                  controller.voicePackageProductType.value = "Mixes";

                                  controller.changeVoiceProductType();
                                },
                                child: Obx(
                                  () => Container(
                                    padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, left: 3.w, right: 3.w),
                                    decoration: BoxDecoration(
                                      color: controller.voicePackageProductType.value == "Mixes" ? const Color(0xFFB6C8F7) : Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Mixes",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: controller.voicePackageProductType.value == "Mixes" ? FontWeight.w500 : FontWeight.w400,
                                          color: const Color(0xFF27303F),
                                          fontSize: 12.sp),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              InkWell(
                                onTap: () {
                                  controller.voicePackageProductType.value = "Voice";
                                  controller.changeVoiceProductType();
                                },
                                child: Obx(
                                  () => Container(
                                    padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, left: 3.w, right: 3.w),
                                    decoration: BoxDecoration(
                                      color: controller.voicePackageProductType.value == "Voice" ? const Color(0xFFB6C8F7) : Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Voice",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: controller.voicePackageProductType.value == "Voice" ? FontWeight.w500 : FontWeight.w400,
                                          color: const Color(0xFF27303F),
                                          fontSize: 12.sp),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              InkWell(
                                onTap: () {
                                  controller.voicePackageProductType.value = "Promo";
                                  controller.changeVoiceProductType();
                                },
                                child: Obx(
                                  () => Container(
                                    padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, left: 3.w, right: 3.w),
                                    decoration: BoxDecoration(
                                      color: controller.voicePackageProductType.value == "Promo" ? const Color(0xFFB6C8F7) : Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Promo",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: controller.voicePackageProductType.value == "Promo" ? FontWeight.w500 : FontWeight.w400,
                                          color: const Color(0xFF27303F),
                                          fontSize: 12.sp),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      SizedBox(
                        height: 35.h,
                        width: 100.w,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: controller.voiceProdList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.voicePackageRadioGroupValue.value = controller.voiceProdList[index].productid;
                                    controller.selectedVoice = controller.voiceProdList[index];
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 8.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        color: controller.voicePackageRadioGroupValue.value == controller.voiceProdList[index].productid
                                            ? const Color(0xFFFEE8D9)
                                            : const Color(0xFFe7edfc),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.w, right: 1.w),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 70.w,
                                                  child: Text(
                                                    controller.textSplitterPackageName(text: controller.voiceProdList[index].description),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w600, color: const Color(0xFF27303F), fontSize: 26),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 70.w,
                                                  child: Text(
                                                    "${controller.voiceProdList[index].price} FCFA - ${controller.textSplitterPrice(text: controller.voiceProdList[index].description)}",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w400, color: const Color(0xFF687997), fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Obx(
                                              () => Radio(
                                                  value: controller.voiceProdList[index].productid,
                                                  groupValue: controller.voicePackageRadioGroupValue.value,
                                                  onChanged: (value) {
                                                    controller.voicePackageRadioGroupValue.value = controller.voiceProdList[index].productid;
                                                    controller.selectedVoice = controller.voiceProdList[index];
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                          right: 5.w,
                        ),
                        child: FluButton.text(
                          'Continue',
                          suffixIcon: FluIcons.arrowRight,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.selectedVoice != null) {
                              controller.getInternetAndVoiceTransactionFee(from: "voice", amounts: controller.selectedVoice!.price);
                            } else {
                              Get.snackbar("Message", "Please select a product", backgroundColor: Colors.lightBlue, colorText: Colors.white);
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
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFF4F5FA), fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        isScrollControlled: true);
  }

//   static void showBottomSheetInputNumber() {
//     var controller = Get.find<RechargeController>();
//     Get.bottomSheet(
//       Container(
//         height: 40.h,
//         width: 100.w,
//         decoration:
//             const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 2.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                 child: Text(
//                   "Voice".toUpperCase(),
//                   style: TextStyle(
//                     color: const Color(0xFFfb6708),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 11.sp,
//                     letterSpacing: 1.0,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 1.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                 child: Text(
//                   "Please enter the mobile number of the recipient.",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 4.h,
//               ),
//               Row(
//                 children: [
//                   FluLine(
//                     width: 30.w,
//                     color: const Color(0xFFfb6708),
//                   ),
//                   CircleAvatar(
//                     radius: 1.w,
//                     backgroundColor: const Color(0xFFfb6708),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 4.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                 child: FluTextField(
//                   inputController: controller.numberTextField,
//                   hint: LocaleKeys.strEnterNumber.tr, // "Enter number",
//                   hintStyle: TextStyle(fontSize: 11.sp),
//                   textStyle: TextStyle(fontSize: 11.sp),
//                   height: 50,
//                   cornerRadius: 15,
//                   keyboardType: TextInputType.number,
//                   fillColor: const Color(0xFFf4f5fa),
//                   onChanged: (text) {},
//                   onFieldSubmitted: (p0) {
//                     if (controller.numberTextField.text.isEmpty) {
//                       Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
//                     } else {
//                       if (controller.numberTextField.text.length == 8 || controller.numberTextField.text.length == 11) {
//                         if (controller.numberTextField.text.length == 8) {
//                           controller.numberTextField.text = "228${controller.numberTextField.text}";
//                           Get.back();
//                           RechargeVoiceSelectedPackageBottomSheet.showBottomSheetSelectPackage();
//                         } else {
//                           if (controller.numberTextField.text.substring(0, 3) == "228") {
//                             Get.back();
//                             RechargeVoiceSelectedPackageBottomSheet.showBottomSheetSelectPackage();
//                           } else {
//                             Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
//                           }
//                         }
//                       } else {
//                         Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
//                       }
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 3.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: 5.w,
//                   right: 5.w,
//                 ),
//                 child: FluButton.text(
//                   LocaleKeys.strContinue.tr, //   'Continuer',
//                   suffixIcon: FluIcons.passwordCheck,
//                   iconStrokeWidth: 1.8,
//                   onPressed: () {
//                     if (controller.numberTextField.text.isEmpty) {
//                       Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
//                     } else {
//                       if (controller.numberTextField.text.length == 8 || controller.numberTextField.text.length == 11) {
//                         if (controller.numberTextField.text.length == 8) {
//                           controller.numberTextField.text = "228${controller.numberTextField.text}";
//                           Get.back();
//                           RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
//                         } else {
//                           if (controller.numberTextField.text.substring(0, 3) == "228") {
//                             Get.back();
//                             RechargeInternetSelectPackageBottomSheet.showBottomSheetSelectPackage();
//                           } else {
//                             Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
//                           }
//                         }
//                       } else {
//                         Get.snackbar("Message", LocaleKeys.strInvalidNumber.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
//                       }
//                     }
//                   },
//                   height: 55,
//                   width: 100.w,
//                   cornerRadius: UISettings.minButtonCornerRadius,
//                   backgroundColor: Colors.blue[900],
//                   foregroundColor: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 25,
//                       spreadRadius: 3,
//                       offset: Offset(0, 5),
//                     )
//                   ],
//                   textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
//                 ),
//               ),
//               SizedBox(
//                 height: 1.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}
