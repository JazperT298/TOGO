//Api Call here for transaction

// ignore_for_file: constant_identifier_names, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ibank/app/components/progress_dialog.dart';
import 'package:ibank/app/providers/auth_provider.dart';
import 'package:ibank/utils/common/parser_validator.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:ibank/utils/constants/app_string_confirmation.dart';
import 'package:ibank/utils/constants/app_string_validation.dart';
import 'package:ibank/utils/string_utils.dart';

enum NetState { OFFNET, ONNET }

enum FieldType { NORMAL, PHONEBOOK }

class TransactionProvider {
  static bool isLoading = false;
  static final message = StringBuffer();
  static final notifymessage = StringBuffer();

  static FieldType? fieldtype;

  static void onSendMoneySubmit(
      TextEditingController numberEditingController, TextEditingController amountEditingController, BuildContext context) async {
    try {
      String msisdn = "";
      print('onSendMoneySubmit AppGlobal.phonenumberspan  ${AppGlobal.phonenumberspan}');
      if (AppGlobal.phonenumberspan != null) {
        // List<dynamic> url = AppGlobal.phonenumberspan.getSpans(0, AppGlobal.phonenumberspan.length) as List<dynamic>;
        msisdn = AppGlobal.phonenumberspan;
        //url[0].url;
        fieldtype = FieldType.PHONEBOOK;
      } else {
        //assign receivers number
        msisdn = numberEditingController.text.replaceAll(" ", "");

        fieldtype = FieldType.NORMAL;
      }
      print('onSendMoneySubmit fieldtype $fieldtype');
      print('onSendMoneySubmit fieldtype $msisdn');
      //msisdn = verifyMsisdn(msisdn);
      msisdn = ParserValidator.validateMsisdn("228", msisdn, context);
      print('onSendMoneySubmit msisdn $msisdn');

      if (StringUtils().isNullOrEmpty(msisdn)) {
        showToast(context, AppStringValidation.destinationRequired);
        print('onSendMoneySubmit fieldtype ${AppStringValidation.destinationRequired}}');
        return;
      }
      if (AppGlobal.isEditedTransferNational) {
        var res = await AuthProvider.sendVerification(msisdn);
        if (res.extendedData.issubscribed && AppGlobal.isOtherNetTransferNational) {
          AppGlobal.isEditedTransferNational = false;
        } else if (res.extendedData.issubscribed && !AppGlobal.isOtherNetTransferNational) {
          AppGlobal.isEditedTransferNational = false;
        } else if (!res.extendedData.issubscribed && !AppGlobal.isOtherNetTransferNational) {
          AppGlobal.isEditedTransferNational = false;
        } else if (!res.extendedData.issubscribed && AppGlobal.isOtherNetTransferNational) {
          AppGlobal.isEditedTransferNational = false;
        } else {
          showToast(context, AppStringValidation.destinationRequired);
        }
      } else {
        print('onSendMoneySubmit asd sulod dre 2');
        //assign amount
        // String? amount = ParserValidator.parseAmount2(amountEditingController, context);
        // print('onSendMoneySubmit amount $amount');
        if (StringUtils().isNullOrEmpty(amountEditingController.text)) return;

        if (AppGlobal.isSubscribedTransferNational & AppGlobal.isOtherNetTransferNational) {
          sendSoap(msisdn, amountEditingController.text, NetState.ONNET);
        } else if (AppGlobal.isSubscribedTransferNational & !AppGlobal.isOtherNetTransferNational) {
          sendSoap(msisdn, amountEditingController.text, NetState.ONNET);
        } else if (!AppGlobal.isSubscribedTransferNational & !AppGlobal.isOtherNetTransferNational) {
          sendSoap(msisdn, amountEditingController.text, NetState.ONNET);
        } else if (!AppGlobal.isSubscribedTransferNational & AppGlobal.isOtherNetTransferNational) {
          sendSoap(msisdn, amountEditingController.text, NetState.OFFNET);
        }
      }
    } catch (ex) {
      print('onSendMoneySubmit ex $ex');
    }
  }
  // Future<void> pickContact() async {
  //   try {
  //     final Contact contact = await ContactsService.openDeviceContactPicker();

