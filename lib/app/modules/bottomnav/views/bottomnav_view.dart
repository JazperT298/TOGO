import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/bottomnav/controller/bottomnav_controller.dart';
import 'package:ibank/app/modules/history/views/history_view.dart';
import 'package:ibank/app/modules/home/views/home_view.dart';
import 'package:ibank/app/modules/profile/views/profile_view.dart';
import 'package:ibank/app/modules/shop/views/shop_view.dart';
import 'package:ibank/utils/configs.dart';

import '../../home/controller/home_controller.dart';

final currentPageProvider = StateProvider.autoDispose<int>((ref) => 0);

class BottomNavView extends ConsumerStatefulWidget {
  const BottomNavView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends ConsumerState<BottomNavView> {
  final contoller = Get.put(BottomNavController());
  late final PageController pageController;

  void onPageChange(int index) {
    ref.read(currentPageProvider.notifier).state = index;
    pageController.animateToPage(index,
        duration: 300.milliseconds, curve: Curves.decelerate);
  }

  @override
  void initState() {
    pageController = PageController();
    Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeView(),
          HistoryView(),
          ShopView(),
          ProfileView(),
        ],
      ),
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      bottomNavigationBar: Container(
        margin: UISettings.pagePadding,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: FluBottomNavBar(
          onItemTap: onPageChange,
          items: [
            FluBottomNavBarItem(FluIcons.home2, "home"),
            FluBottomNavBarItem(FluIcons.coin1, "history"),
            FluBottomNavBarItem(FluIcons.bag2, "shop"),
            FluBottomNavBarItem(FluIcons.more2, "profile"),
          ],
          style: FluBottomNavBarStyle(
            height: MediaQuery.of(context).size.height * .1,
            backgroundColor: Colors.black,
            foregroundColor: context.colorScheme.secondary.withOpacity(.85),
            unSelectedForegroundColor: context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

// import 'package:flukit/flukit.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ibank/app/modules/bottomnav/controller/bottomnav_controller.dart';
// import 'package:ibank/utils/configs.dart';

// class BottomNavView extends GetView<BottomNavController> {
//   const BottomNavView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Get.put(BottomNavController());
//     return FluScreen(
//       body: Obx(
//         () => PageView(
//           controller: controller.pageController.value,
//           physics: const NeverScrollableScrollPhysics(),
//           children: controller.bodyContent,
//         ),
//       ),
//       overlayStyle: context.systemUiOverlayStyle.copyWith(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//       ),
//       bottomNavigationBar: Obx(
//         () =>  Container(
//           margin: UISettings.pagePadding,
//           clipBehavior: Clip.antiAlias,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
//           child: FluBottomNavBar(
//             onItemTap: (index) => controller.selectedIndex.value = index,
//             items: controller.navItem,
//             style: FluBottomNavBarStyle(
//               height: MediaQuery.of(context).size.height * .1,
//               backgroundColor: Colors.black,
//               foregroundColor: context.colorScheme.secondary.withOpacity(.85),
//               unSelectedForegroundColor: context.colorScheme.onPrimary,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
