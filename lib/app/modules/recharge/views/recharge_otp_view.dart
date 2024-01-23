import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import '../../../../utils/configs.dart';

class RechargeOtpView extends GetView<RechargeController> {
  const RechargeOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.only(
                  left: MediaQuery.of(Get.context!).size.width * 0.05,
                  right: MediaQuery.of(Get.context!).size.width * 0.05),
              height: MediaQuery.of(Get.context!).size.height * 0.07,
              width: MediaQuery.of(Get.context!).size.width,
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                controller: controller.code,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 175, 221, 243),
                  filled: true,
                  contentPadding: EdgeInsets.only(
                      left: MediaQuery.of(Get.context!).size.width * 0.03),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.13,
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 175, 221, 243)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ))),
                  onPressed: () {
                    if (controller.code.text.isNotEmpty) {
                      if (controller.selectedOption.value == "For myself") {
                        // controller.verifyAndroid(
                        //     code: controller.code.text,
                        //     amount: controller.amountTextField.text,
                        //     msisdn: Get.find<StorageServices>()
                        //         .storage
                        //         .read('msisdn'));
                      } else {
                        // controller.verifyAndroid(
                        //     code: controller.code.text,
                        //     amount: controller.amountTextField.text,
                        //     msisdn: controller.numberTextField.text);
                      }
                    } else {
                      Get.snackbar("Message", "Entrées manquantes",
                          backgroundColor: Colors.lightBlue,
                          colorText: Colors.white);
                    }
                  },
                  child: const FluIcon(
                    FluIcons.arrowRight,
                    size: 30,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   child: OtpTextField(
            //     obscureText: true,
            //     numberOfFields: 4,
            //     borderColor: Colors.lightBlue,
            //     disabledBorderColor: Colors.black,
            //     enabledBorderColor: Colors.lightBlue,
            //     fillColor: Colors.lightBlue,
            //     showFieldAsBox: true,
            //     focusedBorderColor: Colors.lightBlue,
            //     onCodeChanged: (String code) {},
            //     onSubmit: (String verificationCode) async {
            //       if (controller.selectedRoute.value ==
            //           'Informations personelles.') {
            //         controller.enterPinForInformationPersonelles(
            //             code: verificationCode);
            //       }
            //     }, // end onSubmit
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
