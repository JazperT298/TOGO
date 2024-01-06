//Api Call here forget user info, update etc...
// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:ibank/app/data/local/sql_helper.dart';
import 'package:ibank/app/data/request/kyc_inquiry_request.dart';
import 'package:ibank/app/providers/auth_provider.dart';
import 'package:ibank/utils/constants/sys_prop.dart';

class UserProvider {
  static String generateRequestId(String uid) {
    return '${uid.toString()}${DateTime.now().millisecondsSinceEpoch}';
  }

  static void verifyMsisdn(String msisdn) async {
    try {
      String stringProperty = await SqlHelper.getProperty(SysProp.PROP_MSISDN, msisdn);
      String genRequestId = generateRequestId(stringProperty);
      KYCInquiryRequest request = KYCInquiryRequest(commandId: 'kycinquiry', requestId: 'INQ-$genRequestId', destination: '22879397111');

      print('verifyMsisdn 00 ${request.requestId}');

      var baseResponse = AuthProvider.verifyMsisdn(request.toString());
      if (baseResponse != null) {
        print('verifyMsisdn 11 $baseResponse');
        // KYCInquiryResponse kycInquiryResponse = baseResponse.responseData;
        // print('verifyMsisdn 1 $kycInquiryResponse');
        // print('verifyMsisdn 2 ${kycInquiryResponse.extendedData.requestId}}');
      } else {
        print('verifyMsisdn FAILED');
      }
    } catch (e) {
      print('verifyMsisdn 33 $e');
      rethrow;
    }
  }
}
