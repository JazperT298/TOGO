import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/app/modules/recharge/views/modals/recharge_voice_otp_bottom_sheet.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class RechargeVoiceSelectedPackageBottomSheet {
  static void showBottomSheetSelectPackage() {
    var controller = Get.find<RechargeController>();
    Get.bottomSheet(
        Container(
          height: 80.h,
          width: 100.w,
          decoration:
              const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Text(
                    "Voice".toUpperCase(),
                    style: TextStyle(
                      color: Colors.orange[500],
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Obx(
                    () => controller.selectedOption.value == "For myself"
                        ? Text(
                            "Please select a package.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            "Please select a package.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: FluTextField(
                    inputController: controller.amountTextField,
                    hint: "Package name", // "Enter amount",
                    hintStyle: TextStyle(fontSize: 11.sp),
                    textStyle: TextStyle(fontSize: 11.sp),
                    height: 50,
                    cornerRadius: 15,
                    // keyboardType: TextInputType.number,
                    fillColor: const Color(0xFFf4f5fa),
                    onChanged: (text) {},
                  ),
                ),
                SizedBox(
                  height: 2.h,
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
                  height: 2.h,
                ),
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
                              height: 8.h,
                              width: 13.w,
                              decoration: BoxDecoration(
                                color: controller.voicePackageProductType.value == "All" ? const Color(0xFFe7edfc) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(child: Text("All")),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () {
                            controller.voicePackageProductType.value = "Mixes";

                            controller.changeVoiceProductType();
                          },
                          child: Obx(
                            () => Container(
                              height: 8.h,
                              width: 13.w,
                              decoration: BoxDecoration(
                                color: controller.voicePackageProductType.value == "Mixes" ? const Color(0xFFe7edfc) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(child: Text("Mixes")),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () {
                            controller.voicePackageProductType.value = "Voice";

                            controller.changeVoiceProductType();
                          },
                          child: Obx(
                            () => Container(
                              height: 8.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: controller.voicePackageProductType.value == "Voice" ? const Color(0xFFe7edfc) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(child: Text("Voice")),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () {
                            controller.voicePackageProductType.value = "Promo";
                            controller.changeVoiceProductType();
                          },
                          child: Obx(
                            () => Container(
                              height: 8.h,
                              width: 18.w,
                              decoration: BoxDecoration(
                                color: controller.voicePackageProductType.value == "Promo" ? const Color(0xFFe7edfc) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(child: Text("Promo")),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 5.w,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     // controller.voicePackageProductType.value = "HVC";
                        //     // controller.changeVoiceProductType();
                        //     Get.find<RechargeController>().voicePackageNumberCode.value = '340';
                        //     Get.find<RechargeController>().voicePackageGetHVCProducts();
                        //   },
                        //   child: Obx(
                        //     () => Container(
                        //       height: 8.h,
                        //       width: 18.w,
                        //       decoration: BoxDecoration(
                        //         color: controller.voicePackageProductType.value == "HVC" ? const Color(0xFFe7edfc) : Colors.white,
                        //         borderRadius: BorderRadius.circular(16),
                        //       ),
                        //       child: const Center(child: Text("HVC")),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
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
                            child: Container(
                              height: 8.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFe7edfc),
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
                                        Text(
                                          controller.textSplitterPackageName(text: controller.voiceProdList[index].description),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                            "${controller.voiceProdList[index].price} FCFA - ${controller.textSplitterPrice(text: controller.voiceProdList[index].description)}"),
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
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    right: 5.w,
                  ),
                  child: FluButton.text(
                    'Continuer',
                    suffixIcon: FluIcons.passwordCheck,
                    iconStrokeWidth: 1.8,
                    onPressed: () {
                      if (controller.selectedVoice != null) {
                        Get.back();
                        RechargeVoiceOTPBottomSheet.showBottomSheetOTP();
                      } else {
                        Get.snackbar("Message", "Please select a product", backgroundColor: Colors.lightBlue, colorText: Colors.white);
                      }
                    },
                    height: 55,
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
                    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
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
