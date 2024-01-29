import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/components/main_loading.dart';
import 'package:ibank/app/modules/login/controller/login_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/constants/app_images.dart';
import 'package:sizer/sizer.dart';

class LoginSecurityCodeView extends StatefulWidget {
  const LoginSecurityCodeView({super.key});

  @override
  State<LoginSecurityCodeView> createState() => _LoginSecurityCodeViewState();
}

class _LoginSecurityCodeViewState extends State<LoginSecurityCodeView> {
  List<bool> filledCircles = List.filled(8, false);
  String pinCode = '';
  bool hasError = false;
  final controller = Get.put(LoginController());

  void _handleKeyPress(String key) {
    for (int i = 0; i < filledCircles.length; i++) {
      if (!filledCircles[i]) {
        setState(() {
          hasError = false;
          filledCircles[i] = true;
          pinCode += key;
        });
        break;
      }
    }
  }

  void _handleDelete() {
    for (int i = filledCircles.length - 1; i >= 0; i--) {
      if (filledCircles[i]) {
        setState(() {
          filledCircles[i] = false;
        });
        if (pinCode.isNotEmpty) {
          pinCode = pinCode.substring(0, pinCode.length - 1);
        }
        break;
      }
    }
  }

  void _resetFilledCircles() {
    setState(() {
      filledCircles = List.filled(8, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
        overlayStyle: context.systemUiOverlayStyle.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        body: Obx(() => SafeArea(
              child: Stack(
                children: [
                  if (controller.isLoadingSecurity.value == true)
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.LOGINPROFILE);
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Image.asset(AppImages.userIcon, height: 30, width: 30),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Please enter your security code to access your application',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        _buildPinCodeDisplay(),
                        SizedBox(height: 7.h),
                        _buildNumberPad(),
                        SizedBox(height: 10.h),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Forgot security code?',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: const Color(0xFF124DE5), fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _buildPinCodeDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: filledCircles.map((filled) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          width: 16.0,
          height: 16.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: hasError
                    ? const Color(0xFFFF0000)
                    : filled
                        ? const Color(0xFFFB6404)
                        : Colors.black,
                width: 2.0),
            color: filled ? const Color(0xFFFB6404) : Colors.transparent,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberKey('1'),
            _buildNumberKey('2'),
            _buildNumberKey('3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberKey('4'),
            _buildNumberKey('5'),
            _buildNumberKey('6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberKey('7'),
            _buildNumberKey('8'),
            _buildNumberKey('9'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDeleteKey(),
            _buildNumberKey('0'),
            _buildSendContainer(),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberKey(String number) {
    return InkWell(
      onTap: () => _handleKeyPress(number),
      child: Container(
        width: 80.0,
        height: 80.0,
        alignment: Alignment.center,
        child: Text(
          number,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildDeleteKey() {
    return InkWell(
      onTap: _handleDelete,
      child: Container(
        width: 80.0,
        height: 80.0,
        alignment: Alignment.center,
        child: const Icon(Icons.backspace),
      ),
    );
  }

  Widget _buildSendContainer() {
    return InkWell(
      onTap: () {
        if (pinCode.length < 4) {
          setState(() {
            hasError = true;
          });
        } else {
          controller.enterPinForInformationPersonelles(code: pinCode);
          // CLEAR THE CIRCLE AFTER THE FAILED MESSAGE
          if (controller.isResetCircle.value == true) {
            setState(() {
              _resetFilledCircles();
              pinCode = '';
            });
          }
        }

        // controller.enterPinForInformationPersonelles(code: code.text);
        // Get.offAllNamed(AppRoutes.LOGINSUCCESS);
      },
      child: Container(
        width: 80.0,
        height: 80.0,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF123DE5),
          ),
          child: const FluIcon(
            FluIcons.checkUnicon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
