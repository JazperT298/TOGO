import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:sizer/sizer.dart';

class ProgressAlertDialog {
  static Timer? timer;
  static void progressAlertDialog(BuildContext context, String progressMessage) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16.0),
            Text(
              progressMessage,
              style: TextStyle(fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }

  static void loadingAlertDialog(BuildContext context, String progressMessage) {
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          timer = Timer(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });

          return AlertDialog(
            content: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16.0),
                Text(
                  progressMessage,
                  style: TextStyle(fontSize: 11.sp),
                ),
              ],
            ),
          );
        }).then((value) {
      if (timer!.isActive) {
        timer!.cancel();
      }
    });
  }

  static void showALoadingDialog(BuildContext context, String progressMessage, int seconds, String nextPage) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16.0),
              Text(
                progressMessage,
                style: TextStyle(fontSize: 11.sp),
              ),
            ],
          ),
        );
      },
    );

    // Delay for 3 seconds
    await Future.delayed(Duration(seconds: seconds), () {
      Navigator.of(context).pop(); // Close the alert dialog

      // Navigate to the next page
      Get.toNamed(nextPage);
    });
  }

  static void showALoadingDialog2(BuildContext context, String progressMessage, int seconds, bool isInvalidCode) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16.0),
              Text(
                progressMessage,
                style: TextStyle(fontSize: 11.sp),
              ),
            ],
          ),
        );
      },
    );

    // Delay for 3 seconds
    await Future.delayed(Duration(seconds: seconds), () {
      Navigator.of(context).pop(); // Close the alert dialog

      print('isInvalidCode $isInvalidCode');
      if (isInvalidCode == false) {
        Get.toNamed(AppRoutes.TRANSACCOMPLETE);
      }
    });
  }
}
