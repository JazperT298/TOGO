import 'package:flukit/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/withdrawal/controller/withdrawal_controller.dart';

import '../../../../utils/configs.dart';

class WithdrawalOtpView extends GetView<WithdrawalController> {
  const WithdrawalOtpView({super.key});

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
                          controller.enterPinToTransactWithdrawal(
                              code: verificationCode);
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
