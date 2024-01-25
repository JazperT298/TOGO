import 'package:flukit/flukit.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/ui/onboarding_screen_page.dart';
import 'package:ibank/generated/locales.g.dart';
import 'package:ibank/utils/constants/app_images.dart';

final List<OnboardingScreenPage> onboardingScreenPage = [
  OnboardingScreenPage(
    image: AppImages.onboard1,
    title: "Moov Money",
    description: "Get ready to discover a new, simple and secure way to manage your money, wherever you are with your Moov Money app.",
    buttonText: LocaleKeys.strDiscover.tr,
    buttonIcon: FluIcons.location,
  ),
  OnboardingScreenPage(
    image: AppImages.onboard2,
    title: "Fast and effective",
    description: "Send money, pay your bills, top up your credit and more. Moov Money makes every transaction quick and easy.",
    buttonText: LocaleKeys.strSoundsGood.tr,
    buttonIcon: FluIcons.emojiHappy,
  ),
  OnboardingScreenPage(
    image: AppImages.onboard3,
    title: "Simple and secure",
    description:
        "Operate with peace of mind. Moov Money ensures the security of every transaction, guaranteeing the confidentiality of your information.",
    buttonText: LocaleKeys.strGetStarted.tr,
    buttonIcon: FluIcons.flash,
  ),
];
