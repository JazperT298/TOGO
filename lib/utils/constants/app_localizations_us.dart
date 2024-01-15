import 'package:flutter/material.dart';
import 'package:ibank/utils/configs.dart';

class AppLocalizationsEn {
  static final Map<String, String> _localizedStrings = {
    'title': Configs.appName,
    // Add more key-value pairs for English
  };

  static String translate(BuildContext context, String key) {
    return _localizedStrings[key] ?? key;
  }
}
