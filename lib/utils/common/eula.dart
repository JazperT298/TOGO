// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_import, unrelated_type_equality_checks

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/info_alert_dialog.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/modules/splash/controller/splash_controller.dart';
import 'package:ibank/utils/common/app_session_manager.dart';
import 'package:ibank/utils/constants/app_config.dart';
import 'package:ibank/utils/constants/sys_prop.dart';
import 'package:ibank/utils/handlers/eula_ota_handler.dart';
import 'package:ibank/utils/presenter/eula_presenter.dart';
import 'package:ibank/utils/constants/app_labels.dart';
import 'package:ibank/utils/handlers/message_handler.dart';
import 'package:ibank/utils/sms/sms_listener.dart';
import 'package:ibank/utils/sms/sms_option_enum.dart';
import 'package:ibank/utils/soap/soap_sender.dart';

abstract class VerifyUser {
  bool onVerifySuccess();
  bool onVerifyFailed();
}

class VerifyUserImpl implements VerifyUser {
  @override
  bool onVerifySuccess() {
    return true;
  }

  @override
  bool onVerifyFailed() {
    // Your implementation for failure
    return false;
  }
}

class Eula extends EulaPresenter with SendSmsListeners {
  static late BuildContext ctx;
  late EulaPresenter eulaPresenter;
  late Timer time;
  static late String msisdn;

  Eula(super.context, super.iRequestOtp, super.iVerify);

  static void initializeSmsApi() {}

  //from validateSim,
  static void sendEula(VerifyUser verifyUser) {
    SqlHelper.checkDB(ctx);
    SplashController controller = Get.find();

    if (!isFreshInstall()) {
      return;
    }

    controller.checkUser();

    verifyUser.onVerifyFailed();

    verifyUser.onVerifyFailed();
    // if (res == false) {
    //   // check if what is the OTP message
    //   // InfoAlertDialog.progressAlertDialog(Get.context!, progressMessage);

    //   return false;
    // } else {
    //   return true;
    // }
  }

  static void generateOTP() {
    // EULA GETOTP <os> <msisdn>
    String hits = 'EULA GETOTP  ANDROID $msisdn';
    print("HITS $hits");
    SoapSender.sendSoap(ctx, hits, '', SmsOption.WAIT_RESPONSE, '', false);
  }

  @override
  bool onFailed(String why) {
    if (time != null) {
      time.cancel();
    }
    showToast(ctx, why);
    return super.onFailed(why);
  }

  @override
  void onVerifyMsisdn(bool isEncrypted, bool sendsms, String msisdn, String message) {
    // TODO: implement onVerifyMsisdn
    super.onVerifyMsisdn(isEncrypted, sendsms, msisdn, message);
  }

  @override
  bool onDelivered() {
    // TODO: implement onDelivered
    return true;
  }

  @override
  void onRequestOtp(BuildContext context, bool isEncrypted, String msisdn, String message) {
    // TODO: implement onRequestOtp
    super.onRequestOtp(context, isEncrypted, msisdn, message);
  }

  @override
  bool onResponse(String sender, String message) {
    RegExp pattern = RegExp(r"^(?<success>(?<string1>.*)(?<= \()(?<otp>\d{6})(?=\))(?<string2>.*))$");
    RegExpMatch? matcher = pattern.firstMatch(message);

    if (matcher != null) {
      print("SMS ${matcher.group(2)}${matcher.group(4)}");

      String otpcode = matcher.group(3)!;

      MessageHandler.initObjHandler(EulaOTAHandler);
      String? token = SqlHelper.getToken().toString();
      String hits = "EULA OTP $otpcode $token ANDROID V1";

      // progress.show(ctx.getResources().getString(R.string.sending));
      eulaPresenter.onVerify(false, msisdn, hits, token);
      return true;
    } else {
      return false;
    }
  }

  @override
  bool onSent() {
    // TODO: implement onSent
    return true;
  }

  @override
  bool onTimeout() {
    if (time != null) {
      time.cancel();
    }
    showToast(ctx, AppLabels.unable_to_send_sms);
    return super.onTimeout();
  }

