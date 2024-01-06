// // ignore_for_file: constant_identifier_names, avoid_print

// import 'dart:convert';

// class BaseService {
//   late Map<String, String> defaultHeader;
//   late String commandId;

//   BaseService() {
//     defaultHeader = {
//       'Authorization': Obfuscate.aesDecoder(hexDecode(BuildConfig.KYC_AUTH) as String),
//       'Content-Type': 'application/json',
//     };
//   }

//   static String generateRequestId(String uid) {
//     return '$uid${DateTime.now().millisecondsSinceEpoch}';
//   }

//   void request({
//     required OnResponseListener onResponseListener,
//   }) {
//     // Implement your request logic here
//     bool start = onResponseListener.onStart();
//     if (start) {
//       // Perform the request and handle the response
//       try {
//         // Simulating a successful response for demonstration purposes
//         onResponseListener.onSuccess('Sample response');
//       } catch (error) {
//         // Simulating a failure response for demonstration purposes
//         onResponseListener.onFailed(ResponseMessage('Sample error message'));
//       }
//     }
//   }
// }

// class ResponseMessage {
//   final String errorMessage;

//   ResponseMessage(this.errorMessage);
// }

// abstract class OnResponseListener {
//   bool onStart();

//   void onSuccess(Object response);

//   void onFailed(ResponseMessage responseMessage);
// }

// class Obfuscate {
//   static String aesDecoder(String data) {
//     // Implement your AES decoding logic here
//     return data;
//   }
// }

// List<int> hexDecode(String input) {
//   // Implement your hex decoding logic here
//   return utf8.encode(input);
// }

// class BuildConfig {
//   // Replace with your actual KYC_AUTH value
//   static const String KYC_AUTH = '%s%s';
// }

// void main() {
//   // Example usage
//   BaseService().request(
//     onResponseListener: CustomResponseListener(),
//   );
// }

// class CustomResponseListener implements OnResponseListener {
//   @override
//   bool onStart() {
//     print('Request started');
//     return true;
//   }

//   @override
//   void onSuccess(Object response) {
//     print('Request successful. Response: $response');
//   }

//   @override
//   void onFailed(ResponseMessage responseMessage) {
//     print('Request failed. Error: ${responseMessage.errorMessage}');
//   }
// }
