import 'package:flukit/flukit.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/ui/onboarding_screen_page.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_images.dart';

final List<OnboardingScreenPage> onboardingScreenPage = [
  OnboardingScreenPage(
    image: AppImages.onboard1,
    title: "eligendi est et.",
    description:
        "Earum rerum pariatur consequatur. Voluptatem qui numquam qui rerum aut. Voluptas facere repudiandae magnam. Aliquam commodi vero aliquid. Aut est omnis itaque qui voluptates modi sit. Magni numquam reprehenderit in vel accusamus expedita..",
    buttonText: LocaleKeys.strDiscover.tr,
    buttonIcon: FluIcons.location,
  ),
  OnboardingScreenPage(
    image: AppImages.onboard2,
    title: "voluptate aut aut.",
    description:
        "Earum rerum pariatur consequatur. Voluptatem qui numquam qui rerum aut. Voluptas facere repudiandae magnam. Aliquam commodi vero aliquid. Aut est omnis itaque qui voluptates modi sit. Magni numquam reprehenderit in vel accusamus expedita..",
    buttonText: LocaleKeys.strSoundsGood.tr,
    buttonIcon: FluIcons.emojiHappy,
  ),
  OnboardingScreenPage(
    image: AppImages.onboard3,
    title: "nobis consequatur.",
    description:
        "Earum rerum pariatur consequatur. Voluptatem qui numquam qui rerum aut. Voluptas facere repudiandae magnam. Aliquam commodi vero aliquid. Aut est omnis itaque qui voluptates modi sit. Magni numquam reprehenderit in vel accusamus expedita..",
    buttonText: LocaleKeys.strGetStarted.tr,
    buttonIcon: FluIcons.flash,
  ),
];
