import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/utils/string_utils.dart';

abstract class IRequestOTPModel {
  String getMessage();

  String getMsisdn();

  Map<String, dynamic> getParameters(BuildContext context, bool isEncrypted);

  Map<String, dynamic> getParametersWithSms(BuildContext context, bool isEncrypted, bool sendsms);

  int validateData();
}

class RequestOTPModel implements IRequestOTPModel {
  final String _message;
  final String _msisdn;

  RequestOTPModel(this._message, this._msisdn);

  @override
  String getMessage() {
    return _message;
  }

  @override
  String getMsisdn() {
    return _msisdn;
  }

  @override
  Map<String, dynamic> getParameters(BuildContext context, bool isEncrypted) {
    final Map<String, dynamic> parameters = <String, dynamic>{};
    parameters.assign("msisdn", getMsisdn());
    if (isEncrypted) {
      // parameters.assign("message", EncryptionHelper.encryptData(context, getMessage()));
    } else {
      parameters.assign("message", getMessage());
      parameters.assign("token", SqlHelper.getToken()); //"1234567890"
      parameters.assign("sendsms", "true");
    }
    return parameters;
  }

  @override
  Map<String, dynamic> getParametersWithSms(BuildContext context, bool isEncrypted, bool sendsms) {
    final Map<String, dynamic> parameters = <String, dynamic>{};
    parameters.assign("msisdn", getMsisdn());

    if (isEncrypted) {
      // parameters.assign("message", EncryptionHelper.encryptData(context, getMessage()));
    } else {
      parameters.assign("message", getMessage());
    }

    parameters.assign("token", SqlHelper.getToken()); //"1234567890"

    if (sendsms) {
      parameters.assign("sendsms", "true");
    } else {
      parameters.assign("sendsms", "false");
    }

    return parameters;
  }

  @override
  int validateData() {
    if (StringUtil().isNullOrEmpty(getMsisdn()) || getMsisdn().length < 8) {
      return 1;
    } else {
      return 0;
    }
  }
}
