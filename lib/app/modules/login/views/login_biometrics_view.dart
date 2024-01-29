// ignore_for_file: unused_local_variable, unused_element

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sizer/sizer.dart';

class LoginBiometricsView extends StatefulWidget {
  const LoginBiometricsView({super.key});

  @override
  State<LoginBiometricsView> createState() => _LoginBiometricsViewState();
}

class _LoginBiometricsViewState extends State<LoginBiometricsView> {
  final controller = Get.put(LoginController());

  bool secured = false;
  String? secureText;
  LocalAuthentication localAuthentication = LocalAuthentication();
  bool isloading = false;
  List<BiometricType>? availableBiometrics;
  @override
  void initState() {
    super.initState();
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
              if (controller.isLoadingBiometric.value == true)
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
                    const Spacer(),
                    Text(
                      'Add extra security options',
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: UISettings.pagePadding.copyWith(left: 24, right: 24),
                      child: Text(
                        'You may add extra security with facial recognition option to login to your account. This step is optional',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Image.asset(
                        AppImages.logoFaceId,
                        height: 110,
                        width: 110,
                      ),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
                          value: secured,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              secured = value;
                              secureText = value.toString();
                            });
                            setState(() {});
                          },
                        ),
                        Text(
                          'Enable facial recognition authentication',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FluButton.text(
                        'Continue', //   'Réessayer',
                        iconStrokeWidth: 1.8,
                        onPressed: secured == true
                            ? () {
                                Get.find<StorageServices>().saveBiometricsToStorage(biometrics: secured);
                                controller.biometricsContinueButtonClick();
                              }
                            : null,
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
                        textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FluButton.text(
                        'Not now', //   'Fermer',

                        iconStrokeWidth: 1.8,
                        onPressed: () {
                          // controller.code.clear();
                          // Get.toNamed(AppRoutes.BOTTOMNAV);
                          Get.offAllNamed(AppRoutes.LOGINSUCCESS);
                        },
                        height: 5.8.h,

                        width: MediaQuery.of(context).size.width * 16,
                        cornerRadius: UISettings.minButtonCornerRadius,
                        border: BorderSide(color: context.colorScheme.primary),
                        // backgroundColor: context.colorScheme.primary,
                        foregroundColor: context.colorScheme.onPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: context.colorScheme.primary.withOpacity(.35),
                            blurRadius: 25,
                            spreadRadius: 3,
                            offset: const Offset(0, 5),
                          )
                        ],
                        textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: context.colorScheme.primary),
                      ),
                    ),
                    const Spacer(),
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
