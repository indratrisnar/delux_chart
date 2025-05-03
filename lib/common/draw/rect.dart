import 'package:flutter/material.dart';

import '../data_model/chart_data.dart';

class DrawRect extends StatelessWidget {
  const DrawRect({
    super.key,
    required this.item,
    required this.height,
    required this.width,
    required this.strokeColor,
    required this.strokeWidth,
    this.borderRadius,
    this.fillColor,
    this.fillGradient,
    this.strokeGradient,
  });

  final ChartData item;
  final double height;
  final double width;
  final Color strokeColor;
  final double strokeWidth;
  final BorderRadiusGeometry? borderRadius;
  final Color? fillColor;
  final Gradient? fillGradient;
  final Gradient? strokeGradient;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Tooltip(
        preferBelow: false,
        message: '${item.domain}: ${item.measure}',
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: strokeColor,
            gradient: strokeGradient,
          ),
          child: Padding(
            padding: EdgeInsets.all(strokeWidth),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: fillColor,
                gradient: fillGradient,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
