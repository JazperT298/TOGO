import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../../../utils/configs.dart';
import '../controller/profile_controller.dart';

class ProfileOtpView extends GetView<ProfileController> {
  const ProfileOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value == true
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              body: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: UISettings.pagePadding,
                      child: Text(
                        "Le code de vérification",
                        style: TextStyle(
                          fontSize: M3FontSizes.headlineSmall,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: OtpTextField(
                        obscureText: true,
                        numberOfFields: 4,
                        borderColor: Colors.lightBlue,
                        disabledBorderColor: Colors.black,
                        enabledBorderColor: Colors.lightBlue,
                        fillColor: Colors.lightBlue,
                        showFieldAsBox: true,
                        focusedBorderColor: Colors.lightBlue,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) async {
                          if (controller.selectedRoute.value ==
                              'Informations personelles.') {
                            controller.enterPinForInformationPersonelles(
                                code: verificationCode);
                          }
                        }, // end onSubmit
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
