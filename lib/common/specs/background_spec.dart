import 'package:flutter/material.dart';

class BackgroundSpec {
  const BackgroundSpec({
    this.borderRadius,
    this.color,
    this.gradient,
  });

  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Gradient? gradient;

  DecoratedBox build(Widget child) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
        gradient: gradient,
      ),
      child: child,
    );
  }
}
