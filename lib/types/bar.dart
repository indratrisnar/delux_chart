import 'package:flutter/material.dart';

import '../config/series/config_series_bar.dart';
import '../common/enums.dart';
import '../layout/chart_layout.dart';

class DeluxBarChart extends ChartLayout {
  const DeluxBarChart({
    super.key,
    required super.data,
    super.domainAxis,
    super.measureAxis,
    super.useSecondaryDomain,
    super.useSecondaryMeasure,
    super.axisLine,
    super.direction,
    this.configSeriesBar,
  });

  final ConfigSeriesBar? configSeriesBar;

  ConfigSeriesBar get configSeries => configSeriesBar ?? ConfigSeriesBar();

  @override
  Widget drawHorizontal() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final maxLayoutHeight = constraints.maxHeight;
        final segmentWidth = maxLayoutWidth / domain.count;
        final rectWidth =
            configSeries.barWidth ?? maxLayoutWidth / (domain.count + 1);

        return SizedBox(
          width: maxLayoutWidth,
          height: maxLayoutHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(domain.count, (index) {
              final item = data[domain.initialViewportIndex + index];

              if (item.measure == null ||
                  item.measure == measure.viewport.start) {
                return SizedBox(width: segmentWidth);
              }

              final top = (measure.viewport.end - item.measure!) /
                  measure.viewportRange *
                  maxLayoutHeight;
              final bottom = (0 - measure.viewport.start) /
                  measure.viewportRange *
                  maxLayoutHeight;

              final (
                fillColor,
                fillGradient,
                strokeWidth,
                strokeColor,
                strokeGradient,
                tooltipSpec,
                labelSpec,
                backgroundSpec,
                borderRadius,
                labelPosition,
                rect,
              ) = configSeries.draw(item, index);

              final barItem = Column(
                children: [
                  if (top > 0)
                    SizedBox(
                      height: top,
                      child: labelPosition == LabelPosition.outsideEnd
                          ? labelSpec?.build()
                          : null,
                    ),
                  Expanded(child: rect),
                  if (bottom > 0)
                    SizedBox(
                      height: bottom,
                      child: labelPosition == LabelPosition.outsideStart
                          ? labelSpec?.build()
                          : null,
                    ),
                ],
              );

              return SizedBox(
                width: segmentWidth,
                child: Center(
                  child: SizedBox(
                    width: rectWidth,
                    child: backgroundSpec?.build(barItem) ?? barItem,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  Widget drawVertical() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final maxLayoutHeight = constraints.maxHeight;
        final segmentWidth = maxLayoutHeight / domain.count;
        final rectWidth =
            configSeries.barWidth ?? maxLayoutHeight / (domain.count + 1);

        return SizedBox(
          width: maxLayoutWidth,
          height: maxLayoutHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(domain.count, (index) {
              final item = data[domain.initialViewportIndex + index];

              if (item.measure == null ||
                  item.measure == measure.viewport.start) {
                return SizedBox(height: segmentWidth);
              }

              final right = (measure.viewport.end - item.measure!) /
                  measure.viewportRange *
                  maxLayoutWidth;
              final left = (0 - measure.viewport.start) /
                  measure.viewportRange *
                  maxLayoutWidth;

              final (
                fillColor,
                fillGradient,
                strokeWidth,
                strokeColor,
                strokeGradient,
                tooltipSpec,
                labelSpec,
                backgroundSpec,
                borderRadius,
                labelPosition,
                rect,
              ) = configSeries.draw(item, index);

              final barItem = Row(
                children: [
                  if (left > 0)
                    SizedBox(
                      width: left,
                      child: labelPosition == LabelPosition.outsideStart
                          ? labelSpec?.build()
                          : null,
                    ),
                  Expanded(child: rect),
                  if (right > 0)
                    SizedBox(
                      width: right,
                      child: labelPosition == LabelPosition.outsideEnd
                          ? labelSpec?.build()
                          : null,
                    ),
                ],
              );

              return SizedBox(
                height: segmentWidth,
                child: Center(
                  child: SizedBox(
                    height: rectWidth,
                    child: backgroundSpec?.build(barItem) ?? barItem,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
