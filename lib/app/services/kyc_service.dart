// import 'package:get/get_connect/connect.dart';
// import 'package:ibank/services/base_service.dart';

// class KYCService extends BaseService {
//   final GetConnect connect;
//   KYCService(String baseUrl, {required this.connect}) : super();
//   Future<void> verifyMsisdn(KYCInquiryRequest request, OnResponseListener listener) async {
//     if (!listener.onStart()) return;
//     defaultHeader = {'command-id': request.commandId};
//     String verifyMsisdnUrl = '${baseUrl}gatewayprod/8ctRjbhxpq9L37V3nPRR';
//     try {
//       Response response = await connect.post(
//         verifyMsisdnUrl,
//         headers: headers,
//         request.toJson(),
//       );
//       return _parseWithGetXResponse<KYCInquiryResponse>(response: response.bodyString);
//     } catch (ex) {
//       rethrow;
//     }
//   }
// }
