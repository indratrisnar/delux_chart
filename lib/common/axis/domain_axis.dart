import 'package:flutter/material.dart';

import '../styles/tick_style.dart';
import 'delux_axis.dart';

class DomainAxis extends DeluxAxis {
  const DomainAxis({
    super.tickLength = 5,
    super.tickStyle = const TickStyle(),
    super.gridLineStyle,
    super.labelStyle = const TextStyle(),
    super.labelFormatter,
    super.labelWidget,
    super.xAxisLabelSpace,
    super.labelOffset = Offset.zero,
    super.gapTickLabel = 5,
    this.viewport,
  });

  /// start as initial offset and count as how many data show per viewport
  final ({String start, int count})? viewport;
}
