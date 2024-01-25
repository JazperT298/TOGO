import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibank/utils/configs.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.color, this.fontSize = M3FontSizes.titleLarge});

  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Moov Money'.toUpperCase(),
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 22),
        ),
        Text(
          Configs.appName.toUpperCase(),
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: const Color(0xFFFB6404), fontSize: 22),
        ),
      ],
    );
  }
}
