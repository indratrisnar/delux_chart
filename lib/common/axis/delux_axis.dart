import 'package:flutter/material.dart';

import '../styles/line_style.dart';
import '../styles/tick_style.dart';

class DeluxAxis<T> {
  const DeluxAxis({
    required this.tickLength,
    required this.tickStyle,
    required this.gridLineStyle,
    required this.labelStyle,
    required this.labelFormatter,
    required this.labelWidget,
    this.xAxisLabelSpace = 20,
    required this.labelOffset,
    required this.gapTickLabel,
  });

  final double tickLength;
  final TickStyle tickStyle;
  final LineStyle? gridLineStyle;
  final TextStyle labelStyle;
  final String Function(T? label)? labelFormatter;
  final Widget? Function(T? label)? labelWidget;

  /// means the height of the label space when the domain/measure is on the x-axis
  final double xAxisLabelSpace;
  final Offset labelOffset;
  final double gapTickLabel;
}
