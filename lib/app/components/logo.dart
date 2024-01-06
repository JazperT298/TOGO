import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:ibank/utils/configs.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.color, this.fontSize = M3FontSizes.titleLarge});

  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(Configs.appName,
        style: TextStyle(
          color: color ?? context.colorScheme.primary,
          fontSize: fontSize,
          fontFamily: "neptune",
        ));
  }
}
