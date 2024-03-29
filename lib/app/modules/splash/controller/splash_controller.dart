// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, unused_import

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibank/app/components/permission_bottom_sheet.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
// import 'package:ibank/app/data/local/shared_preference.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/app/services/android_verify_services.dart';
import 'package:ibank/app/services/location_service.dart';
import 'package:ibank/app/services/platform_device_services.dart';
import 'package:ibank/main.dart';
import 'package:ibank/utils/common/eula.dart';
import 'package:ibank/utils/constants/app_config.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/helpers/flooz_helper.dart';
import 'package:ibank/utils/sms/sms_option_enum.dart';
import 'package:ibank/utils/soap/soap_sender.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class SplashController extends GetxController {
  final telephony = Telephony.instance;
  late BuildContext context;
  late RxString messages;
  late Eula eula;
  final verifyUser = VerifyUser;
  final storage = GetStorage();
  @override
  void onInit() async {
    // initPlatformState();
    await requestAllPermissionOnStart();
    // validateSim();
    // WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(5.seconds, () => Get.toNamed(AppRoutes.ONBOARD)));
    super.onInit();
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

  Future<void> requestAllPermissionOnStart() async {
    // add following permission here, we have location only so far
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.contacts,
    ].request();
    print(statuses[Permission.location]);

    // Check the status of each permission
    statuses.forEach((permission, status) async {
      if (!status.isGranted) {
        showPermissionDeniedDialog(context, permission);
      }
      await _initLocationService();
      await isUserLogin();
    });
  }

  //Inject location service
  Future<void> _initLocationService() async {
    await Get.putAsync(LocationService().init);
  }

  Future<void> isUserLogin() async {
    if (storage.read('msisdn') != null) {
      if (storage.read('isPrivacyCheck') == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(3.seconds, () => Get.offAllNamed(AppRoutes.PRIVACY)));
      } else if (storage.read('isLoginSuccessClick') == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(3.seconds, () => Get.offAllNamed(AppRoutes.LOGINSUCCESS)));
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          // await Future.delayed(3.seconds, () => Get.offAllNamed(AppRoutes.BOTTOMNAV));
          await Future.delayed(3.seconds, () {
            Get.offAllNamed(AppRoutes.LOGINPINBIOMETRICS);
            if (Get.find<StorageServices>().storage.read('biometrics') != null) {
              AppGlobal.BIOMETRICS = Get.find<StorageServices>().storage.read('biometrics');
            }
          });
        });
        // bool verified = await Get.find<AndroidVerifyServices>().verifyAndroid();
        // log('verified $verified');
        // if (verified) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) async {
        //     // await Future.delayed(3.seconds, () => Get.offAllNamed(AppRoutes.BOTTOMNAV));
        //     await Future.delayed(3.seconds, () {
        //       Get.offAllNamed(AppRoutes.LOGINPINBIOMETRICS);
        //       if (Get.find<StorageServices>().storage.read('biometrics') != null) {
        //         AppGlobal.BIOMETRICS = Get.find<StorageServices>().storage.read('biometrics');
        //       }
        //     });
        //   });
        // } else {
        //   WidgetsBinding.instance.addPostFrameCallback((_) async {
        //     await Future.delayed(2.seconds, () {
        //       Get.find<StorageServices>().storage.remove('msisdn');
        //       Get.find<StorageServices>().storage.remove('isPrivacyCheck');
        //       Get.find<StorageServices>().storage.remove('isLoginSuccessClick');
        //       Get.find<StorageServices>().clearUserLocalData();
        //       Get.find<StorageServices>().clearUsersInformation();
        //       Get.offAllNamed(AppRoutes.LOGIN);
        //     });
        //   });
        // }
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(2.seconds, () => Get.offAllNamed(AppRoutes.ONBOARD)).then((value) {
            Get.find<StorageServices>().saveLanguage(language: 'EN');
            String enLang = Get.find<StorageServices>().storage.read('language');
            Get.updateLocale(Locale(enLang.toLowerCase()));
            AppGlobal.isSelectEnglish = enLang == "EN" ? true : false;
            AppGlobal.isSelectEnglish = enLang == "EN" ? true : false;
          }));
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

      String hits = 'VRFY ${Get.find<DevicePlatformServices>().channelID} $token ${Get.find<DevicePlatformServices>().deviceType} V2 F';

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
