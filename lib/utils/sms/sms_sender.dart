// ignore_for_file: constant_identifier_names, non_constant_identifier_names, unnecessary_null_comparison, prefer_if_null_operators, unused_local_variable, unused_import, avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import 'package:ibank/utils/sms/sms_listener.dart';
import 'package:ibank/utils/sms/sms_option_enum.dart';
import 'package:ibank/utils/string_utils.dart';
import 'package:telephony/telephony.dart';
import 'package:xor_cipher/xor_cipher.dart';

class SmsSenders {
  SendSmsListener smsListener;
  SmsSenders(this.smsListener);
  static const int SMS_TIMEOUT = 30000; //90000;
  static const String SENT = "SMS_SENT";
  static const String DELIVERED = "SMS_DELIVERED";

  // shortcode = "155" (Live)
  // shortcode = "150" TEST

  static const String short_code = "150";
  static const String smsc = "";

  static void sendSms(BuildContext ctx, String message, SmsOption option, SendSmsListener listener, String progressMessage) {
    sendSms2(ctx, message, "", option, progressMessage);
  }

  static void sendSms2(BuildContext context, String message, String destination, final SmsOption option, String progressMessage) {
    final String progressWaitingSent;
    final Object sync = Object();
    final String progressWaitingToDelivered;
    final String progressWaitingToRespond;
    sendEncryptedSms(message);
    // SendSmsListeners sendSmsListeners = SendSmsListeners();
    // if (progressMessage == null || progressMessage.isEmpty || StringUtils().isNullOrEmpty(progressMessage[0])) {
    //   progressWaitingSent = AppStrings.smsprogress;
    // } else {
    //   progressWaitingSent = progressMessage[0];
    // }
    // if (progressMessage == null || progressMessage.length < 2 || StringUtils().isNullOrEmpty(progressMessage[1])) {
    //   progressWaitingToDelivered = AppStrings.smsprogress;
    // } else {
    //   progressWaitingToDelivered = progressMessage[1];
    // }

    // if (progressMessage == null || progressMessage.length < 3 || StringUtils().isNullOrEmpty(progressMessage[2])) {
    //   progressWaitingToRespond = AppStrings.smsprogress;
    // } else {
    //   progressWaitingToRespond = progressMessage[2];
    // }
    // if (StringUtils().isNullOrEmpty(destination)) {
    //   destination = short_code;
    // }
    // if (sendSmsListeners == null || !sendSmsListeners.onResponse("", message)) {
    //   sendSmsListeners.onResponse('', message);
    // }
    // final SmsOption smsOption = option != null ? option : SmsOption.HIDDEN;
    // final broadcastRx = BroadcastReceivers();
    // if (smsOption != SmsOption.HIDDEN) {
    //   ProgressAlertDialog.progressAlertDialog(context, progressWaitingSent);
    // } else {
    //   null;
    // }

    // sendSmsListeners.onDelivered();
  }

  static Future<void> sendEncryptedSms(String encryptedMessage) async {
    // Simulating the encryption process (replace it with your actual encryption logic)
    print("hits: $encryptedMessage");
    Iterable<int> encryptedMessages = xor(encryptedMessage);

    print('encryptedMessages 1 $encryptedMessages');

    List<int> encryptedMessageList = encryptedMessages.toList();
    Uint8List byte = Uint8List.fromList(encryptedMessageList);
    print('encryptedMessages 2 $byte');
    Uint8List mess = Uint8List.fromList(utf8.encode(encryptedMessage));
    try {
      var ger = await RSA.generate(2048);

      Uint8List bytes = Uint8List.fromList(utf8.encode(ger.publicKey));

      String base64PublicKey = base64Encode(bytes);

      debugPrint('encryptedMessages 3aa ${ger.publicKey}');

      print('encryptedMessages 3ss $base64PublicKey');
      var result = await RSA.encryptPKCS1v15Bytes(mess, ger.publicKey);
      String asd = base64Encode(result);
      print('encryptedMessages 3b $result');
      print('encryptedMessages 3ss $asd');
    } on RSAException catch (_, ex) {
      print('encryptedMessages 4 $ex');
    }

    // Send SMS
    final Telephony telephony = Telephony.instance;
    const String recipients = "recipientPhoneNumber";

    telephony.sendSms(
      to: '22879397111',
      message: encryptedMessageList.toString(),
      statusListener: (SendStatus status) {
        // Handle the status of sent messages here
        print("Status: ${status.toString()}");
      },
    );
    // SmsManager smsManager = SmsManager.getDefault();

    // List<String> messages = smsManager.divideMessage(encryptedMessageList.toString());

    // Simulating the count of sent and delivered messages
    int messagesCount = recipients.length;

    final int countSent = messagesCount;
    final int countDelv = messagesCount;

    print("Count of Sent Messages: $countSent");
    print("Count of Delivered Messages: $countDelv");
  }

  static Iterable<int> xor(String value) {
    final List<int> bytes = utf8.encode(value);
    final bytesLength = bytes.length;
    Iterable<int> innerEncrypt() sync* {
      for (var i = 0; i < bytesLength; i++) {
        yield bytes[i] ^ 135;
      }
    }

    return innerEncrypt();
  }

  String xorEncrypted(String source, String secret) {
    final encrypted = XOR.encrypt(source, secret, urlEncode: false);
    print('Encrypted: $encrypted');
    return encrypted;
  }

  String xorDecrypt(String encrypted, String secret) {
    final decrypted = XOR.decrypt(encrypted, secret, urlDecode: false);
    print('Encrypted: $encrypted');
    return decrypted;
  }

  List<String> divideMessage(String text) {
    throw Exception("Stub!");
  }
}
