import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class FluOption {
  final String title;
  final String? description, image;
  final ImageSources imageType;
  final FluIcons? icon;
  final Widget? suffixWidget;
  final void Function()? onPressed;
  final Color? color, background, iconbackground, outlineColor;
  final bool hasSuffix;
  final String? label;

  FluOption(
      {required this.title,
      this.description,
      this.icon,
      this.image,
      this.imageType = ImageSources.asset,
      this.suffixWidget,
      this.hasSuffix = true,
      this.onPressed,
      this.color,
      this.background,
      this.iconbackground,
      this.outlineColor,
      this.label});
}

class Options extends StatelessWidget {
  final List<FluOption> options;
  final double itemSize, spaceBetweenOptions;
  final EdgeInsets padding;
  final bool lastIsLogout;

  const Options(
    this.options, {
    Key? key,
    this.itemSize = 60,
    this.spaceBetweenOptions = 25,
    this.padding = const EdgeInsets.only(top: 45),
    this.lastIsLogout = false,
  }) : super(key: key);

  void onOptionTap(int index) {}

  @override
  Widget build(BuildContext context) => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding,
      itemCount: options.length,
      itemBuilder: (context, index) {
        FluOption option = options[index];
        bool isLogout = lastIsLogout && index == options.length - 1;

        return FluButton(
          onPressed: option.onPressed ?? () {},
          backgroundColor: context.colorScheme.background,
          margin: EdgeInsets.only(top: index == 0 ? 0 : spaceBetweenOptions),
          padding: EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                        height: itemSize + 8,
                        width: itemSize + 8,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            value: .25,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              (isLogout ? Colors.red : context.colorScheme.primary).withOpacity(.1),
                            ),
                          ),
                        )),
                    Container(
                      height: itemSize,
                      width: itemSize,
                      decoration:
                          BoxDecoration(color: (isLogout ? Colors.red : context.colorScheme.primary).withOpacity(.045), shape: BoxShape.circle),
                      child: FluIcon(
                        option.icon!,
                        size: 24,
                        strokeWidth: 1.6,
                        color: isLogout ? Colors.red : context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  option.title,
                  style: TextStyle(
                    fontSize: M3FontSizes.bodyLarge,
                    fontWeight: FontWeight.bold,
                    color: isLogout ? Colors.red : context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  option.description!,
                  style: TextStyle(
                    color: isLogout ? Colors.red : context.colorScheme.onBackground.withOpacity(.75),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ])),
              const SizedBox(width: 15),
              FluIcon(
                FluIcons.arrowRight1,
                size: 18,
                color: isLogout ? Colors.red : context.colorScheme.onBackground,
              ),
            ],
          ),
        );
      });
}
