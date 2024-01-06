// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

class BroadcastReceivers {
  late Timer timeout;
  late Function(dynamic)? sentReceiver;
  late Function(dynamic)? delvReceiver;
  late Function(dynamic)? respReceiver;
  late AlertDialog progress;

  void unRegisterAll(BuildContext ctx) {
    unRegisterSent(ctx);
    unRegisterDelv(ctx);
    unRegisterResp(ctx);
    unRegisterSent(ctx);
    unRegisterTimeout();
    dismissProgress(ctx);
  }

  void unRegisterSent(BuildContext ctx) {
    if (sentReceiver != null) {
      try {
        // Implement your unregister logic for sentReceiver
        // ctx.unregisterReceiver(sentReceiver);
      } catch (e) {
        print(e);
      }
      sentReceiver = null;
    }
  }

  void unRegisterDelv(BuildContext ctx) {
    if (delvReceiver != null) {
      try {
        // Implement your unregister logic for delvReceiver
      } catch (e) {
        print(e);
      }
      delvReceiver = null;
    }
  }

  void unRegisterResp(BuildContext ctx) {
    if (respReceiver != null) {
      try {
        // Implement your unregister logic for respReceiver
      } catch (e) {
        print(e);
      }
      respReceiver = null;
    }
  }

  void unRegisterTimeout() {
    if (timeout != null) {
      timeout.cancel();
      timeout = Timer(Duration.zero, () {});
    }
  }

  void dismissProgress(BuildContext ctx) {
    if (progress == null) return;
    try {
      showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Dismiss Progress"),
            content: Text("Progress dismissed."),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void updateProgress(BuildContext ctx, String message) {
    if (progress == null) return;
    try {
      showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update Progress"),
            content: Text("Progress updated: $message"),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
