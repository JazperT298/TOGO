import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ibank/utils/constants/app_images.dart';

class CarouselWidget {
  static final List<String> images = [
    AppImages.onboard1,
    AppImages.onboard2,
    AppImages.onboard3,
    // Add more image paths as needed
  ];

  static Widget buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: images.map((String imagePath) {
        return buildImageContainer(imagePath);
      }).toList(),
    );
  }

  static Widget buildImageContainer(String imagePath) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
