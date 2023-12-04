import 'package:flutter/material.dart';
import 'package:weaving/style/app_style.dart';

class BanSignPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppStyle.titleTextColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw the circle
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    // Draw the line
    canvas.drawLine(Offset(.15 * size.width, .15 * size.height),
        Offset(.85 * size.width, .85 * size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
