// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:ibank/app/data/local/sql_helper.dart';

class MessageHandler {
  static const String SOURCE_INBOX = "inbox";
  static const String SOURCE_SOAP = "soap";
  static const String SOURCE_SMS = "sms";
  static List<Type> classObj = [];
  static bool matched = false;
  static List<Handler> handlers = [
    // EulaOTAHandler(),
    // Add other handlers as needed
  ];
  static Object sync = Object();
  static String message = "";
  static String source = "";
  static String sender = "";

  static bool hasMatch() {
    return matched;
  }

  static Future<bool> parseMessage(Message msg) async {
    matched = await parseMessageInternal(msg);
    return matched;
  }

  static Future<bool> parseMessageInternal(Message msg) async {
    //String timestamp = SqlHelper.getCurrentDate(msg.getCtx()).millisecondsSinceEpoch.toString();
    () {
      if (msg.source != source && msg.msg == message) {
        msg.msg = "";
        return true;
      }
      message = msg.msg;
      source = msg.source;
    };

    for (Handler handler in handlers) {
      if (await handler.parseMessage(msg)) return true;
    }
    SqlHelper.setMessage(msg.msg);
    return false;
  }

  static void initObjHandler(Type cls) {
    classObj = [cls];
  }
}

abstract class Handler {
  Future<bool> parseMessage(Message msg);
}

class Message {
  late dynamic ctx;
  late String msg;
  late String source;

  Message(this.ctx, this.msg);

  Message.withSource(this.ctx, this.msg, this.source);
}