  //     // Handle the picked contact data as needed
  //     if (contact != null) {
  //       print('Picked contact: ${contact.displayName}, ${contact.phones?.first.value}');
  //     } else {
  //       print('Contact picking canceled');
  //     }
  //   } on PlatformException catch (e) {
  //     print('Error picking contact: $e');
  //     _scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text('Error picking contact: $e'),
  //       duration: Duration(seconds: 2),
  //     ));
  //   }
  // }

  // static void sendVerification(String msisdn) async {
  //   try {
  //     AppGlobal.isSendVerificationLoading = true;
  //     KYCInquiryRequest request = KYCInquiryRequest(
  //         commandId: 'kycinquiry',
  //         requestId: 'INQ-${ApiRepositoryInstance.generateRequestId(SqlHelper.getProperty(SysProp.PROP_MSISDN, msisdn).toString())}',
  //         destination: '22879397111');
  //     print('sendVerification 00 ${request.requestId}');

  //     var response = AuthService().verifyMsisdn(request.toString());
  //     if (response != null) {
  //       AppGlobal.isSendVerificationLoading = false;
  //       KYCInquiryResponse kycInquiryResponse = response;
  //       // if (response.responseCode == 200 && response.responseData != null) {
  //       //   print('verifyMsisdn 00000 ${response.responseData}');
  //       //   return response.responseData!;
  //       // } else if (response.responseCode == 401) {
  //       //   print('verifyMsisdn 1 $response');
  //       //   throw Exception("401${response.responseMessage}");
  //       // } else {
  //       //   print('verifyMsisdn 2 $response');
  //       //   throw Exception(response.responseMessage);
  //       // }
  //     } else {
  //       AppGlobal.isSendVerificationLoading = false;
  //       print('sendVerification FAILED');
  //     }
  //   } catch (e) {
  //     AppGlobal.isSendVerificationLoading = false;
  //     print('sendVerification 33 $e');
  //     rethrow;
  //   }
  // }

  static void sendSoap(String msisdn, String amount, NetState state) {
    resetMessage();
    switch (state) {
      case NetState.OFFNET:
        // HITS: CASHOFF <msisdn> <amount> <password> F
        message
          ..write("CASHOFF")
          ..write(' ')
          ..write(msisdn)
          ..write(' ')
          ..write(amount)
          ..write(' ')
          ..write("<password/>")
          ..write(' ')
          ..write('F');
        print("HITS ${message.toString()}");
        break;

      case NetState.ONNET:
        // HITS: APPCASH <msisdn> <amount> <password> F
        message
          ..write("APPCASH")
          ..write(' ')
          ..write(msisdn)
          ..write(' ')
          ..write(amount)
          ..write(' ')
          ..write("<password/>")
          ..write(' ')
          ..write('F');
        print("HITS ${message.toString()}");
        break;
    }

    String confirm = "";
    switch (fieldtype) {
      case FieldType.NORMAL:
        confirm = AppStringConfirmation.confirmtransfertnationalmanual.replaceAll("<amount>", amount).replaceAll("<msisdn>", msisdn);

        break;
      case FieldType.PHONEBOOK:
        confirm = AppStringConfirmation.confirmtransfertnational
            .replaceAll("<amount>", amount)
            .replaceAll("<contactname>", StringUtils().setText(AppGlobal.addressBookDisplayName, AppGlobal.addressBookDisplayName, ""))
            .replaceAll("<msisdn>", msisdn);

        break;
      case null:
        break;
    }
    notifymessage.write(confirm);
  }

  void showProgressDialog(BuildContext context, String progressMessage) {
    if (isLoading == true) {
      ProgressAlertDialog.progressAlertDialog(context, progressMessage);
    } else {
      null;
    }
  }

  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static void resetMessage() {
    if (AppGlobal.message.length > 0) AppGlobal.message.write(AppGlobal.message.length);
    if (AppGlobal.notifymessage.length > 0) AppGlobal.notifymessage.write(AppGlobal.notifymessage.length);
    if (AppGlobal.shortcode.length > 0) AppGlobal.shortcode.write(AppGlobal.shortcode.length);
  }
}
