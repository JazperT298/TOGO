import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  RxBool isLastPage = false.obs;
  RxBool isLoading = false.obs;
  RxInt pageCount = 0.obs;
  final Duration animationDuration = .3.seconds;
  final Curve animationCurve = Curves.decelerate;
  late final PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void toNextPage() {
    if (pageCount.value != 2) {
      pageController.nextPage(
          duration: animationDuration, curve: animationCurve);
      pageCount.value++;
      // print(pageCount.value);
    } else {
      isLastPage.value = true;
    }
  }
}
