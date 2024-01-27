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

  //Store verify profile
  saveVerifyProfile({required String profile, required String description, required String message, required String status}) {
    storage.write('profile', profile);
    storage.write('description', description);
    storage.write('message', message);
    storage.write('status', status);
  }

  saveUserData(
      {required String name,
      required String firstname,
      required String msisdn,
      required String birthdate,
      required String soldeFlooz,
      required String commission}) {
    storage.write('name', name);
    storage.write('firstname', firstname);
    storage.write('msisdn', msisdn);
    storage.write('birthdate', birthdate);
    storage.write('soldeFlooz', soldeFlooz);
    storage.write('commission', commission);
  }

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
