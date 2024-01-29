import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingContainer() {
  return Container(
    height: MediaQuery.of(Get.context!).size.height,
    width: double.infinity,
    color: Colors.black.withOpacity(0.3), // Transparent black background
    child: Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: const Color(0xFFFB6404), //const Color(0xFF124DE5),
        size: 50,
      ),
    ),
  );
}

Widget loadingHomeScreen() {
  return SizedBox(
    height: 55,
    width: double.infinity,
    child: Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: const Color(0xFF124DE5),
        size: 30,
      ),
    ),
  );
}
