// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/shared_preference.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/main.dart';
import 'package:ibank/utils/common/eula.dart';
import 'package:ibank/utils/constants/app_config.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/flooz_helper.dart';
import 'package:ibank/utils/sms/sms_option_enum.dart';
import 'package:ibank/utils/soap/soap_sender.dart';
import 'package:telephony/telephony.dart';

class SplashController extends GetxController {
  final telephony = Telephony.instance;
  late BuildContext context;
  late RxString messages;
  late Eula eula;
  final verifyUser = VerifyUser;
  @override
  void onInit() {
    // TODO: implement onInit
    // initPlatformState();
    isUserLogin();
    // validateSim();
    // WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(5.seconds, () => Get.toNamed(AppRoutes.ONBOARD)));
    super.onInit();
  }

  void isUserLogin() async {
    bool isLoginIn = await SharedPrefService.isLoggedIn();
    if (isLoginIn == true) {
      Get.toNamed(AppRoutes.BOTTOMNAV);
    } else {
      Get.toNamed(AppRoutes.ONBOARD);
    }
  }

  onMessage(SmsMessage message) async {
    messages.value = message.body ?? "Error reading message body.";
  }

  onSendStatus(SendStatus status) {
    messages.value = status == SendStatus.SENT ? "sent" : "delivered";
  }

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;
    if (result != null && result) {
      telephony.listenIncomingSms(onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }
  }

  // Future<bool> checkUser() async {
  //   SimState simState = await telephony.simState;

  //   AppGlobal.IS_ACC_CHECKING_ENABLED = true;

  //   if (AppConfig.FLAVOR_mode != 'bypass') {
  //     Eula.sendEula();
  //   }

  //   return true;
  // }
  // check SIM if ready or not
  void validateSim() async {
    try {
      await SqlHelper.checkDB(context);
      SimState simState = await telephony.simState;
      if (simState == SimState.READY) {
        AppGlobal.IS_ACC_CHECKING_ENABLED = true;
        if (AppConfig.FLAVOR_mode != 'bypass') {
          Eula.sendEula(verifyUser as VerifyUser);
        }
      } else {
        showSimNotReadyDialog();
      }
    } catch (e) {
      print('SIM NOT READY $e');
    }
  }

  void showSimNotReadyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            'Merci d’avoir installé l’application FLOOZ de MOOV. Pour continuer, veuillez insérer la carte SIM associée à votre compte Flooz.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Assuming you want to close the screen when the user clicks 'OK'
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> checkUser() async {
    if (AppGlobal.IS_ACC_CHECKING_ENABLED == true) {
      String? token = await SqlHelper.getToken();
      //				String hits = "VRFY ANDROIDAPP " + SqlHelper.getToken(this) + " ANDROID " + BuildConfig.VERSION_NAME + " " + getLanguage();

      String hits = 'VRFY ANDROIDAPP $token ANDROID V2 F';

      SoapSender.sendSoap(context, hits, '', SmsOption.WAIT_RESPONSE, '', false);

      //response for sending soap

      String? message = FloozHelper.getMessage();
      print('Message $message');
      if (message == 'SUCCESS') {
        // KRouter.replace(context, Routes.main);
        Get.toNamed(AppRoutes.BOTTOMNAV);
        return true;
      } else {
        // KRouter.replace(context, Routes.onboarding);
        Get.toNamed(AppRoutes.ONBOARD);
        return false;
      }
    }
    return true;
  }
}
