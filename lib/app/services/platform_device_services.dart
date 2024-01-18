import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class DevicePlatformServices extends GetxController {
  String deviceID = '';
  String channelID = '';
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  initPlatform() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceID = androidDeviceInfo.id;
      channelID = "app-android";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor!.toString();
      channelID = "app-ios";
    }
  }

  @override
  void onInit() {
    initPlatform();
    super.onInit();
  }
}
