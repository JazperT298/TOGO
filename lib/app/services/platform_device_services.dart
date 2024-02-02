import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class DevicePlatformServices extends GetxController {
  String deviceID = '';
  String channelID = '';
  String deviceType = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  initPlatform() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceID = androidDeviceInfo.id;
      channelID = "ANDROIDAPP"; // "app-android";
      deviceType = "ANDROID";
      log('ANDROID $channelID deviceID $deviceID');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor!.toString();
      channelID = "ANDROIDAPP"; //-->  change to this is IOS will be avaiable channelID = "IOSAPP"; // "app-ios";
      deviceType = "ANDROID"; //-->  change to this is IOS will be avaiable deviceType = "IOS";
      log('IOS $channelID deviceID $deviceID');
    }
  }

  @override
  void onInit() {
    initPlatform();
    super.onInit();
  }
}
