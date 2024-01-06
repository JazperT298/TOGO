import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ibank/app/components/map.dart';
import 'package:ibank/app/modules/map/controller/map_controller.dart';
import 'package:ibank/utils/configs.dart';

class MapView extends GetView<MapContoller> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return FluScreen(
      overlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.black, systemNavigationBarIconBrightness: Brightness.dark),
      background: Colors.black,
      body: Stack(
        children: [
          const AgenciesMap(
            radius: 0,
            fullScreen: true,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: UISettings.pagePaddingSize,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "<back_button_hero>",
                      child: button(
                        context,
                        FluIcons.arrowLeft,
                        () => Get.back(),
                      ),
                    ),
                    /* button(
                        FluIcons.location_gps,
                        () => Get.back(),
                      ), */
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget button(BuildContext context, FluIcons icon, void Function() onPressed) => FluGlass(
        cornerRadius: UISettings.buttonCornerRadius - 2,
        /* shadow: Flu.boxShadow(
            opacity: .15, offset: const Offset(0, 0), blurRadius: 30), */
        child: FluButton.icon(
          icon,
          onPressed: onPressed,
          size: UISettings.minButtonSize,
          cornerRadius: UISettings.minButtonCornerRadius,
          backgroundColor: context.colorScheme.background.withOpacity(.45),
          foregroundColor: context.colorScheme.onSurface,
        ),
      );
}
