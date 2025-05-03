import 'package:flutter/material.dart';

import '../styles/tick_style.dart';
import 'delux_axis.dart';

class MeasureAxis extends DeluxAxis<num> {
  const MeasureAxis({
    super.tickLength = 5,
    super.tickStyle = const TickStyle(),
    super.gridLineStyle,
    super.labelStyle = const TextStyle(),
    super.labelFormatter,
    super.labelWidget,
    super.xAxisLabelSpace,
    super.labelOffset = Offset.zero,
    super.gapTickLabel = 5,
    this.tickCount = 2,
    this.crossAxisAlignment = CrossAxisAlignment.end,
    this.viewport,
  }) : assert(tickCount >= 2);

  /// default: (0, maxMeasure from data)
  final ({num min, num max})? viewport;

  final int tickCount;

  final CrossAxisAlignment crossAxisAlignment;
}
