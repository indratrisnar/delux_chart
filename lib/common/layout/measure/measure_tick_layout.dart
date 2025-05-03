import 'package:flutter/material.dart';

import '../../axis/measure_axis.dart';
import '../../draw/tick.dart';
import 'measure_layout.dart';

class MeasureTickLayout extends MeasureLayout {
  const MeasureTickLayout({
    super.key,
    required super.max,
    required super.measureAxis,
    super.vertically,
  });

  @override
  Widget build(BuildContext context) {
    final viewport = measureAxis.viewport ?? (min: 0, max: max);
    final rangeViewport = viewport.max - viewport.min;
    final tickCount = measureAxis.tickCount - 1;
    final divider = rangeViewport / tickCount;
    final tickValues = List.generate(tickCount, (i) {
      return viewport.max - divider * i;
    })
      ..add(viewport.min.toDouble());
    if (vertically) {
      return _MeasureTickVertically(
        measureAxis: measureAxis,
        tickValues: tickValues,
      );
    }
    return _MeasureTickHorizontally(
      measureAxis: measureAxis,
      tickValues: tickValues,
    );
  }
}

class _MeasureTickVertically extends StatelessWidget {
  const _MeasureTickVertically({
    required this.measureAxis,
    required this.tickValues,
  });

  final MeasureAxis measureAxis;
  final List<double> tickValues;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: measureAxis.tickLength,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tickValues.map((e) {
          return DrawTick(
            tickStyle: measureAxis.tickStyle,
            vertical: true,
          );
        }).toList(),
      ),
    );
  }
}

class _MeasureTickHorizontally extends StatelessWidget {
  const _MeasureTickHorizontally({
    required this.measureAxis,
    required this.tickValues,
  });

  final MeasureAxis measureAxis;
  final List<double> tickValues;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: measureAxis.tickLength,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tickValues.map((e) {
          return DrawTick(
            tickStyle: measureAxis.tickStyle,
          );
        }).toList(),
      ),
    );
  }
}
