import 'package:flutter/material.dart';

import '../../data_model/chart_data.dart';
import '../../enums.dart';

abstract class ConfigRender {
  const ConfigRender({
    required this.baseColor,
    required this.colorFn,
    required this.fillColorFn,
    required this.strokeWidthFn,
    required this.strokeColorFn,
    required this.fillGradientFn,
    required this.strokeGradientFn,
    required this.renderType,
  });

  /// set color for entire chart element
  final Color baseColor;

  /// set color dynamic based on given parameter
  final Color? Function(ChartData item, int index)? colorFn;

  /// if chart has shape to be draw, this color is to fill that shape
  final Color? Function(ChartData item, int index)? fillColorFn;

  /// if chart has shape to be draw, this gradient will be set
  ///
  /// if null, solid color will be set
  final Gradient? Function(ChartData item, int index)? fillGradientFn;

  /// dynamic thickness for stroke
  final double Function(ChartData item, int index)? strokeWidthFn;

  /// if chart has shape to be draw, this color as border of that shape
  ///
  /// or can be as line color
  final Color? Function(ChartData item, int index)? strokeColorFn;

  /// set stroke color for shape or path
  ///
  /// if null, solid color will be set
  final Gradient? Function(ChartData item, int index)? strokeGradientFn;

  final RenderType renderType;

  (
    Color? fillColor,
    Gradient? fillGradient,
    double strokeWidth,
    Color strokeColor,
    Gradient? strokeGradient
  ) generate(ChartData item, int index) {
    final fillColor = fillColorFn != null
        ? fillColorFn!(item, index)
        : colorFn != null
            ? colorFn!(item, index)
            : baseColor;
    final fillGradient =
        fillGradientFn != null ? fillGradientFn!(item, index) : null;

    final strokeWidth =
        strokeWidthFn != null ? strokeWidthFn!(item, index) : 0.0;

    final strokeColor = strokeColorFn != null
        ? (strokeColorFn!(item, index) ?? baseColor)
        : baseColor;

    final strokeGradient =
        strokeGradientFn != null ? strokeGradientFn!(item, index) : null;

    return (fillColor, fillGradient, strokeWidth, strokeColor, strokeGradient);
  }
}
