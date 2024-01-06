import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibank/app/data/models/shop.dart';
import 'package:ibank/app/modules/shop/controller/shop_controller.dart';
import 'package:flukit/flukit.dart';
import 'package:ibank/utils/configs.dart';

class ShopView extends GetView<ShopController> {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShopController());
    return FluScreen(
      overlayStyle: context.systemUiOverlayStyle.copyWith(statusBarIconBrightness: Brightness.dark),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .05),
          child: Column(
            children: [
              Padding(
                padding: UISettings.pagePadding.copyWith(top: 20, bottom: MediaQuery.of(context).size.height * .025),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Moov store',
                            style: TextStyle(
                              fontFamily: 'neptune',
                            ),
                          ),
                          Text(
                            'Pour vous, par nous.'.toUpperCase(),
                            style: TextStyle(
                              fontSize: M3FontSizes.headlineMedium,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    FluButton.icon(
                      FluIcons.bag,
                      size: UISettings.minButtonSize,
                      cornerRadius: UISettings.minButtonCornerRadius,
                      backgroundColor: context.colorScheme.primaryContainer,
                    )
                  ],
                ),
              ),
              _Highlights(ShopProduct.getAll()),
              FluLine(
                width: double.infinity,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .05, bottom: MediaQuery.of(context).size.height * .05),
              ),
              Padding(
                padding: UISettings.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            'Nos\nproduits.'.toUpperCase(),
                            maxLines: null,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                              fontSize: M3FontSizes.headlineMedium,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        FluButton.icon(
                          FluIcons.searchStatus,
                          size: UISettings.minButtonSize,
                          cornerRadius: UISettings.minButtonCornerRadius,
                          backgroundColor: context.colorScheme.primaryContainer,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 35),
                child: Row(
                  children: [
                    FluLine(
                      height: 1,
                      width: MediaQuery.of(context).size.width * .1,
                      color: context.colorScheme.tertiary,
                    ),
                    FluLine(
                      height: 6.5,
                      width: 6.5,
                      radius: 99,
                      color: context.colorScheme.tertiary,
                    ),
                  ],
                ),
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

  int get itemCount => products.where((x) => x.images.isNotEmpty).toList().length;

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
              width: MediaQuery.of(context).size.width * .35,
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
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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

          return Container(
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
                            valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(.35)),
                            strokeWidth: 1.5,
                          ),
                        ),
                      ),
                      Container(
                        height: itemImgSize - 3,
                        width: itemImgSize - 3,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(color: color.withOpacity(.085), shape: BoxShape.circle),
                        child: FluIcon(category.icon, color: color),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringUtils(category.name).capitalize!,
                        style: const TextStyle(fontSize: M3FontSizes.bodyLarge, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(
                      category.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: context.colorScheme.onBackground.withOpacity(.75)),
                    ),
                  ],
                )),
              ],
            ),
          );
        });
  }
}
