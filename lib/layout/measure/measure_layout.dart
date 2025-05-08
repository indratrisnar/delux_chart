import 'package:flutter/material.dart';

import '../../common/axis/measure_axis.dart';

abstract class MeasureLayout extends StatelessWidget {
  const MeasureLayout({
    super.key,
    required this.max,
    required this.measureAxis,
    required this.direction,
    required this.labelsInViewport,
  });

  final num max;
  final MeasureAxis measureAxis;
  final Axis direction;
  final List<num> labelsInViewport;

  Widget buildVertical();
  Widget buildHorizontal();

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) return buildHorizontal();
    return buildVertical();
  }

  int get tickCount => measureAxis.tickCount;

  num get startLabel => labelsInViewport.first;

  // DeluxViewport<num> get viewport {
  //   return measureAxis.viewport ?? DeluxViewport<num>(0, max);
  // }

  // int get tickCount => measureAxis.tickCount;

  // num get viewportRange => viewport.end - viewport.start;

  // num get divider => viewportRange / (tickCount - 1);

  // List<num> get labelInViewport {
  //   return List.generate(
  //     tickCount,
  //     (index) => viewport.end - index * divider,
  //   );
  // }

  CrossAxisAlignment get crossAxis => measureAxis.crossAxisAlignment;
}
