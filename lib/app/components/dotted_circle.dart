import 'dart:math';

import 'package:flutter/material.dart';

class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;

    // Draw the dotted circle
    for (double i = 0; i < 360; i += 10) {
      double x1 = radius * cos(degToRad(i));
      double y1 = radius * sin(degToRad(i));

      double x2 = radius * cos(degToRad(i + 5));
      double y2 = radius * sin(degToRad(i + 5));

      canvas.drawLine(Offset(x1, y1) + Offset(radius, radius), Offset(x2, y2) + Offset(radius, radius), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double degToRad(double degrees) {
    return degrees * (pi / 180.0);
  }
}
