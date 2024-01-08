// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class InfoAlertDialog {
  static void progressAlertDialog(BuildContext context, String progressMessage) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Warning"),
        content: const Text(
          "Merci d’avoir installé l’application FLOOZ de MOOV. Pour continuer, veuillez insérer la carte SIM associée à votre compte Flooz.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: const Text(
                "Dismiss",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
