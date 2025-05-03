import 'package:flutter/material.dart';

import '../../axis/measure_axis.dart';

abstract class MeasureLayout extends StatelessWidget {
  const MeasureLayout({
    super.key,
    required this.max,
    required this.measureAxis,
    this.vertically = false,
  });

  final num max;
  final MeasureAxis measureAxis;
  final bool vertically;
}
