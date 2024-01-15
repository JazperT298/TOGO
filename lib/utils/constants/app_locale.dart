import 'package:flutter/material.dart';
import 'package:ibank/utils/constants/app_localizations_fr.dart';
import 'package:ibank/utils/constants/app_localizations_us.dart';

class AppLocalizations {
  static const supportedLocales = [Locale('en', 'US'), Locale('fr', 'FR')];

  static String translate(BuildContext context, String key) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'en':
        return AppLocalizationsEn.translate(context, key);
      default:
        //default language is fr = french
        return AppLocalizationsFr.translate(context, key);
    }
  }
}
