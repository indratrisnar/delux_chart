import 'package:flutter/material.dart';

import '../../draw/tick.dart';
import 'domain_layout.dart';

class DomainTickLayout extends DomainLayout {
  const DomainTickLayout({
    super.key,
    required super.domainAxis,
    required super.direction,
    required super.labelsInViewport,
  });

  @override
  Widget buildHorizontal() {
    return SizedBox(
      height: domainAxis.tickLength,
      child: LayoutBuilder(builder: (context, constraints) {
        // final maxLayoutWidth = constraints.maxWidth;
        // final segmentSpace = maxLayoutWidth / viewportLength;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tickCount, (index) {
            return DrawTick(
              tickStyle: domainAxis.tickStyle,
              vertical: true,
            );
          }),
        );
      }),
    );
  }

  @override
  Widget buildVertical() {
    return SizedBox(
      width: domainAxis.tickLength,
      child: LayoutBuilder(builder: (context, constraints) {
        // final maxLayoutHeight = constraints.maxHeight;
        // final segmentSpace = maxLayoutHeight / viewportLength;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tickCount, (index) {
            return DrawTick(
              tickStyle: domainAxis.tickStyle,
              vertical: false,
            );
          }),
        );
      }),
    );
  }
}
