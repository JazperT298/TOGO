import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxService {
  //Instance of get storage
  final storage = GetStorage();

  //Instance of introduction
  final fresh = GetStorage('introduction');

  @override
  void onInit() {
    storage.writeIfNull('profile', "");
    super.onInit();
  }

  saveMsisdn({required String msisdn, required String formattedMSISDN}) {
    storage.write('msisdn', msisdn);
    storage.write('formattedMSISDN', formattedMSISDN);
  }

  saveOTP({required String otp}) {
    storage.write('otp', otp);
  }

  saveUserPIN({required String pin}) {
    storage.write('pin', pin);
  }

  saveProfileImageFromAvatar({required String image}) {
    storage.write('image', image);
  }

  saveProfileImageFromGallery({required String imageFile}) {
    storage.write('imageFile', imageFile);
  }

  saveBiometricsToStorage({required bool biometrics}) {
    storage.write('biometrics', biometrics);
  }

  saveLanguage({required String language}) {
    storage.write('language', language);
  }

  isPrivacyCheck({required bool isPrivacyCheck}) {
    storage.write('isPrivacyCheck', isPrivacyCheck);
  }

  isLoginSuccessClick({required bool isLoginSuccessClick}) {
    storage.write('isLoginSuccessClick', isLoginSuccessClick);
  }

  clearUserLocalData() {
    storage.remove('msisdn');
    storage.remove('formattedMSISDN');
    storage.remove('otp');
    storage.remove('pin');
    storage.remove('image');
    storage.remove('imageFile');
    storage.remove('biometrics');
    storage.remove('isPrivacyCheck');
    storage.remove('isLoginSuccessClick');
  }

  clearUsersInformation() {
    storage.remove('account');
    storage.remove('name');
    storage.remove('firstname');
    storage.remove('birthdate');
    storage.remove('soldeFlooz');
    storage.remove('commission');
    storage.remove('collecte');
    storage.remove('date');
    storage.remove('jusquau');
  }

  //Store verify profile
  saveVerifyProfile({required String profile, required String description, required String message, required String status}) {
    storage.write('profile', profile);
    storage.write('description', description);
    storage.write('message', message);
    storage.write('status', status);
  }

  saveUsersInformation(
      {required String account,
      required String name,
      required String firstname,
      required String birthdate,
      required String balance,
      required String commission,
      required String collecte,
      required String date,
      required String jusquau}) {
    storage.write('account', account);
    storage.write('name', name);
    storage.write('firstname', firstname);
    storage.write('birthdate', birthdate);
    storage.write('balance', balance);
    storage.write('commission', commission);
    storage.write('collecte', collecte);
    storage.write('date', date);
    storage.write('jusquau', jusquau);
  }

  String userAccount() => storage.read('account').toString();
  String userName() => storage.read('name').toString();
  String userFirstname() => storage.read('firstname').toString();
  String userBIrthdate() => storage.read('birthdate').toString();
  String userBalance() => storage.read('balance').toString();
  String userCommission() => storage.read('commission').toString();
  String userCollection() => storage.read('collecte').toString();
  String userDateLogin() => storage.read('date').toString();
  String userMessage() => storage.read('jusquau').toString();
  String userImage() => storage.read('imageFile').toString();
  String userAvatar() => storage.read('image').toString();

  setProperty({required int key, required String value}) {
    storage.write('key', key);
    storage.write('value', value);
  }

  setToken({required String token}) {
    storage.write('token', token);
  }

  saveHistoryTransaction({
    required String message,
    required String service,
  }) async {
    if (storage.read('history') == null) {
      List data = [];
      Map map = {"service": service, "message": message, "date": DateTime.now().toString()};
      data.add(map);
      storage.write("history", jsonEncode(data));

      log(storage.read('history'));
    } else {
      var stringdata = storage.read('history');
      var decodedData = jsonDecode(stringdata);
      Map map = {"service": service, "message": message, "date": DateTime.now().toString()};
      decodedData.add(map);
      storage.write("history", jsonEncode(decodedData));
      log(storage.read('history'));
    }
  }
}
