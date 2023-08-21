import 'dart:math';

import 'package:flutter/material.dart';
import 'package:story_app/utils/styles/app_colors.dart';

class LoaderAnimation extends CustomPainter {
  final double radiusRatio;
  final Color? color;

  const LoaderAnimation({required this.radiusRatio, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint arc = Paint()
      ..color = color ?? AppColors.purpleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Rect rect = Rect.fromCenter(
      center: center,
      width: size.width / 2 * radiusRatio,
      height: size.height / 2 * radiusRatio,
    );

    canvas.drawArc(rect, pi / 4, pi / 2, false, arc);
    canvas.drawArc(rect, -pi / 4, -pi / 2, false, arc);
  }

  @override
  bool shouldRepaint(covariant LoaderAnimation oldDelegate) {
    return radiusRatio != oldDelegate.radiusRatio;
  }
}
