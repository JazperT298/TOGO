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
    // TODO: implement onInit
    pageController.value = PageController();
    AppGlobal.MSISDN = Get.find<StorageServices>().storage.read('msisdn');
    AppGlobal.TOKEN = Get.find<StorageServices>().storage.read('token');

    super.onInit();
  }
}
