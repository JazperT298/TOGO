// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/modules/otp/controller/otp_controller.dart';
import 'package:flukit/flukit.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final controller = Get.put(OtpController());
  TextEditingController textEditingController = TextEditingController();
  bool isEmptyFields = false;
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  // void onVerifierTap(BuildContext context) {
  //   KRouter.replace(context, Routes.loginSuccess);
  // }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              if (controller.isLoadingOTP.value == true)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: loadingContainer(),
                ),
              Padding(
                padding: UISettings.pagePadding.copyWith(top: 10, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 175, 221, 243)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ))),
                          onPressed: () {
                            Get.back();
                          },
                          child: const FluIcon(
                            FluIcons.arrowLeft,
                            size: 30,
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Image.asset(AppImages.otpImage1, width: 100.w),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      LocaleKeys.strConfirmNumber.tr,
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                      child: Text(
                        LocaleKeys.strEnterCodeDesc.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${controller.countryCode.value} ${controller.formatedMSISDN.value}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: Color(0xFFFB6404), fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20,
                        ),
                        child: PinCodeTextField(
                          obscuringCharacter: '*',
                          obscureText: true,
                          onSubmitted: (value) {
                            if (textEditingController.text.isEmpty) {
                              setState(() {
                                isEmptyFields = true;
                              });
                            } else {
                              // ProgressAlertDialog.progressAlertDialog(context, LocaleKeys.strLoading.tr);
                              controller.verifyOTP(otp: textEditingController.text);
                              // SharedPrefService.saveLoginData(true, 'Malik Monk');
                              // ProgressAlertDialog.showALoadingDialog(context, "Chargement..", 5, AppRoutes.PRIVACY);
                              // textEditingController.clear();
                              // ProgressAlertDialog.progressAlertDialog(
                              //     context, "Chargement..");
                              // controller.verifyOTP(otp: otp)
                            }
                          },
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          // maxLength: 8,
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          // validator: (v) {
                          //   if (v!.length < 5) {
                          //     return "I'm from validator";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 55,
                              fieldWidth: 45,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              inactiveBorderWidth: 0.8,
                              inactiveColor: Colors.grey,
                              borderWidth: 1),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          // boxShadows: const [
                          //   BoxShadow(
                          //     offset: Offset(0, 1),
                          //     color: Colors.black12,
                          //     blurRadius: 10,
                          //   )
                          // ],
                          onCompleted: (v) {
                            debugPrint("Completed");
                            debugPrint(textEditingController.text);
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                    ),
                    isEmptyFields == true
                        ? Text(
                            LocaleKeys.strPinCodeRequired.tr,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: context.colorScheme.secondary,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 8),
                    Obx(
                      () => controller.timerValue.value > 0 // controller.isResendShow.value == false
                          ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              child: Center(
                                child: Text(
                                  'RESEND (in ${controller.timerValue.value} seconds)',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                controller.tries.value++;

                                if (controller.tries.value < 4) {
                                  if (controller.requestVia.value == "sms") {
                                    controller.resendencryptionExample(
                                        msisdn: controller.msisdn.value,
                                        formattedMSISDN: controller.formatedMSISDN.value,
                                        countryCode: controller.countryCode.value);
                                  } else {
                                    controller.otpRequestViaApi(
                                        msisdn: controller.msisdn.value,
                                        formattedMSISDN: controller.formatedMSISDN.value,
                                        countryCode: controller.countryCode.value);
                                  }
                                  // controller.isResendShow.value = false;
                                  controller.timerValue.value = 300;
                                  controller.startTimer2();
                                } else {
                                  // controller.isResendShow.value = false;
                                  Get.snackbar("Message", LocaleKeys.strPinCodeWarning.tr,
                                      backgroundColor: Colors.lightBlue, colorText: Colors.white);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                child: Center(
                                  child: Text(
                                    LocaleKeys.strResentCode.tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF124DE5), fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 8),
                    FluButton.text(
                      LocaleKeys.strVerify.tr,
                      suffixIcon: FluIcons.arrowRight,
                      iconStrokeWidth: 1.8,
                      onPressed: () {
                        if (textEditingController.text.isEmpty) {
                          setState(() {
                            isEmptyFields = true;
                          });
                        } else {
                          // ProgressAlertDialog.progressAlertDialog(context, LocaleKeys.strLoading.tr);
                          controller.verifyOTP(otp: textEditingController.text);
                          // 632660
                          // SharedPrefService.saveLoginData(true, 'Malik Monk');
                          // ProgressAlertDialog.showALoadingDialog(
                          //     context, "Chargement..", 5, AppRoutes.PRIVACY);
                          // textEditingController.clear();
                        }
                      },
                      height: 5.8.h,
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
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
