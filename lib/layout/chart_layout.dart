import 'package:flutter/material.dart';

import '../delux_chart.dart';
import '../types/delux_base_chart.dart';
import 'domain/domain_grid_line_layout.dart';
import 'domain/domain_label_layout.dart';
import 'domain/domain_tick_layout.dart';
import 'measure/measure_grid_line_layout.dart';
import 'measure/measure_label_layout.dart';
import 'measure/measure_tick_layout.dart';

abstract class ChartLayout extends DeluxBaseChart {
  const ChartLayout({
    super.key,
    required super.data,
    super.axisLine,
    super.domainAxis,
    super.measureAxis,
    super.useSecondaryDomain,
    super.useSecondaryMeasure,
    super.direction,
  });

  Widget drawHorizontal();
  Widget drawVertical();

  @override
  Widget build(BuildContext context) {
    assert((domain.initialViewportIndex + domain.count - 1) < data.length);

    if (direction == Axis.horizontal) return buildHorizontal();
    return buildVertical();
  }

  Widget buildHorizontal() {
    return Row(
      children: [
        if (measureAxis != null && !useSecondaryMeasure)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (domainAxis != null && useSecondaryDomain)
                SizedBox(
                  height: domainAxis!.tickLength +
                      domainAxis!.gapTickLabel +
                      domainAxis!.xAxisLabelSpace,
                ),
              Expanded(
                child: Row(
                  children: [
                    MeasureLabelLayout(
                      max: measure.max,
                      measureAxis: measureAxis!,
                      direction: direction,
                      labelsInViewport: measure.labelsInViewport,
                    ),
                    SizedBox(width: measureAxis!.gapTickLabel),
                    MeasureTickLayout(
                      max: measure.max,
                      measureAxis: measureAxis!,
                      direction: direction,
                      labelsInViewport: measure.labelsInViewport,
                    ),
                  ],
                ),
              ),
              if (domainAxis != null && !useSecondaryDomain)
                SizedBox(
                  height: domainAxis!.tickLength +
                      domainAxis!.gapTickLabel +
                      domainAxis!.xAxisLabelSpace,
                ),
            ],
          ),
        Expanded(
          child: Column(
            children: [
              if (domainAxis != null && useSecondaryDomain) ...[
                DomainLabelLayout(
                  labelsInViewport: domain.labelsInViewport,
                  domainAxis: domainAxis!,
                  direction: direction,
                ),
                SizedBox(height: domainAxis!.gapTickLabel),
                DomainTickLayout(
                  labelsInViewport: domain.labelsInViewport,
                  domainAxis: domainAxis!,
                  direction: direction,
                ),
              ],
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (measureAxis != null)
                      MeasureGridLineLayout(
                        max: measure.max,
                        measureAxis: measureAxis!,
                        direction: direction,
                        labelsInViewport: measure.labelsInViewport,
                      ),
                    if (domainAxis != null)
                      DomainGridLineLayout(
                        domainAxis: domainAxis!,
                        direction: direction,
                        labelsInViewport: domain.labelsInViewport,
                      ),
                    DecoratedBox(
                      position:
                          axisLine?.position == AxisLinePosition.background
                              ? DecorationPosition.background
                              : DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              axisLine?.bottom?.borderSide ?? BorderSide.none,
                          left: axisLine?.left?.borderSide ?? BorderSide.none,
                          top: axisLine?.top?.borderSide ?? BorderSide.none,
                          right: axisLine?.right?.borderSide ?? BorderSide.none,
                        ),
                      ),
                      child: drawHorizontal(),
                    ),
                  ],
                ),
              ),
              if (domainAxis != null && !useSecondaryDomain) ...[
                DomainTickLayout(
                  labelsInViewport: domain.labelsInViewport,
                  domainAxis: domainAxis!,
                  direction: direction,
                ),
                SizedBox(height: domainAxis!.gapTickLabel),
                DomainLabelLayout(
                  labelsInViewport: domain.labelsInViewport,
                  domainAxis: domainAxis!,
                  direction: direction,
                ),
              ],
            ],
          ),
        ),
        if (measureAxis != null && useSecondaryMeasure)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (domainAxis != null && useSecondaryDomain)
                SizedBox(
                  height: domainAxis!.tickLength +
                      domainAxis!.gapTickLabel +
                      domainAxis!.xAxisLabelSpace,
                ),
              Expanded(
                child: Row(
                  children: [
                    MeasureTickLayout(
                      max: measure.max,
                      measureAxis: measureAxis!,
                      direction: direction,
                      labelsInViewport: measure.labelsInViewport,
                    ),
                    SizedBox(width: measureAxis!.gapTickLabel),
                    MeasureLabelLayout(
                      max: measure.max,
                      measureAxis: measureAxis!,
                      direction: direction,
                      labelsInViewport: measure.labelsInViewport,
                    ),
                  ],
                ),
              ),
              if (domainAxis != null && !useSecondaryDomain)
                SizedBox(
                  height: domainAxis!.tickLength +
                      domainAxis!.gapTickLabel +
                      domainAxis!.xAxisLabelSpace,
                ),
            ],
          ),
      ],
    );
  }

  Widget buildVertical() {
    return Row(
      children: [
        if (domainAxis != null && !useSecondaryDomain)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (measureAxis != null && useSecondaryMeasure)
                SizedBox(
                  height: measureAxis!.tickLength +
                      measureAxis!.gapTickLabel +
                      measureAxis!.xAxisLabelSpace,
                ),
              Expanded(
                child: Row(
                  children: [
                    DomainLabelLayout(
                      labelsInViewport: domain.labelsInViewport,
                      domainAxis: domainAxis!,
                      direction: direction,
                    ),
                    SizedBox(width: domainAxis!.gapTickLabel),
                    DomainTickLayout(
                      labelsInViewport: domain.labelsInViewport,
                      domainAxis: domainAxis!,
                      direction: direction,
                    ),
                  ],
                ),
              ),
              if (measureAxis != null && !useSecondaryMeasure)
                SizedBox(
                  height: measureAxis!.tickLength +
                      measureAxis!.gapTickLabel +
                      measureAxis!.xAxisLabelSpace,
                ),
            ],
          ),
        Expanded(
          child: Column(
            children: [
              if (measureAxis != null && useSecondaryMeasure) ...[
                MeasureLabelLayout(
                  max: measure.max,
                  measureAxis: measureAxis!,
                  direction: direction,
                  labelsInViewport: measure.labelsInViewport,
                ),
                SizedBox(height: measureAxis!.gapTickLabel),
                MeasureTickLayout(
                  max: measure.max,
                  measureAxis: measureAxis!,
                  direction: direction,
                  labelsInViewport: measure.labelsInViewport,
                ),
              ],
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (measureAxis != null)
                      MeasureGridLineLayout(
                        max: measure.max,
                        measureAxis: measureAxis!,
                        direction: direction,
                        labelsInViewport: measure.labelsInViewport,
                      ),
                    if (domainAxis != null)
                      DomainGridLineLayout(
                        labelsInViewport: domain.labelsInViewport,
                        domainAxis: domainAxis!,
                        direction: direction,
                      ),
                    DecoratedBox(
                      position:
                          axisLine?.position == AxisLinePosition.background
                              ? DecorationPosition.background
                              : DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              axisLine?.bottom?.borderSide ?? BorderSide.none,
                          left: axisLine?.left?.borderSide ?? BorderSide.none,
                          top: axisLine?.top?.borderSide ?? BorderSide.none,
                          right: axisLine?.right?.borderSide ?? BorderSide.none,
                        ),
                      ),
                      child: drawVertical(),
                    ),
                  ],
                ),
              ),
              if (measureAxis != null && !useSecondaryMeasure) ...[
                MeasureTickLayout(
                  max: measure.max,
                  measureAxis: measureAxis!,
                  direction: direction,
                  labelsInViewport: measure.labelsInViewport,
                ),
                SizedBox(height: measureAxis!.gapTickLabel),
                MeasureLabelLayout(
                  max: measure.max,
                  measureAxis: measureAxis!,
                  direction: direction,
                  labelsInViewport: measure.labelsInViewport,
                ),
              ],
            ],
          ),
        ),
        if (domainAxis != null && useSecondaryDomain)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (measureAxis != null && useSecondaryMeasure)
                SizedBox(
                  height: measureAxis!.tickLength +
                      measureAxis!.gapTickLabel +
                      measureAxis!.xAxisLabelSpace,
                ),
              Expanded(
                child: Row(
                  children: [
                    DomainTickLayout(
                      labelsInViewport: domain.labelsInViewport,
                      domainAxis: domainAxis!,
                      direction: direction,
                    ),
                    SizedBox(width: domainAxis!.gapTickLabel),
                    DomainLabelLayout(
                      labelsInViewport: domain.labelsInViewport,
                      domainAxis: domainAxis!,
                      direction: direction,
                    ),
                  ],
                ),
              ),
              if (measureAxis != null && !useSecondaryMeasure)
                SizedBox(
                  height: measureAxis!.tickLength +
                      measureAxis!.gapTickLabel +
                      measureAxis!.xAxisLabelSpace,
                ),
            ],
          ),
      ],
    );
  }
}
