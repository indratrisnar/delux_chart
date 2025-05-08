import 'package:flutter/material.dart';

import '../../draw/tick_label.dart';
import 'domain_layout.dart';

class DomainLabelLayout extends DomainLayout {
  const DomainLabelLayout({
    super.key,
    required super.domainAxis,
    required super.direction,
    required super.labelsInViewport,
  });

  @override
  Widget buildHorizontal() {
    return SizedBox(
      height: domainAxis.xAxisLabelSpace,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final segmentSpace = maxLayoutWidth / tickCount;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: labelsInViewport.map(
            (e) {
              final label = e;
              final labelText = DrawTickLabel<String>(
                label: label,
                labelFormatter: domainAxis.labelFormatter,
                labelStyle: domainAxis.labelStyle,
              );
              return SizedBox(
                width: segmentSpace,
                child: Transform.translate(
                  offset: domainAxis.labelOffset,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: domainAxis.labelWidget != null
                        ? domainAxis.labelWidget!(label) ?? labelText
                        : labelText,
                  ),
                ),
              );
            },
          ).toList(),
        );
      }),
    );
  }

  @override
  Widget buildVertical() {
    return LayoutBuilder(builder: (context, constraints) {
      final maxLayoutHeight = constraints.maxHeight;
      final segmentSpace = maxLayoutHeight / labelsInViewport.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: labelsInViewport.map((e) {
          final label = e;
          final labelText = DrawTickLabel<String>(
            label: label,
            labelFormatter: domainAxis.labelFormatter,
            labelStyle: domainAxis.labelStyle,
          );
          return SizedBox(
            height: segmentSpace,
            child: Transform.translate(
              offset: domainAxis.labelOffset,
              child: Align(
                alignment: Alignment.center,
                child: domainAxis.labelWidget != null
                    ? domainAxis.labelWidget!(label) ?? labelText
                    : labelText,
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
