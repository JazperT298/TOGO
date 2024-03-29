import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/data/ui/onboarding_screen_page.dart';
import 'package:ibank/app/modules/onboard/controller/onboard_controller.dart';
import 'package:ibank/app/routes/app_routes.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/configs.dart';
import 'package:ibank/utils/ui/onboarding_pages.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardView extends ConsumerStatefulWidget {
  const OnboardView({super.key});

  @override
  ConsumerState<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends ConsumerState<OnboardView> {
  final controller = Get.put(OnboardController());

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(currentPageProvider);

    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                // PageView.builder(
                //   controller: pageController,
                //   onPageChanged: onPageChanged,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: onboardingScreenPage.length,
                //   itemBuilder: (context, index) => _Page(onboardingScreenPage[index]),
                // ),
                PageView(
                  controller: controller.pageController,
                  children: [
                    _Page(onboardingScreenPage[0], false),
                    _Page(onboardingScreenPage[1], false),
                    _Page(onboardingScreenPage[2], true),
                  ],
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
                            LocaleKeys.strSkip.tr,
                            onPressed: () {
                              Get.offNamed(AppRoutes.LOGIN);
                            },
                            cornerRadius: 14,
                            backgroundColor: context.colorScheme.background.withOpacity(.25),
                            foregroundColor: Colors.white,
                            height: 5.8.h,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            Obx(
              () => controller.isLoading.value
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: FluButton.text(
                        onboardingScreenPage[currentPage].buttonText,
                        prefixIcon: onboardingScreenPage[currentPage].buttonIcon,
                        iconSize: 15,
                        iconStrokeWidth: 1.8,
                        onPressed: () {
                          controller.isLastPage.value ? Get.offNamed(AppRoutes.LOGIN) : controller.toNextPage();
                          // print(controller.isLastPage.value);
                        },
                        height: 5.8.h,
                        width: MediaQuery.of(context).size.width,
                        cornerRadius: UISettings.buttonCornerRadius,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .025, bottom: MediaQuery.of(context).size.height * .03),
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
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .020),
              child: SmoothPageIndicator(
                  controller: controller.pageController,
                  count: onboardingScreenPage.length,
                  // effect: const WormEffect(
                  //   dotHeight: 5,
                  //   dotWidth: 5,
                  //   spacing: 10.0,
                  //   dotColor: Colors.grey,
                  //   activeDotColor: Colors.black,
                  // ),
                  effect: const ExpandingDotsEffect(
                    strokeWidth: 3,
                    expansionFactor: 6,
                    dotWidth: 30,
                    dotHeight: 8,
                    spacing: -0.0,
                    radius: 0,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.black,
                  )),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _Page extends GetView<OnboardController> {
  final OnboardingScreenPage data;
  final bool isLastPage;

  const _Page(this.data, this.isLastPage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FluImage(
            data.image,
            imageSource: ImageSources.asset,
            expand: true,
            overlayOpacity: .15,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: UISettings.pagePaddingSize).copyWith(top: MediaQuery.of(context).size.height * .06),
          child: Column(
            children: [
              Text(
                StringUtils(data.title).capitalizeFirst!,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 24),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                data.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 14),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final currentPageProvider = StateProvider.autoDispose<int>((ref) => 0);
