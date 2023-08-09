import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class SColors {
  static final defaultPaint = Paint()
    ..color = Colors.cyan
    ..style = PaintingStyle.stroke;

  static final knobPaint = BasicPalette.gray.withAlpha(200).paint();
  static final backgroundPaint = BasicPalette.lightGray.withAlpha(100).paint();
}
