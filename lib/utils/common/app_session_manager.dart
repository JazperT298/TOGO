// ignore_for_file: constant_identifier_names, unnecessary_null_comparison, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSessionManager {
  static const String TAG = "AppSessionManager";

  late SharedPreferences _pref;
  late BuildContext context;

  static const int PRIVATE_MODE = 0;
  static const String PREF_NAME = "TGAppSession";

  static AppSessionManager? _mInstance;

  // Shared pref keys
  static const String IS_FIRST_INSTALL = "is-first-install";

  AppSessionManager._(BuildContext ctx) {
    context = ctx;
    SharedPreferences.getInstance().then((prefs) {
      _pref = prefs;
    });
    _mInstance = this;
  }

  static AppSessionManager newInstance(BuildContext ctx) {
    if (_mInstance == null) {
      _mInstance = AppSessionManager._(ctx);
      return _mInstance!;
    }
    return _mInstance!;
  }

  Future<bool> save() async {
    return _pref.commit();
  }

  void setFirstInstall(bool state) {
    _pref.setBool(IS_FIRST_INSTALL, state);
    save();
  }

  bool isFirstInstall() {
    try {
      if (_pref != null) {
        return _pref.getBool(IS_FIRST_INSTALL) ?? true;
      }
    } catch (ex) {
      print(ex);
      return false;
    }
    return false;
  }
}
