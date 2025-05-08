import 'package:flutter/material.dart';

import '../../common/draw/grid_line.dart';
import 'domain_layout.dart';

class DomainGridLineLayout extends DomainLayout {
  const DomainGridLineLayout({
    super.key,
    required super.domainAxis,
    required super.direction,
    required super.labelsInViewport,
  });

  @override
  Widget build(BuildContext context) {
    if (domainAxis.gridLineStyle == null) return const SizedBox();
    return super.build(context);
  }

  @override
  Widget buildHorizontal() {
    return SizedBox(
      height: double.maxFinite,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final segmentSpace = maxLayoutWidth / tickCount;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tickCount, (index) {
            return SizedBox(
              width: segmentSpace,
              child: DrawGridLine(
                vertical: true,
                lineStyle: domainAxis.gridLineStyle!,
              ),
            );
          }),
        );
      }),
    );
  }

  @override
  Widget buildVertical() {
    return SizedBox(
      height: double.maxFinite,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutHeight = constraints.maxHeight;
        final segmentSpace = maxLayoutHeight / tickCount;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tickCount, (index) {
            return SizedBox(
              height: segmentSpace,
              child: DrawGridLine(
                vertical: false,
                lineStyle: domainAxis.gridLineStyle!,
              ),
            );
          }),
        );
      }),
    );
  }
}
