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
    this.tickCount = 3,
    this.crossAxisAlignment = CrossAxisAlignment.end,
    super.viewport,
  })  : assert(tickCount >= 2),
        assert(
          crossAxisAlignment == CrossAxisAlignment.start ||
              crossAxisAlignment == CrossAxisAlignment.center ||
              crossAxisAlignment == CrossAxisAlignment.end,
        );

  /// default: (0, maxMeasure from data)
  // final MeasureViewport? viewport;

  final int tickCount;

  final CrossAxisAlignment crossAxisAlignment;
}
