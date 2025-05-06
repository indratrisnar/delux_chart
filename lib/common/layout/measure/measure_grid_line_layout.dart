import 'package:flutter/material.dart';

import '../../draw/grid_line.dart';
import 'measure_layout.dart';

class MeasureGridLineLayout extends MeasureLayout {
  const MeasureGridLineLayout({
    super.key,
    required super.max,
    required super.measureAxis,
    required super.direction,
    required super.labelsInViewport,
  });

  @override
  Widget build(BuildContext context) {
    if (measureAxis.gridLineStyle == null) return const SizedBox();
    return super.build(context);
  }

  @override
  Widget buildHorizontal() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tickCount, (index) {
          return DrawGridLine(
            lineStyle: measureAxis.gridLineStyle!,
            vertical: false,
          );
        }),
      ),
    );
  }

  @override
  Widget buildVertical() {
    return SizedBox(
      height: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tickCount, (index) {
          return DrawGridLine(
            lineStyle: measureAxis.gridLineStyle!,
            vertical: true,
          );
        }),
      ),
    );
  }
}
