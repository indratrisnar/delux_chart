import 'package:flutter/material.dart';

import '../../common/draw/tick_label.dart';
import 'measure_layout.dart';

class MeasureLabelLayout extends MeasureLayout {
  const MeasureLabelLayout({
    super.key,
    required super.max,
    required super.measureAxis,
    required super.direction,
    required super.labelsInViewport,
  });

  @override
  Widget buildHorizontal() {
    return LayoutBuilder(builder: (context, constraints) {
      final maxLayoutHeight = constraints.maxHeight;
      final segmentSpace = maxLayoutHeight / (tickCount - 1);

      final alignStack = switch (crossAxis) {
        CrossAxisAlignment.start => Alignment.centerLeft,
        CrossAxisAlignment.center => Alignment.center,
        _ => Alignment.centerRight,
      };
      return Stack(
        alignment: alignStack,
        children: [
          Column(
            crossAxisAlignment: crossAxis,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [labelsInViewport.first].map((e) {
              final labelText = DrawTickLabel<num>(
                label: e,
                labelFormatter: measureAxis.labelFormatter,
                labelStyle: measureAxis.labelStyle,
              );
              final labelOffset = Offset(
                measureAxis.labelOffset.dx,
                measureAxis.labelOffset.dy + segmentSpace / 2,
              );
              return Transform.translate(
                offset: labelOffset,
                child: SizedBox(
                  height: segmentSpace,
                  child: Align(
                    alignment: Alignment.center,
                    child: measureAxis.labelWidget != null
                        ? measureAxis.labelWidget!(e) ?? labelText
                        : labelText,
                  ),
                ),
              );
            }).toList(),
          ),
          Column(
            crossAxisAlignment: crossAxis,
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(tickCount - 1, (index) {
              final label = labelsInViewport[index + 1];
              final labelText = DrawTickLabel<num>(
                label: label,
                labelFormatter: measureAxis.labelFormatter,
                labelStyle: measureAxis.labelStyle,
              );

              final labelOffset = Offset(
                measureAxis.labelOffset.dx,
                measureAxis.labelOffset.dy - segmentSpace / 2,
              );

              return Transform.translate(
                offset: labelOffset,
                child: SizedBox(
                  height: segmentSpace,
                  child: Align(
                    alignment: Alignment.center,
                    child: measureAxis.labelWidget != null
                        ? measureAxis.labelWidget!(label) ?? labelText
                        : labelText,
                  ),
                ),
              );
            }).reversed.toList(),
          ),
        ],
      );
    });
  }

  @override
  Widget buildVertical() {
    return SizedBox(
      height: measureAxis.xAxisLabelSpace,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final segmentSpace = maxLayoutWidth / (tickCount - 1);
        final alignStack = switch (crossAxis) {
          CrossAxisAlignment.start => Alignment.centerLeft,
          CrossAxisAlignment.center => Alignment.center,
          _ => Alignment.centerRight,
        };
        return Stack(
          alignment: alignStack,
          children: [
            Row(
              crossAxisAlignment: crossAxis,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [labelsInViewport.first].map((e) {
                final labelText = DrawTickLabel<num>(
                  label: e,
                  labelFormatter: measureAxis.labelFormatter,
                  labelStyle: measureAxis.labelStyle,
                );
                final labelOffset = Offset(
                  measureAxis.labelOffset.dx - segmentSpace / 2,
                  measureAxis.labelOffset.dy,
                );
                return Transform.translate(
                  offset: labelOffset,
                  child: SizedBox(
                    width: segmentSpace,
                    child: Align(
                      alignment: Alignment.center,
                      child: measureAxis.labelWidget != null
                          ? measureAxis.labelWidget!(e) ?? labelText
                          : labelText,
                    ),
                  ),
                );
              }).toList(),
            ),
            Row(
              crossAxisAlignment: crossAxis,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(tickCount - 1, (index) {
                final label = labelsInViewport[index + 1];
                final labelText = DrawTickLabel<num>(
                  label: label,
                  labelFormatter: measureAxis.labelFormatter,
                  labelStyle: measureAxis.labelStyle,
                );

                final labelOffset = Offset(
                  measureAxis.labelOffset.dx + segmentSpace / 2,
                  measureAxis.labelOffset.dy,
                );

                return Transform.translate(
                  offset: labelOffset,
                  child: SizedBox(
                    width: segmentSpace,
                    child: Align(
                      alignment: Alignment.center,
                      child: measureAxis.labelWidget != null
                          ? measureAxis.labelWidget!(label) ?? labelText
                          : labelText,
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
