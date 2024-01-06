import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class SepLine extends StatelessWidget {
  final EdgeInsets margin;
  final double? width;

  const SepLine(
      {Key? key,
      this.width,
      this.margin = const EdgeInsets.symmetric(vertical: 25)})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Hero(
        tag: 'sep_line',
        child: Container(
          margin: margin,
          child: Row(
            children: [
              FluLine(
                height: 1,
                width: width ?? context.width * .15,
                color: context.colorScheme.tertiary.withOpacity(.65),
              ),
              FluLine(
                height: 6,
                width: 6,
                radius: 99,
                color: context.colorScheme.tertiary,
              ),
            ],
          ),
        ),
      );
}