  @override
  void onVerify(bool isEncrypted, String msisdn, String message, String token) {
    // TODO: implement onVerify
    super.onVerify(isEncrypted, msisdn, message, token);
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static bool isNewAppVersion() {
    if (SqlHelper.getProperty(SysProp.PROP_VERSION_CODE, "0") == AppConfig.app_version_code &&
        SqlHelper.getProperty(SysProp.PROP_VERSION_NAME, "0") == AppConfig.app_package_name) {
      return false;
    }
    SqlHelper.getProperty(SysProp.PROP_STAT_LOGIN, "0");
    return true;
  }

  static bool isFreshInstall() {
    if (AppSessionManager.newInstance(Get.context!).isFirstInstall()) {
      return false;
    }
    SqlHelper.setProperty(SysProp.PROP_STAT_LOGIN, "0");
    return true;
  }

  // Eula(this.ctx) : super(null, null, null) {
  //   IRequestOtp? iRequestOtp;
  //   IVerify? iVerify;
  //   IVerifyMsisdn? iVerifyMsisdn;
  //   SendSmsListener? smsListener;
  //   eulaPresenter = EulaPresenter.withSmsListener(
  //     ctx,
  //     iRequestOtp,
  //     iVerify,
  //     iVerifyMsisdn,
  //     smsListener = SendSmsListeners(
  //       onFailed: (why) {
  //         if (time != null) {
  //           AppConfig.print("UnRegisterTime()", "True");
  //           time.cancel();
  //           time.purge();
  //           time = Timer(Duration(seconds: 0), () {});
  //         }

  //         ctx.runOnUiThread(() => showToast(ctx, why));
  //         return false;
  //       },
  //       onSent: () => true,
  //       onDelivered: () => true,
  //       onResponse: (sender, message) {
  //         if (time != null) {
  //           AppConfig.print("UnRegisterTime()", "True");
  //           time.cancel();
  //           time.purge();
  //           time = Timer(Duration(seconds: 0), () {});
  //         }

  //         ctx.runOnUiThread(() {
  //           RegExp pattern = RegExp(r"^(?<success>(?<string1>.*)(?<= \()(?<otp>\d{6})(?=\))(?<string2>.*))$");
  //           RegExpMatch? matcher = pattern.firstMatch(message);

  //           if (matcher != null) {
  //             print("SMS ${matcher.group(2)}${matcher.group(4)}");

  //             String otpcode = matcher.group(3)!;

  //             MessageHandlers.initObjHandler(EulaOTAHandler());
  //             String token = SqlHelper.getToken(ctx);
  //             String hits = "EULA OTP $otpcode $token ANDROID ${ctx.getResources().getString(R.string.app_version_name)}";

  //             progress.show(ctx.getResources().getString(R.string.sending));
  //             eulaPresenter.onVerify(false, msisdn, hits, token);
  //           } else {
  //             ctx.startActivity(Intent(ctx, VerifyUserActivity())
  //               ..putExtra("MSISDN", msisdn)
  //               ..addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
  //               ..addFlags(Intent.FLAG_ACTIVITY_NEW_TASK));
  //           }
  //         });
  //         return true;
  //       },
  //       onTimeout: () {
  //         if (time != null) {
  //           AppConfig.print("UnRegisterTime()", "True");
  //           time.cancel();
  //           time.purge();
  //           time = Timer(Duration(seconds: 0), () {});
  //         }

  //         ctx.runOnUiThread(() => showToast(ctx, ctx.getResources().getString(R.string.unable_to_send_sms)));
  //         return false;
  //       },
  //     ),
  //   );

  //   // String language = PreferenceManager.getDefaultSharedPreferences(ctx).getString("language_code", "fr")!;
  //   // Resources standardResources = ctx.getResources();
  //   // DisplayMetrics metrics = standardResources.getDisplayMetrics();
  //   // Configuration config = Configuration(standardResources.getConfiguration());
  //   // config.locale = Locale(language);
  //   // standardResources.updateConfiguration(config, metrics);

  //   // initProgressDialog(ctx);
  // }
}
