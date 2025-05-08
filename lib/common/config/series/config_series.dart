import 'package:flutter/material.dart';

import '../../data_model/chart_data.dart';
import '../../enums.dart';
import '../../specs/background_spec.dart';
import '../../specs/label_spec.dart';
import '../../specs/tooltip_spec.dart';

abstract class ConfigSeries {
  const ConfigSeries({
    required this.baseColor,
    required this.colorFn,
    required this.fillColorFn,
    required this.strokeWidthFn,
    required this.strokeColorFn,
    required this.fillGradientFn,
    required this.strokeGradientFn,
    required this.renderType,
    required this.tooltipSpecFn,
    required this.labelSpecFn,
    required this.backgroundSpecFn,
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

  final TooltipSpec? Function(ChartData item, int index)? tooltipSpecFn;

  final LabelSpec? Function(ChartData item, int index)? labelSpecFn;

  final BackgroundSpec? Function(ChartData item, int index)? backgroundSpecFn;

  (
    Color? fillColor,
    Gradient? fillGradient,
    double strokeWidth,
    Color strokeColor,
    Gradient? strokeGradient,
    TooltipSpec? tooltipSpec,
    LabelSpec? labelSpec,
    BackgroundSpec? backgroundSpec,
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

    final tooltipSpec =
        tooltipSpecFn != null ? tooltipSpecFn!(item, index) : null;

    final labelSpec = labelSpecFn != null ? labelSpecFn!(item, index) : null;

    final backgroundSpec =
        backgroundSpecFn != null ? backgroundSpecFn!(item, index) : null;

    return (
      fillColor,
      fillGradient,
      strokeWidth,
      strokeColor,
      strokeGradient,
      tooltipSpec,
      labelSpec,
      backgroundSpec,
    );
  }
}
