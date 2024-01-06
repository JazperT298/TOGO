import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/ui/onboarding_screen_page.dart';
import 'package:ibank/app/modules/onboard/controller/onboard_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/ui/onboarding_pages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardView extends ConsumerStatefulWidget {
  const OnboardView({super.key});

  @override
  ConsumerState<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends ConsumerState<OnboardView> {
  final controller = Get.put(OnboardController());

  late PageController pageController;
  final Duration animationDuration = .3.seconds;
  final Curve animationCurve = Curves.decelerate;

  bool get onFirstPage => ref.read(currentPageProvider) == 0;
  bool get onLastPage => ref.read(currentPageProvider) == (onboardingScreenPage.length - 1);

  void getToAuthScreen() => Get.toNamed(AppRoutes.LOGIN); //KRouter.replace(context, Routes.loginNumber);

  void onPageChanged(int index) => ref.read(currentPageProvider.notifier).state = index;

  void toNextPage() {
    if (onLastPage) {
      getToAuthScreen();
    } else {
      pageController.nextPage(duration: animationDuration, curve: animationCurve);
    }
  }

  Future<bool> onNavigatingBack() {
    if (!onFirstPage) {
      pageController.previousPage(duration: animationDuration, curve: animationCurve);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(currentPageProvider);

    return WillPopScope(
      onWillPop: onNavigatingBack,
      child: FluScreen(
        overlayStyle: context.systemUiOverlayStyle.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        body: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: onboardingScreenPage.length,
                  itemBuilder: (context, index) => _Page(onboardingScreenPage[index]),
                ),
                Positioned(
                  top: 0,
                  right: UISettings.pagePaddingSize,
                  child: SafeArea(
                    bottom: false,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Hero(
                        tag: "<header_button>",
                        child: FluGlass(
                          intensity: 7.0,
                          cornerRadius: 14,
                          child: FluButton.text(
                            "Skip.",
                            onPressed: getToAuthScreen,
                            cornerRadius: 14,
                            backgroundColor: context.colorScheme.background.withOpacity(.25),
                            foregroundColor: Colors.white,
                            height: UISettings.minButtonSize - 5,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            FluButton.text(
              onboardingScreenPage[currentPage].buttonText,
              prefixIcon: onboardingScreenPage[currentPage].buttonIcon,
              iconStrokeWidth: 1.8,
              onPressed: toNextPage,
              height: UISettings.buttonSize,
              width: MediaQuery.of(context).size.width * .42,
              cornerRadius: UISettings.buttonCornerRadius,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .025, bottom: MediaQuery.of(context).size.height * .08),
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.onPrimary,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.primary.withOpacity(.35),
                  blurRadius: 25,
                  spreadRadius: 3,
                  offset: const Offset(0, 5),
                )
              ],
              textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .025),
              child: SmoothPageIndicator(
                controller: pageController,
                count: onboardingScreenPage.length,
                effect: WormEffect(
                  dotHeight: 5,
                  dotWidth: 5,
                  spacing: 10.0,
                  dotColor: context.colorScheme.surfaceVariant,
                  activeDotColor: context.colorScheme.onBackground,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Page extends GetView<OnboardController> {
  final OnboardingScreenPage data;

  const _Page(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FluImage(
            data.image,
            expand: true,
            overlayOpacity: .15,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: UISettings.pagePaddingSize).copyWith(top: MediaQuery.of(context).size.height * .035),
          child: Column(
            children: [
              Text(
                StringUtils(data.title).capitalizeFirst!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: M3FontSizes.headlineSmall,
                ),
              ),
              const SizedBox(height: 5),
              Text(data.description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }
}

final currentPageProvider = StateProvider.autoDispose<int>((ref) => 0);
