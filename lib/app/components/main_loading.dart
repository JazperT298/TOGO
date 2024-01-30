// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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

fullScreenLoadingDialog() {
  return showDialog(
    context: Get.context!,
    barrierColor: Colors.black.withOpacity(0.1),
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.black.withOpacity(0.1),
        content: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: const Color(0xFFFB6404),
              size: 60,
            ),
          ),
        ),
      );
    },
  );
}

Widget loadingContainer2(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
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

class FullLoadingPage extends StatelessWidget {
  const FullLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class FullScreenLoading {
  static fullScreenLoading() {
    return Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Container(
          height: MediaQuery.of(Get.context!).size.height,
          width: double.infinity,
          color: Colors.white.withOpacity(0.1),
          child: Center(child: LoadingAnimationWidget.staggeredDotsWave(color: const Color(0xFFFB6404), size: 70)),
        ),
        isScrollControlled: true);
  }

  static fullScreenLoadingWithText(String infoString) {
    return Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Container(
          height: MediaQuery.of(Get.context!).size.height,
          width: double.infinity,
          color: Colors.white.withOpacity(0.1),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.staggeredDotsWave(color: const Color(0xFFFB6404), size: 70),
              Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(infoString, style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 17)))
            ],
          )),
        ),
        isScrollControlled: true);
  }

  static fullScreenLoadingWithTextAndTimer(String infoString) {
    return Get.bottomSheet(
        backgroundColor: Colors.transparent,
        Container(
          height: MediaQuery.of(Get.context!).size.height,
          width: double.infinity,
          color: Colors.white.withOpacity(0.1),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.staggeredDotsWave(color: const Color(0xFFFB6404), size: 70),
              Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(infoString, style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 17)))
            ],
          )),
        ),
        isScrollControlled: true);
  }
}
