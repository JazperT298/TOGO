import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class IVerifyMobileNumberModel {
  String getToken();

  String getMessage();

  String getMsisdn();

  Map<String, dynamic> getParameters(BuildContext context, bool isEncrypted);
}

class VerifyMobileNumberModel implements IVerifyMobileNumberModel {
  final String _token;
  final String _message;
  final String _msisdn;

  VerifyMobileNumberModel(this._token, this._message, this._msisdn);

  @override
  String getToken() {
    return _token;
  }

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
      parameters.assign("token", getToken());
      parameters.assign("sendsms", "true");
    }

    return parameters;
  }
}
