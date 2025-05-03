import 'package:flutter/material.dart';

import '../delux_chart.dart';

abstract class DeluxBaseChart extends StatelessWidget {
  const DeluxBaseChart({
    super.key,
    required this.data,
    this.domainAxis = const DomainAxis(),
    this.measureAxis = const MeasureAxis(),
    this.axisLine = const AxisLine(),
  });

  /// list of chart data
  final List<ChartData> data;

  /// config main domain axis
  final DomainAxis domainAxis;

  /// config main measure axis
  final MeasureAxis measureAxis;

  /// styling for line in axis, if side style null then will be not visible
  final AxisLine axisLine;

  // @override
  // Widget build(BuildContext context);
}
