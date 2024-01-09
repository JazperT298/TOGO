import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/profile/controller/profile_controller.dart';

import '../../../../utils/configs.dart';

class ProfileChangePinView extends GetView<ProfileController> {
  const ProfileChangePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
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
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 175, 221, 243)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ))),
                            onPressed: () {
                              Get.back();
                            },
                            child: const FluIcon(
                              FluIcons.arrowLeft,
                              size: 30,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: const Text("COMPTE")),
                      Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: const Text(
                            "CHANGER DE PASS.",
                            style: TextStyle(
                              fontSize: M3FontSizes.headlineSmall,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: const Text(
                            "Ancien mot de passe",
                            style: TextStyle(
                              fontSize: M3FontSizes.bodySmall,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: FluTextField(
                          inputController: controller.oldPIN,
                          hint: "",
                          height: 50,
                          cornerRadius: 15,
                          keyboardType: TextInputType.number,
                          fillColor: context.colorScheme.primaryContainer,
                          textStyle:
                              const TextStyle(fontSize: M3FontSizes.bodyMedium),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: const Text(
                            "Nouveau mot de passe",
                            style: TextStyle(
                              fontSize: M3FontSizes.bodySmall,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: FluTextField(
                          inputController: controller.newPIN,
                          hint: "",
                          height: 50,
                          cornerRadius: 15,
                          keyboardType: TextInputType.number,
                          fillColor: context.colorScheme.primaryContainer,
                          textStyle:
                              const TextStyle(fontSize: M3FontSizes.bodyMedium),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: const Text(
                            "Confirmer nouveau mot de passe",
                            style: TextStyle(
                              fontSize: M3FontSizes.bodySmall,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: FluTextField(
                          inputController: controller.confirmNewPIN,
                          hint: "",
                          height: 50,
                          cornerRadius: 15,
                          keyboardType: TextInputType.number,
                          fillColor: context.colorScheme.primaryContainer,
                          textStyle:
                              const TextStyle(fontSize: M3FontSizes.bodyMedium),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: FluButton.text(
                          'Changer le code PIN',
                          suffixIcon: FluIcons.passwordCheck,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.oldPIN.text.isEmpty ||
                                controller.newPIN.text.isEmpty ||
                                controller.confirmNewPIN.text.isEmpty) {
                              Get.snackbar("Message", "Entrée manquante",
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            } else if (controller.newPIN.text !=
                                controller.confirmNewPIN.text) {
                              Get.snackbar(
                                  "Message", "Le code PIN ne correspond pas",
                                  backgroundColor: Colors.lightBlue,
                                  colorText: Colors.white);
                            } else {
                              controller.changePin(
                                  oldPin: controller.oldPIN.text,
                                  newPin: controller.newPIN.text);
                            }
                          },
                          height: 55,
                          width: MediaQuery.of(context).size.width * 16,
                          cornerRadius: UISettings.minButtonCornerRadius,
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: context.colorScheme.onPrimary,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  context.colorScheme.primary.withOpacity(.35),
                              blurRadius: 25,
                              spreadRadius: 3,
                              offset: const Offset(0, 5),
                            )
                          ],
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: M3FontSizes.bodyLarge),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      ),
    );
  }
}