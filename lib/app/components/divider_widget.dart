import 'package:flutter/material.dart';

Widget bottomSheetDivider() {
  return Center(
    child: FractionallySizedBox(
      widthFactor: 0.2,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6.0),
        child: Container(
          height: 5.0,
          decoration: const BoxDecoration(
            color: Colors.white, // color of top divider bar
            borderRadius: BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    ),
  );
}
