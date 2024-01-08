import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';

class ProfileInformationPersonellesView extends GetView<ProfileController> {
  const ProfileInformationPersonellesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
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
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 175, 221, 243)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  "INFOS PERSONELLE.",
                  style: TextStyle(
                    fontSize: M3FontSizes.headlineSmall,
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SizedBox(
                    child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.06,
                )),
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
                  "Nom",
                  style: TextStyle(
                    fontSize: M3FontSizes.bodySmall,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Text(
                  controller.name.value,
                  style: const TextStyle(
                    fontSize: M3FontSizes.labelLarge,
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
                  "Prenoms",
                  style: TextStyle(
                    fontSize: M3FontSizes.bodySmall,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Text(
                  controller.firstname.value,
                  style: const TextStyle(
                    fontSize: M3FontSizes.labelLarge,
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
                  "Solde Flooz",
                  style: TextStyle(
                    fontSize: M3FontSizes.bodySmall,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Text(
                  controller.soldeFlooz.value,
                  style: const TextStyle(
                    fontSize: M3FontSizes.labelLarge,
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
                  "Date de naissance",
                  style: TextStyle(
                    fontSize: M3FontSizes.bodySmall,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Text(
                  controller.birthdate.value,
                  style: const TextStyle(
                    fontSize: M3FontSizes.labelLarge,
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
                  "Email",
                  style: TextStyle(
                    fontSize: M3FontSizes.bodySmall,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Text(
                  "${controller.name.value}@gmail.com",
                  style: const TextStyle(
                    fontSize: M3FontSizes.labelLarge,
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
