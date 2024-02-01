import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/divider_widget.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/profile/controller/profile_controller.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

class ProfileBottomSheet {
  static var controller = Get.find<ProfileController>();
  static void showBottomSheetInputNumber() {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: isKeyboardVisible ? 27.h : 33.h,
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
                        "Calculate keycost".toUpperCase(),
                        style: TextStyle(
                          color: const Color(0xFFfb6708),
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Enter the amount to calculate the fee.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
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
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: FluTextField(
                        inputController: controller.amountTextField,
                        hint: "Enter amount to calculate",
                        hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                        textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                        height: 50,
                        cornerRadius: 15,
                        keyboardType: TextInputType.number,
                        fillColor: const Color(0xFFf4f5fa),
                        onChanged: (text) {},
                        onFieldSubmitted: (p0) {
                          if (controller.amountTextField.text.isEmpty) {
                            Get.snackbar("Message", 'Please input an amount', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                          } else {
                            Get.back();
                            controller.amountToCalculate(amount: controller.amountTextField.text);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                      ),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          LocaleKeys.strvalidate.tr, //   'Continuer',
                          suffixIcon: FluIcons.checkCircleUnicon,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.amountTextField.text.isEmpty) {
                              Get.snackbar("Message", 'Please input an amount', backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            } else {
                              Get.back();
                              controller.amountToCalculate(amount: controller.amountTextField.text);
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
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  static void showBottomSheetBiometrics() {
    controller.getSecureTextFromStorage();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Wrap(
        children: [
          bottomSheetDivider(),
          Container(
            height: 25.h,
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
                      "Biometrics Settings".toUpperCase(),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "You may add extra security with facial recognition option to login to your account. This step is optional",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
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
                    height: 1.h,
                  ),
                  Padding(
                    padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                      title: Text(
                        'Secure Account',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 14),
                      ),
                      subtitle: Text(
                        'Enable facial recognition authentication',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                      ),
                      trailing: Obx(
                        () => Switch(
                          activeColor: Colors.red,
                          value: controller.secured.value,
                          onChanged: (value) {
                            controller.secured.value = value;
                            // setFaceToStorage(secured.toString());
                            Get.find<StorageServices>().saveBiometricsToStorage(biometrics: controller.secured.value);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showBottomSheetInputPIN() {
    controller.code.clear();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: isKeyboardVisible ? 27.h : 34.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.5.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "PIN Code".toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Norem ipsum dolor sit amet \nconsectetur",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
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
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(Get.context!).size.height * .025),
                      child: FluTextField(
                          inputController: controller.code,
                          hint: LocaleKeys.strCodeSecret.tr, // "Votre code secret",
                          height: 50,
                          cornerRadius: 15,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          fillColor: const Color(0xFFF4F5FA),
                          cursorColor: const Color(0xFF27303F),
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          onChanged: (text) {
                            String newText = text.replaceAll(' ', '');
                            String spacedText = newText.split('').join(' ');
                            controller.code.value = controller.code.value.copyWith(
                              text: spacedText,
                              selection: TextSelection.collapsed(offset: spacedText.length),
                            );
                          },
                          onFieldSubmitted: (p0) async {
                            if (controller.code.text.isNotEmpty) {
                              String finalPINCode = controller.code.text.replaceAll(' ', '');
                              controller.enterPinForInformationPersonelles(code: finalPINCode);
                            } else {
                              Get.snackbar("Message", LocaleKeys.strPasswordWarnings.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            }
                            controller.code.clear();
                          }),
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
                              String finalPINCode = controller.code.text.replaceAll(' ', '');
                              controller.enterPinForInformationPersonelles(code: finalPINCode);
                            } else {
                              Get.snackbar("Message", LocaleKeys.strPasswordWarnings.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            }
                            controller.code.clear();
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  static void showBottomSheetEditEmail() {
    var controller = Get.put(ProfileController());
    controller.code.clear();
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Wrap(
          children: [
            bottomSheetDivider(),
            Container(
              height: isKeyboardVisible ? 27.h : 33.h,
              width: 100.w,
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
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
                        "Edit your email".toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: const Color(0xFFFB6404), fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text(
                        "Norem ipsum dolor sit amet consectetur",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 22),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(Get.context!).size.height * .025),
                      child: FluTextField(
                          // inputController: controller.code,
                          hint: 'Your Email here....',
                          hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFF27303F), fontSize: 14),
                          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          height: 50,
                          cornerRadius: 15,
                          keyboardType: TextInputType.name,
                          fillColor: const Color(0xFFf4f5fa),
                          onFieldSubmitted: (p0) async {
                            // if (controller.code.text.isNotEmpty) {
                            //   controller.enterPinForInformationPersonelles(code: controller.code.text);
                            // } else {
                            //   Get.snackbar("Message", LocaleKeys.strPasswordWarnings.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            // }
                            // controller.code.clear();
                          }),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Visibility(
                        visible: isKeyboardVisible ? false : true,
                        child: FluButton.text(
                          'Confirm',
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            // if (controller.code.text.isNotEmpty) {
                            //   controller.enterPinForInformationPersonelles(code: controller.code.text);
                            // } else {
                            //   Get.snackbar("Message", LocaleKeys.strPasswordWarnings.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            // }
                            // controller.code.clear();
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
                          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
