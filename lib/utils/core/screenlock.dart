// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/biometric_alerdialog.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:local_auth/local_auth.dart';

class ScreenLock {
  BuildContext? context;
  ScreenLock({this.context});

  LocalAuthentication localAuthentication = LocalAuthentication();

  void authenticateUser({bool? value, String? message, BuildContext? context, String? deviceName, int? platformId}) async {
    try {
      bool canAuthenticateWithBiometrics = await localAuthentication.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await localAuthentication.isDeviceSupported();
      if (canAuthenticate == true) {
        if (canAuthenticateWithBiometrics == true) {
          List<BiometricType> availableBiometrics = await localAuthentication.getAvailableBiometrics();
          if (Platform.isAndroid) {
            if (availableBiometrics.contains(BiometricType.strong)) {
              //FACE ID
              bool didAuthenticate = await localAuthentication.authenticate(
                localizedReason: 'Please authenticate to access the app',
              );
              if (didAuthenticate == true) {
                Get.offAllNamed(AppRoutes.BOTTOMNAV);
                // context!.read<LoginBloc>().add(LoginWithPinSubmitted(deviceName!, platformId!));
              }
            } else {
              biometricsAlertDialog(context!, 'Enable figerprint to authenticate');
            }
          } else {
            if (availableBiometrics.contains(BiometricType.face)) {
              bool didAuthenticate = await localAuthentication.authenticate(
                localizedReason: 'Please authenticate to access the app',
              );
              if (didAuthenticate == true) {
                Get.offAllNamed(AppRoutes.BOTTOMNAV);
                // context!.read<LoginBloc>().add(LoginWithPinSubmitted(deviceName!, platformId!));
              }
            } else {
              biometricsAlertDialog(context!, 'Enable face id to authenticate');
            }
          }
        } else {
          //Do pin code
          log('Value $canAuthenticateWithBiometrics');
        }
      } else {
        AppSettings.openAppSettings();
      }
    } catch (e) {
      log('ERROR ${e.toString()}');
    }
  }
}
