import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/line_separator.dart';
import 'package:ibank/utils/constants/app_global.dart';

class HistoryDialog {
  static void showHistoryDialog(context, message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object

        return AlertDialog(
          insetPadding: const EdgeInsets.all(12), // Outside Padding
          contentPadding: const EdgeInsets.all(12), // Content Padding
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Center(child: Text(message))),
        );
      },
    );
  }

  static showMessageDialog({required String message}) async {
    Get.dialog(AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          color: Colors.white,
          child: Flexible(
            child: Text(message),
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     const Text(
          //       "Message",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 15,
          //       ),
          //     ),
          //     SizedBox(
          //       height: MediaQuery.of(Get.context!).size.height * 0.032,
          //     ),
          //     Text(
          //       message,
          //       textAlign: TextAlign.center,
          //       style: const TextStyle(
          //           fontWeight: FontWeight.normal, fontSize: 12),
          //     ),
          //   ],
          // ),
        )));
  }
}
