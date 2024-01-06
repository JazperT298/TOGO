import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/shared_preference.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/main.dart';
import 'package:telephony/telephony.dart';

class SplashController extends GetxController {
  final telephony = Telephony.instance;
  late BuildContext context;
  late RxString messages;

  @override
  void onInit() {
    // TODO: implement onInit
    // initPlatformState();
    isUserLogin();
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
  // void validateSim() async {
  // try {
  //   await SqlHelper.checkDB(context);
  //   SimState simState = await telephony.simState;
  //   if (simState == SimState.READY) {
  //     AppGlobal.IS_ACC_CHECKING_ENABLED = true;
  //   }
  // } catch (e) {
  //   print(e);
  // }
  // }
  //   void showSimNotReadyDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: const Text(
  //           'Merci d’avoir installé l’application FLOOZ de MOOV. Pour continuer, veuillez insérer la carte SIM associée à votre compte Flooz.',
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               // Assuming you want to close the screen when the user clicks 'OK'
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //   void checkUser(BuildContext context) async {
  //   if (AppGlobal.IS_ACC_CHECKING_ENABLED == true) {
  //     String? token = await SqlHelper.getToken();
  //     //				String hits = "VRFY ANDROIDAPP " + SqlHelper.getToken(this) + " ANDROID " + BuildConfig.VERSION_NAME + " " + getLanguage();

  //     String hits = 'VRFY ANDROIDAPP $token ANDROID V2 F';

  //     SoapSender.sendSoap(context, hits, '', SmsOption.WAIT_RESPONSE, '', false);

  //     String? message = FloozHelper.getMessage();
  //     print('Message $message');
  //     if (message == 'SUCCESS') {
  //       KRouter.replace(context, Routes.main);
  //     } else {
  //       KRouter.replace(context, Routes.onboarding);
  //     }
  //   }
  // }
}
