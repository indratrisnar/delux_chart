import 'package:flutter/material.dart';

import '../../draw/tick.dart';
import 'measure_layout.dart';

class MeasureTickLayout extends MeasureLayout {
  const MeasureTickLayout({
    super.key,
    required super.max,
    required super.measureAxis,
    required super.direction,
    required super.labelsInViewport,
  });

  @override
  Widget buildHorizontal() {
    return SizedBox(
      width: measureAxis.tickLength,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tickCount, (index) {
          return DrawTick(
            tickStyle: measureAxis.tickStyle,
            vertical: false,
          );
        }),
      ),
    );
  }

  @override
  Widget buildVertical() {
    return SizedBox(
      height: measureAxis.tickLength,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tickCount, (index) {
          return DrawTick(
            tickStyle: measureAxis.tickStyle,
            vertical: true,
          );
        }),
      ),
    );
  }
}
