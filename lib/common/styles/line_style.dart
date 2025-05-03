import 'package:flutter/material.dart';

class LineStyle {
  const LineStyle({
    this.color = Colors.grey,
    this.thickness = 1,
  });

  final Color color;
  final double thickness;

  BorderSide get borderSide {
    return BorderSide(
      color: color,
      width: thickness,
    );
  }
}
