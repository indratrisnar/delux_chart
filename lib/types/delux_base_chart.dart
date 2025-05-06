import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../delux_chart.dart';

abstract class DeluxBaseChart<T> extends StatelessWidget {
  const DeluxBaseChart({
    super.key,
    required this.data,
    this.domainAxis,
    this.measureAxis,
    this.axisLine,
    this.direction = Axis.horizontal,
  }) : assert(T == num || T == String || T == DateTime);

  /// list of chart data
  final List<ChartData<T>> data;

  /// config main domain axis
  final DomainAxis<T>? domainAxis;

  /// config main measure axis
  final MeasureAxis? measureAxis;

  /// styling for line in axis, if side style null then will be not visible
  final AxisLine? axisLine;

  /// direction for domain axis
  final Axis direction;

  ({
    DeluxViewport<T> viewport,
    List<T> labels,
    List<T> labelsInViewport,
    int count,
    int initialViewportIndex,
  }) get domain {
    final labels = data.map((e) => e.domain).toList();
    final viewport =
        domainAxis?.viewport ?? DeluxViewport<T>(labels.first, labels.last);
    final firstIndex = labels.indexWhere((e) => e == viewport.start);
    final labelsInViewport = labels
        .getRange(
          firstIndex,
          labels.indexWhere((e) => e == viewport.end) + 1,
        )
        .toList();

    return (
      viewport: viewport,
      labels: labels,
      labelsInViewport: labelsInViewport,
      count: labelsInViewport.length,
      initialViewportIndex: firstIndex,
    );
  }

  ({
    DeluxViewport<num> viewport,
    num viewportRange,
    List<num> labelsInViewport,
    num max,
  }) get measure {
    final max =
        data.map((e) => e.measure ?? 1).reduce((v, e) => math.max(v, e));
    final viewport = measureAxis?.viewport ?? DeluxViewport<num>(0, max);
    final tickCount = measureAxis?.tickCount ?? 3;
    final viewportRange = viewport.end - viewport.start;
    final divider = viewportRange / (tickCount - 1);
    final labelsInViewport = List.generate(
      tickCount,
      (index) => viewport.start + index * divider,
    );

    return (
      viewport: viewport,
      viewportRange: viewportRange,
      labelsInViewport: labelsInViewport,
      max: max,
    );
  }
}
