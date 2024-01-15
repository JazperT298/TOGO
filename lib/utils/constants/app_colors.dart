import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF1651E7);
  static const Color secondaryColor = Color(0xFFFC6C29);
  static const Color tertiaryColor = Color(0xFFe0fe55);
  static const Color bodyColor = Color(0xFF627694);
  static const Color displayColor = Color(0xFF2A333F);
  static const Color darkBodyColor = Color(0xFF627694);
  static const Color darkDisplayColor = Color(0xFF2A333F);
  static const Color selectCountriesColor = Color(0xFFFB6404);

  static Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
