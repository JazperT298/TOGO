// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/modules/privacy/controller/privacy_controller.dart';
import 'package:flukit/flukit.dart';
import 'package:ibank/utils/configs.dart';

class PrivacyView extends GetView<PrivacyController> {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PrivacyController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),
                        Text(
                          'Politique de confidentialite'.toUpperCase(),
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: context.colorScheme.primary),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Gorem ipsum dolor sit \namet.',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Horem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Nunc vulputate libero et velit interdum.',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac ',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus. Curabitur tempor quis eros tempus lacinia. Nam bibendum pellentesque quam a convallis. Sed ut vulputate nisi. Integer in felis sed leo vestibulum venenatis. Suspendisse quis arcu sem. ',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Nunc vulputate libero et velit interdum.',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac ',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus. Curabitur tempor quis eros tempus lacinia. Nam bibendum pellentesque quam a convallis. Sed ut vulputate nisi. Integer in felis sed leo vestibulum venenatis. Suspendisse quis arcu sem. ',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 90,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: UISettings.pagePadding.copyWith(top: 16, left: 24, right: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FluButton.text(
                            'Je refuse',
                            iconStrokeWidth: 1.8,
                            onPressed: () => print('Je refuse'),
                            height: 55,
                            cornerRadius: UISettings.minButtonCornerRadius,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: M3FontSizes.bodyLarge, color: Color(0xFFFB6404)),
                          ),
                          FluButton.text(
                            'J’accepte',
                            iconStrokeWidth: 1.8,
                            // onPressed: () => onAcceptTap(context),
                            height: 55,
                            width: MediaQuery.of(context).size.width * .40,
                            cornerRadius: UISettings.minButtonCornerRadius,
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
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: double.infinity,
      //   color: Colors.green,
      // ),
      // Positioned(bottom: 0, left: 0, right: 0, child: Container(height: 100, width: double.infinity, color: Colors.red))
    );
  }
}
