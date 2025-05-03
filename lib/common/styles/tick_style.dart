import 'package:flutter/material.dart';

class TickStyle {
  const TickStyle({
    this.color = Colors.grey,
    this.thickness = 1,
    this.width = 1,
  });

  final Color color;
  final double thickness;

  /// for layout size
  final double width;

  TickStyle copyWith({
    Color? color,
    double? thickness,
    double? width,
  }) {
    return TickStyle(
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
      width: width ?? this.width,
    );
  }
}
