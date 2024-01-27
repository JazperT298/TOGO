import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/local/getstorage_services.dart';
import 'package:ibank/app/modules/history/views/history_view.dart';
import 'package:ibank/app/modules/home/views/home_view.dart';
import 'package:ibank/app/modules/profile/views/profile_view.dart';
import 'package:ibank/app/modules/shop/views/shop_view.dart';
import 'package:ibank/utils/constants/app_global.dart';

class BottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final pageController = PageController().obs;
  RxBool isLoading = false.obs;

  List<Widget> bodyContent = [
    const HomeView(),
    const HistoryView(),
    const ShopView(),
    const ProfileView(),
  ];

  List<FluBottomNavBarItem> navItem = [
    FluBottomNavBarItem(FluIcons.home2, "home"),
    FluBottomNavBarItem(FluIcons.coin1, "history"),
    FluBottomNavBarItem(FluIcons.bag2, "shop"),
    FluBottomNavBarItem(FluIcons.more2, "profile"),
  ];

  @override
  void onInit() {
    pageController.value = PageController();
    //getDataFromStorage();
    super.onInit();
  }

  void getDataFromStorage() async {
    AppGlobal.MSISDN = Get.find<StorageServices>().storage.read('msisdn');
    AppGlobal.TOKEN = Get.find<StorageServices>().storage.read('token');

    if (Get.find<StorageServices>().storage.read('language') != null) {
      String enLang = await Get.find<StorageServices>().storage.read('language');
      await Get.updateLocale(Locale(enLang.toLowerCase()));
      AppGlobal.isSelectFrench = enLang == "FR" ? true : false;
      AppGlobal.isSelectEnglish = enLang == "EN" ? true : false;
    } else {
      await Get.find<StorageServices>().saveLanguage(language: 'EN');
      String enLang = await Get.find<StorageServices>().storage.read('language');
      await Get.updateLocale(Locale(enLang.toLowerCase()));
      AppGlobal.isSelectFrench = enLang == "FR" ? true : false;
      AppGlobal.isSelectEnglish = enLang == "EN" ? true : false;
    }

    if (Get.find<StorageServices>().storage.read('imageFile') != null) {
      AppGlobal.PROFILEIMAGE = Get.find<StorageServices>().storage.read('imageFile');
    }
    if (Get.find<StorageServices>().storage.read('image') != null) {
      AppGlobal.PROFILEAVATAR = Get.find<StorageServices>().storage.read('image');
    }
    if (Get.find<StorageServices>().storage.read('biometrics') != null) {
      AppGlobal.BIOMETRICS = Get.find<StorageServices>().storage.read('biometrics');
    }
  }
}
