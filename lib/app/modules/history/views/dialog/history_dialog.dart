import 'package:flutter/material.dart';

class HistoryDialog {
  static void showHistoryDialog(context, history) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object

        return AlertDialog(
          insetPadding: const EdgeInsets.all(12), // Outside Padding
          contentPadding: const EdgeInsets.all(12), // Content Padding
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 60,
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                Center(
                  child: Text(history[0]['MESSAGE'].toString()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
