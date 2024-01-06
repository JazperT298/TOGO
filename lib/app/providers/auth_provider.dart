//Api Call here for login, changes pass etc..
// ignore_for_file: unnecessary_null_comparison, avoid_print, deprecated_member_use

import 'dart:convert';

import 'package:get/get.dart';
import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/data/request/kyc_inquiry_request.dart';
import 'package:ibank/app/data/response/base_response.dart';
import 'package:ibank/app/data/response/verification_response.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/constants/sys_prop.dart';
import 'package:xml/xml.dart' as xml;

class AuthProvider {
  static final connect = GetConnect();

  static String generateRequestId(String uid) {
    return '${uid.toString()}${DateTime.now().millisecondsSinceEpoch}';
  }

  static Future<VerificationResponse> verifyMsisdn(String msisdn) async {
    try {
      String stringProperty = await SqlHelper.getProperty(SysProp.PROP_MSISDN, msisdn);
      print('AuthService stringProperty 07 $stringProperty');
      String genRequestId = generateRequestId(stringProperty);
      print('AuthService genRequestId 07 $genRequestId');
      KYCInquiryRequest request = KYCInquiryRequest(commandId: 'kycinquiry', requestId: 'INQ-$genRequestId', destination: '22879397111');

      if (request != null) {
        String verifyMsisdnUrl = 'https://flooznfctest.moov-africa.tg/kyctest/inquiry';
        Map<String, String> defaultHeader = {'command-id': request.commandId};
        var response = await connect.post(
          verifyMsisdnUrl,
          headers: defaultHeader,
          jsonEncode(KYCInquiryRequest(requestId: request.requestId, commandId: request.commandId, destination: request.destination)),
        );
        return VerificationResponse.fromJson(jsonDecode(response.bodyString!));
      } else {
        AppGlobal.isSendVerificationLoading = false;
        print('AuthService verifyMsisdn 06 FAILED');
        throw Exception("ApiRepository Initialization Not Found");
      }
    } catch (ex) {
      print('AuthService verifyMsisdn 06 $ex');
      rethrow;
    }
  }

  static Future<VerificationResponse> sendVerification(String msisdn) async {
    try {
      AppGlobal.isSendVerificationLoading = true;
      String stringProperty = await SqlHelper.getProperty(SysProp.PROP_MSISDN, msisdn);
      String genRequestId = generateRequestId(stringProperty);
      KYCInquiryRequest request = KYCInquiryRequest(commandId: 'kycinquiry', requestId: 'INQ-$genRequestId', destination: '22879397112');

      if (request != null) {
        String verifyMsisdnUrl = 'https://flooznfctest.moov-africa.tg/kyctest/inquiry';
        Map<String, String> defaultHeader = {'command-id': request.commandId};
        var response = await connect.post(
          verifyMsisdnUrl,
          headers: defaultHeader,
          jsonEncode(KYCInquiryRequest(requestId: request.requestId, commandId: request.commandId, destination: request.destination)),
        );
        print('response ${response.bodyString}');
        return VerificationResponse.fromJson(jsonDecode(response.bodyString!));
      } else {
        AppGlobal.isSendVerificationLoading = false;
        print('AuthService sendVerification 06 FAILED');
        throw Exception("ApiRepository Initialization Not Found");
      }
    } catch (e) {
      AppGlobal.isSendVerificationLoading = false;
      print('AuthService sendVerification 07 $e');
      rethrow;
    }
  }

  static Map<String, dynamic> parseSoapResponseToJson(String soapResponse) {
    var document = xml.XmlDocument.parse(soapResponse);
    var soapBody = document.findAllElements('soapenv:Body').single;
    var requestTokenResponse = soapBody.findAllElements('ns1:RequestTokenResponse').single;
    var requestTokenReturn = requestTokenResponse.findAllElements('RequestTokenReturn').single;

    var jsonString = requestTokenReturn.text;

    // Replace HTML entities
    jsonString = jsonString.replaceAll('&quot;', '"');

    // Convert to JSON
    Map<String, dynamic> json = jsonDecode(jsonString);
    print('resposne $json');
    return json;
  }

  static Future<BaseResponse<T>> parseWithGetXResponse<T>({required String? response}) async {
    if (response != null) {
      print('res 2 ${BaseResponse<T>.fromJson(jsonDecode(response))}');
      return BaseResponse<T>.fromJson(jsonDecode(response));
    } else {
      print('res 3');
      throw Exception("strNoInternet".tr);
    }
  }
}
