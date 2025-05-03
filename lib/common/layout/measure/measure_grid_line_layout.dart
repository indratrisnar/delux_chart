import 'package:flutter/material.dart';

import '../../axis/measure_axis.dart';
import '../../draw/grid_line.dart';
import 'measure_layout.dart';

class MeasureGridLineLayout extends MeasureLayout {
  const MeasureGridLineLayout({
    super.key,
    required super.max,
    required super.measureAxis,
    super.vertically,
  });

  @override
  Widget build(BuildContext context) {
    if (measureAxis.gridLineStyle == null) return const SizedBox();

    final viewport = measureAxis.viewport ?? (min: 0, max: max);
    final rangeViewport = viewport.max - viewport.min;
    final tickCount = measureAxis.tickCount - 1;
    final divider = rangeViewport / tickCount;
    final tickValues = List.generate(tickCount, (i) {
      return viewport.max - divider * i;
    })
      ..add(viewport.min.toDouble());

    if (vertically) {
      return _MeasureGridLineVertically(
        tickValues: tickValues,
        measureAxis: measureAxis,
      );
    }
    return _MeasureGridLineHorizontally(
      tickValues: tickValues,
      measureAxis: measureAxis,
    );
  }
}

class _MeasureGridLineVertically extends StatelessWidget {
  const _MeasureGridLineVertically({
    required this.tickValues,
    required this.measureAxis,
  });

  final List<double> tickValues;
  final MeasureAxis measureAxis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tickValues.map((e) {
          return DrawGridLine(
            lineStyle: measureAxis.gridLineStyle!,
            vertical: true,
          );
        }).toList(),
      ),
    );
  }
}

class _MeasureGridLineHorizontally extends StatelessWidget {
  const _MeasureGridLineHorizontally({
    required this.tickValues,
    required this.measureAxis,
  });

  final List<double> tickValues;
  final MeasureAxis measureAxis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tickValues.map((e) {
          return DrawGridLine(
            lineStyle: measureAxis.gridLineStyle!,
          );
        }).toList(),
      ),
    );
  }
}
