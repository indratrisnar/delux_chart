import 'package:flutter/material.dart';

import '../../axis/measure_axis.dart';
import '../../draw/tick_label.dart';
import 'measure_layout.dart';

class MeasureLabelLayout extends MeasureLayout {
  const MeasureLabelLayout({
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
    });
    // ..add(viewport.min.toDouble());

    final crossAxis = measureAxis.crossAxisAlignment;

    if (vertically) {
      return _MeasureLabelVertically(
        tickCount: tickCount,
        viewport: viewport,
        measureAxis: measureAxis,
        crossAxis: crossAxis,
        tickValues: tickValues,
      );
    }
    return _MeasureLabelHorizontally(
      tickCount: tickCount,
      viewport: viewport,
      measureAxis: measureAxis,
      crossAxis: crossAxis,
      tickValues: tickValues,
    );
  }
}

class _MeasureLabelVertically extends StatelessWidget {
  const _MeasureLabelVertically({
    required this.tickCount,
    required this.viewport,
    required this.measureAxis,
    required this.crossAxis,
    required this.tickValues,
  });

  final int tickCount;
  final ({num max, num min}) viewport;
  final MeasureAxis measureAxis;
  final CrossAxisAlignment crossAxis;
  final List<double> tickValues;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: measureAxis.xAxisLabelSpace,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final segmentSpace = maxLayoutWidth / tickCount;
        final labelTextMin = DrawTickLabel<num>(
          label: viewport.min,
          labelFormatter: measureAxis.labelFormatter,
          labelStyle: measureAxis.labelStyle,
        );
        return Row(
          crossAxisAlignment: crossAxis,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(tickValues.length, (index) {
            final labelText = DrawTickLabel<num>(
              label: tickValues[index],
              labelFormatter: measureAxis.labelFormatter,
              labelStyle: measureAxis.labelStyle,
            );

            final labelHeight = measureAxis.labelStyle.height ?? 1.6;
            final labelSize = measureAxis.labelStyle.fontSize ?? 14;
            final labelOffset = Offset(
              (labelHeight * labelSize) / 2 + measureAxis.labelOffset.dx,
              measureAxis.labelOffset.dy,
            );

            return Transform.translate(
              offset: labelOffset,
              child: Stack(
                children: [
                  SizedBox(
                    width: segmentSpace,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: measureAxis.labelWidget != null
                          ? measureAxis.labelWidget!(tickValues[index]) ??
                              labelText
                          : labelText,
                    ),
                  ),
                  if (index == tickCount - 1)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      child: Transform.translate(
                        offset: Offset(-segmentSpace - 3, 0),
                        child: SizedBox(
                          width: segmentSpace,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: measureAxis.labelWidget != null
                                ? measureAxis.labelWidget!(viewport.min) ??
                                    labelTextMin
                                : labelTextMin,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).reversed.toList(),
        );
      }),
    );
  }
}

class _MeasureLabelHorizontally extends StatelessWidget {
  const _MeasureLabelHorizontally({
    required this.tickCount,
    required this.viewport,
    required this.measureAxis,
    required this.crossAxis,
    required this.tickValues,
  });

  final int tickCount;
  final ({num max, num min}) viewport;
  final MeasureAxis measureAxis;
  final CrossAxisAlignment crossAxis;
  final List<double> tickValues;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxLayoutHeight = constraints.maxHeight;
      final segmentSpace = maxLayoutHeight / tickCount;
      final labelTextMin = DrawTickLabel<num>(
        label: viewport.min,
        labelFormatter: measureAxis.labelFormatter,
        labelStyle: measureAxis.labelStyle,
      );
      final isLeftOrCenter = crossAxis == CrossAxisAlignment.start ||
          crossAxis == CrossAxisAlignment.center;
      final isRightOrCenter = crossAxis == CrossAxisAlignment.end ||
          crossAxis == CrossAxisAlignment.center;
      return Column(
        crossAxisAlignment: crossAxis,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tickValues.length, (index) {
          final labelText = DrawTickLabel<num>(
            label: tickValues[index],
            labelFormatter: measureAxis.labelFormatter,
            labelStyle: measureAxis.labelStyle,
          );

          final labelHeight = measureAxis.labelStyle.height ?? 1.6;
          final labelSize = measureAxis.labelStyle.fontSize ?? 14;
          final labelOffset = Offset(
            measureAxis.labelOffset.dx,
            (-labelHeight * labelSize) / 2 + measureAxis.labelOffset.dy,
          );

          return Transform.translate(
            offset: labelOffset,
            child: Stack(
              children: [
                SizedBox(
                  height: segmentSpace,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: measureAxis.labelWidget != null
                        ? measureAxis.labelWidget!(tickValues[index]) ??
                            labelText
                        : labelText,
                  ),
                ),
                if (index == tickCount - 1)
                  Positioned(
                    left: isLeftOrCenter ? 0 : null,
                    right: isRightOrCenter ? 0 : null,
                    child: Transform.translate(
                      offset: Offset(0, segmentSpace),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: measureAxis.labelWidget != null
                            ? measureAxis.labelWidget!(viewport.min) ??
                                labelTextMin
                            : labelTextMin,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      );
    });
  }
}
