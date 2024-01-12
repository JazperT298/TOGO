import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/data/local/shared_preference.dart';
import 'package:ibank/app/modules/otp/controller/otp_controller.dart';
import 'package:flukit/flukit.dart';
import 'package:ibank/app/routes/app_routes.dart';
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
        child: Padding(
          padding: UISettings.pagePadding.copyWith(top: 10, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  AppImages.otpImage,
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.height * .3,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Confirmez votre numéro',
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                child: Text(
                  'Veuillez saisir le code à 06 chiffres que nous vous avons envoyé sur votre numéro',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey, fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                '+228 99 99 01 37',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.sp, color: const Color(0xFFFB6404), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 28),
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
                      } else if (!textEditingController.text.trim().contains('999900')) {
                        setState(() {
                          isEmptyFields = true;
                        });
                      } else {
                        SharedPrefService.saveLoginData(true, 'Malik Monk');
                        ProgressAlertDialog.showALoadingDialog(context, "Chargement..", 5, AppRoutes.PRIVACY);
                        textEditingController.clear();
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
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveFillColor: context.colorScheme.primaryContainer,
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
                      'Pin Code is required*',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: context.colorScheme.secondary,
                      ),
                    )
                  : Text(
                      'Renvoyer le code',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11.sp, color: context.colorScheme.primary, fontWeight: FontWeight.w600),
                    ),
              const SizedBox(height: 16),
              FluButton.text(
                'Verifier',
                suffixIcon: FluIcons.arrowRight,
                iconStrokeWidth: 1.8,
                onPressed: () {
                  if (textEditingController.text.isEmpty) {
                    setState(() {
                      isEmptyFields = true;
                    });
                  } else if (!textEditingController.text.trim().contains('999900')) {
                    setState(() {
                      isEmptyFields = true;
                    });
                  } else {
                    SharedPrefService.saveLoginData(true, 'Malik Monk');
                    ProgressAlertDialog.showALoadingDialog(context, "Chargement..", 5, AppRoutes.PRIVACY);
                    textEditingController.clear();
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
      ),
    );
  }
}
