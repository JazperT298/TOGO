import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const _keyLoggedIn = 'logged_in';
  static const _keyUsername = 'username';
  static const _beneficiare = 'beneficiare';
  static const _numbers = 'numbers';
  static const _date = 'date';
  static const _amount = 'amount';
  static const _remainingBal = 'remainingBal';
  static const _txn = 'txn';

  static Future<void> saveLoginData(bool isLoggedIn, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, isLoggedIn);
    await prefs.setString(_keyUsername, username);
  }

  static Future<void> logoutUserData(bool isLoggedIn, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLoggedIn, isLoggedIn);
    await prefs.setString(_keyUsername, username);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLoggedIn) ?? false;
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) ?? '';
  }

  static Future<void> saveRecapnData(String beneficiare, String numbers, String date, String amount, String remainingBal, String txn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_beneficiare, beneficiare);
    await prefs.setString(_numbers, numbers);
    await prefs.setString(_date, date);
    await prefs.setString(_amount, amount);
    await prefs.setString(_remainingBal, remainingBal);
    await prefs.setString(_txn, txn);
  }

  static Future<String> getBeneficiare() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_beneficiare) ?? '';
  }

  static Future<String> getNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_numbers) ?? '';
  }

  static Future<String> getDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_date) ?? '';
  }

  static Future<String> getAmount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_amount) ?? '';
  }

  static Future<String> getRemainingBal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_remainingBal) ?? '';
  }

  static Future<String> getTxn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_txn) ?? '';
  }
}
