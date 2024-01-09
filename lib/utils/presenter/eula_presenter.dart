// ignore_for_file: avoid_print, unnecessary_null_comparison, unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/utils/common/app_session_manager.dart';
import 'package:ibank/utils/constants/app_string_validation.dart';
import 'package:ibank/utils/constants/app_strings.dart';
import 'package:ibank/utils/constants/sys_prop.dart';
import 'package:ibank/utils/core/soap_config.dart';
import 'package:ibank/utils/handlers/message_handler.dart';
import 'package:ibank/utils/helpers/request_otp_model.dart';
import 'package:ibank/utils/sms/sms_listener.dart';
import 'package:ibank/utils/sms/sms_option_enum.dart';
import 'package:ibank/utils/sms/sms_sender.dart';

import 'package:ibank/utils/string_utils.dart';

abstract class IEulaPresenter {
  bool isOnline();

  void onRequestOtp(BuildContext context, bool isEncrypted, String msisdn, String message);

  void onVerify(bool isEncrypted, String msisdn, String message, String token);

  void onVerifyMsisdn(bool isEncrypted, bool sendsms, String msisdn, String message);
}

class IEulaView {
  IRequestOtp? iRequestOtp;
  IVerify? iVerify;
  IVerifyMsisdn? iVerifyMsisdn;
  SendSmsListener? smsListener;
  BuildContext? context;
}

abstract class IRequestOtp {
  void onRequestValidateFailed(String reason);
}

abstract class IVerify {
  void onVerifyFailed(String reason);

  void onVerifySuccess();
}

abstract class IVerifyMsisdn {
  void onVerifyMsisdnFailed(String reason);

  void onVerifyMsisdnSuccess(BuildContext context);
}

class EulaPresenter implements IEulaPresenter {
  IRequestOtp? iRequestOtp;
  IVerify? iVerify;
  IVerifyMsisdn? iVerifyMsisdn;
  SendSmsListener? smsListener;
  BuildContext? context;

  EulaPresenter(context, this.iRequestOtp, this.iVerify);

  EulaPresenter.withVerifyMsisdn(context, this.iRequestOtp, this.iVerify, this.iVerifyMsisdn);

  EulaPresenter.withSmsListener(context, this.iRequestOtp, this.iVerify, this.iVerifyMsisdn, this.smsListener);

  @override
  bool isOnline() {
    // return SoapTool.isOnline(getActivity());
    return true;
  }

  @override
  void onRequestOtp(BuildContext context, bool isEncrypted, String msisdn, String message) {
    final RequestOTPModel requestOTP = RequestOTPModel(message, msisdn);
    int code = requestOTP.validateData();
    switch (code) {
      case 0:
        try {
          SmsSenders.sendSms(context, requestOTP.getMessage(), SmsOption.WAIT_RESPONSE, smsListener!, AppStrings.smsprogress);
        } catch (e) {
          print(e);
        }

        break;
      case 1:
        iRequestOtp!.onRequestValidateFailed(AppStringValidation.msisdnRequired);
        break;
    }
  }

  @override
  void onVerify(bool isEncrypted, String msisdn, String message, String token) {
    final VerifyMobileNumberModel verify = VerifyMobileNumberModel(token, message, msisdn);

    try {
      String response = SoapConfig.invoke(context!, verify.getParameters(context!, isEncrypted)) as String;

      if (MessageHandler.classObj != null && MessageHandler.classObj.isNotEmpty) {
        Message msg1 = Message.withSource(context, response, "sms");
        if (MessageHandler.parseMessage(msg1) == false) {
          // AppConfig.appendLog(activity, "debug ito", "pumasok dito #1");
          iVerify!.onVerifyFailed(msg1.msg);
          return;
        }
      }

      // AppConfig.appendLog(activity, "debug ito", "pumasok dito #2");
      bool bool1 = StringUtil().isNullOrEmpty(SqlHelper.getProperty(SysProp.PROP_VERSION_CODE, "") as String?);
      bool bool2 = StringUtil().isNullOrEmpty(SqlHelper.getProperty(SysProp.PROP_VERSION_NAME, "") as String?);
      bool bool3 = AppSessionManager.newInstance(context!).isFirstInstall();

      if ((!bool1) && (!bool2)) {
        // AppConfig.appendLog(activity, "debug ito", "pumasok dito #3");
        iVerify!.onVerifySuccess();
      }
    } catch (e) {
      // AppConfig.appendLog(activity, "debug ito", "pumasok dito #4");
      print(e);
      // AppConfig.appendLog(activity, "debug ito", AppConfig.exceptionToStr(e));
    }
  }

  @override
  void onVerifyMsisdn(bool isEncrypted, bool sendsms, String msisdn, String message) {
    final RequestOTPModel requestOTP = RequestOTPModel(message, msisdn);
    int code = requestOTP.validateData();
    switch (code) {
      case 0:
        String? response;

        try {
          response = SoapConfig.invoke(context!, requestOTP.getParametersWithSms(context!, isEncrypted, sendsms)) as String;
          // AppConfig.appendLog(activity, "onVerifyMsisdn-Response", response);

          Map<String, dynamic> res = json.decode(response);
          String description = "", inter = "", msg = "", status = "";
          bool offNet = false, onNet = false;
          if (res.containsKey("description")) description = res["description"];
          if (res.containsKey("international")) inter = res["international"];
          if (res.containsKey("message")) msg = res["message"];
          if (res.containsKey("offNet")) offNet = res["offNet"];
          if (res.containsKey("onNet")) onNet = res["onNet"];
          if (res.containsKey("status")) status = res["status"];

          if (status == "0") {
            if (onNet) {
              iVerifyMsisdn!.onVerifyMsisdnSuccess(context!);
            } else {
              iVerifyMsisdn!.onVerifyMsisdnFailed(AppStringValidation.invalidnumber);
            }
          } else {
            iVerifyMsisdn!.onVerifyMsisdnFailed(description);
          }
        } catch (e) {
          print(e);

          if (response != null && response.isNotEmpty) {
            iVerifyMsisdn!.onVerifyMsisdnFailed(response);
          } else {
            iVerifyMsisdn!.onVerifyMsisdnFailed(e.toString());
          }
        }

        break;
      case 1:
        iVerifyMsisdn!.onVerifyMsisdnFailed(AppStringValidation.msisdnRequired);
        break;
    }
  }
}

class VerifyMobileNumberModel {
  String token;
  String message;
  String msisdn;

  VerifyMobileNumberModel(this.token, this.message, this.msisdn);

  Map<String, dynamic> getParameters(BuildContext context, bool isEncrypted) {
    // Your parameter generation logic here
    return {}; // Replace with your parameters
  }
}
