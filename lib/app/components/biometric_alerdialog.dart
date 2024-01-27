import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/utils/constants/app_images.dart';

void biometricsAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.1),
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Card(
                  margin: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 15),
                          child: Image.asset(
                            AppImages.icOops,
                            color: Colors.red,
                            width: 80,
                          ),
                        ),
                        Text(
                          message,
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: const Color(0xFFFB6404), fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 40),
                          child: ElevatedButton(
                            child: const Text('Okay'),
                            onPressed: () {
                              AppSettings.openAppSettings(); // .openLockAndPasswordSettings();
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
