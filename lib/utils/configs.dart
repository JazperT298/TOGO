import 'package:flutter/rendering.dart';

class Configs {
  static String get appName => "flooz";
}

class UISettings {
  static const double pagePaddingSize = 25;
  static const EdgeInsets pagePadding =
      EdgeInsets.symmetric(horizontal: pagePaddingSize);

  static const double buttonSize = 65;
  static const double buttonCornerRadius = 24;
  static const double minButtonSize = 52;
  static const double minButtonCornerRadius = 20;
}
