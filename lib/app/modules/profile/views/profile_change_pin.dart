import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/profile/controller/profile_controller.dart';
import 'package:ibank/generated/locales.g.dart';

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
                          child: Text(
                            LocaleKeys.strAccount.tr,
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Text(
                            LocaleKeys.strChangePassword.tr.toUpperCase(), //     "CHANGER DE PASS.",
                            style: const TextStyle(
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
                          child: Text(
                            LocaleKeys.strOldPassword.tr,
                            style: const TextStyle(
                              fontSize: M3FontSizes.bodySmall,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(Get.context!).size.width * 0.05, right: MediaQuery.of(Get.context!).size.width * 0.05),
                        height: MediaQuery.of(Get.context!).size.height * 0.07,
                        width: MediaQuery.of(Get.context!).size.width,
                        child: TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          controller: controller.oldPIN,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 175, 221, 243),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.width * 0.03),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Text(
                            LocaleKeys.strNewPassword.tr,
                            style: const TextStyle(
                              fontSize: M3FontSizes.bodySmall,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(Get.context!).size.width * 0.05, right: MediaQuery.of(Get.context!).size.width * 0.05),
                        height: MediaQuery.of(Get.context!).size.height * 0.07,
                        width: MediaQuery.of(Get.context!).size.width,
                        child: TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          controller: controller.newPIN,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 175, 221, 243),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.width * 0.03),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Text(
                            LocaleKeys.strConfirmNewPassword.tr,
                            style: const TextStyle(
                              fontSize: M3FontSizes.bodySmall,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(Get.context!).size.width * 0.05, right: MediaQuery.of(Get.context!).size.width * 0.05),
                        height: MediaQuery.of(Get.context!).size.height * 0.07,
                        width: MediaQuery.of(Get.context!).size.width,
                        child: TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          controller: controller.confirmNewPIN,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 175, 221, 243),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: MediaQuery.of(Get.context!).size.width * 0.03),
                            alignLabelWithHint: false,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
                        height: MediaQuery.of(context).size.height * 0.27,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        child: FluButton.text(
                          LocaleKeys.strChangePin.tr,
                          suffixIcon: FluIcons.passwordCheck,
                          iconStrokeWidth: 1.8,
                          onPressed: () {
                            if (controller.oldPIN.text.isEmpty || controller.newPIN.text.isEmpty || controller.confirmNewPIN.text.isEmpty) {
                              Get.snackbar("Message", LocaleKeys.strPasswordWarning.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            } else if (controller.newPIN.text != controller.confirmNewPIN.text) {
                              Get.snackbar("Message", LocaleKeys.strPasswordNotMatch.tr, backgroundColor: Colors.lightBlue, colorText: Colors.white);
                            } else {
                              controller.changePin(oldPin: controller.oldPIN.text, newPin: controller.newPIN.text);
                            }
                          },
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
                          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
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
