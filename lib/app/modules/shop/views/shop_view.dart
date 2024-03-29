import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/app/data/models/shop.dart';
import 'package:ibank/app/modules/recharge/controller/recharge_controller.dart';
import 'package:ibank/app/modules/shop/controller/shop_controller.dart';
import 'package:flukit/flukit.dart';
import 'package:ibank/utils/configs.dart';
import 'package:sizer/sizer.dart';

import '../../recharge/views/modals/recharge_credit_menu_bottom_sheet.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShopController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle
          .copyWith(statusBarIconBrightness: Brightness.dark),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .05),
          child: Column(
            children: [
              Padding(
                padding: UISettings.pagePadding.copyWith(
                    top: 20, bottom: MediaQuery.of(context).size.height * .025),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Moov store'.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF687997),
                                fontSize: 14),
                          ),
                          Text(
                            'OUR PRODUCTS MOOV AFRICA.'.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27303F),
                                fontSize: 26),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 50),
                    // FluButton.icon(
                    //   FluIcons.bag,
                    //   size: UISettings.minButtonSize,
                    //   cornerRadius: UISettings.minButtonCornerRadius,
                    //   backgroundColor: context.colorScheme.primaryContainer,
                    // )
                  ],
                ),
              ),
              _Highlights(ShopProduct.getAll()),
              SizedBox(height: 3.h),
              Row(
                children: [
                  FluLine(
                    width: 30.w,
                    color: const Color(0xFFfb6708),
                  ),
                  CircleAvatar(
                    radius: 1.w,
                    backgroundColor: const Color(0xFFfb6708),
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              _Categories(ShopProductCategory.getAll())
            ],
          ),
        ),
      ),
    );
  }
}

class _Highlights extends GetView<ShopController> {
  final List<ShopProduct> products;
  final double spaceBetweenItems = 10;

  const _Highlights(this.products, {Key? key}) : super(key: key);

  int get itemCount =>
      products.where((x) => x.images.isNotEmpty).toList().length;

  @override
  Widget build(BuildContext context) {
    Get.put(ShopController());
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .025),
      child: ListView.builder(
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: UISettings.pagePadding,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          ShopProduct product = products[index];

          return FluOutline(
            thickness: 1,
            gap: 3,
            cornerRadius: 35,
            margin: EdgeInsets.only(left: index == 0 ? 0 : spaceBetweenItems),
            colors: [context.colorScheme.surfaceVariant],
            /* boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: const Offset(0, 0))
              ], */
            child: Container(
              width: MediaQuery.of(context).size.width * .65,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  FluImage(
                    product.images.first.url,
                    height: double.infinity,
                    width: double.infinity,
                    overlayOpacity: .2,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Text(
                        '${product.name}.',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Categories extends GetView<ShopController> {
  final List<ShopProductCategory> categories;
  final double spaceBetweenItems = 20;
  final double itemImgSize = 65, itemImgRadius = 28;

  const _Categories(this.categories, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: UISettings.pagePadding,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          ShopProductCategory category = categories[index];
          Color color = category.color;

          return GestureDetector(
            onTap: () {
              if (categories[index].name == "Credit") {
                RechargeCreditMainMenuBottomSheet
                    .showBottomSheetRechargeCreditTo();
              } else if (categories[index].name == "Internet package") {
                //    controller.internetNumberCode.value = '400';
                // controller.internetGetProducts();
                Get.find<RechargeController>().internetNumberCode.value = '400';
                Get.find<RechargeController>().internetGetProducts();
              } else if (categories[index].name == "Voice package") {
                log('asd ');
                //    controller.internetNumberCode.value = '400';
                // controller.internetGetProducts();
                Get.find<RechargeController>().internetRadioGroupValue.value =
                    '';
                Get.find<RechargeController>().voicePackageNumberCode.value =
                    '555';
                Get.find<RechargeController>().voicePackageGetProducts();
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: index == 0 ? 0 : spaceBetweenItems),
              child: Row(
                children: [
                  Container(
                    height: itemImgSize + 5,
                    width: itemImgSize + 5,
                    margin: const EdgeInsets.only(right: 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: CircularProgressIndicator(
                              value: .2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  color.withOpacity(.35)),
                              strokeWidth: 1.5,
                            ),
                          ),
                        ),
                        Container(
                          height: itemImgSize - 3,
                          width: itemImgSize - 3,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                              color: Color(0xFFDBE4FB), shape: BoxShape.circle),
                          child: FluIcon(category.icon, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringUtils(category.name).capitalize!,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF27303F),
                            fontSize: 14),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        category.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF687997),
                            fontSize: 14),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          );
        });
  }
}
