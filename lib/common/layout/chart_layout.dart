import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../delux_chart.dart';
import '../../types/delux_base_chart.dart';
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
  });

  Widget buildChartVertically();
  Widget buildChartHorizontally();

  Widget buildLayoutVertically({
    required List<ChartData> data,
    required ConfigRenderBar configRenderBar,
    required DomainAxis domainAxis,
    required MeasureAxis measureAxis,
    required AxisLine axisLine,
  }) {
    final max = data
        .map((e) => e.measure ?? 1)
        .reduce((v, e) => math.max(v, e));
    final domains = data.map((e) => e.domain).toList();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                children: [
                  DomainLabelLayout(
                    domains: domains,
                    domainAxis: domainAxis,
                    vertically: true,
                  ),
                  SizedBox(width: domainAxis.gapTickLabel),
                  DomainTickLayout(
                    domains: domains,
                    domainAxis: domainAxis,
                    vertically: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50,
              height:
                  measureAxis.tickLength +
                  measureAxis.gapTickLabel +
                  measureAxis.xAxisLabelSpace,
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MeasureGridLineLayout(
                      max: data
                          .map((e) => e.measure ?? 1)
                          .reduce((v, e) => math.max(v, e)),
                      measureAxis: measureAxis,
                      vertically: true,
                    ),
                    DomainGridLineLayout(
                      domains: data.map((e) => e.domain).toList(),
                      domainAxis: domainAxis,
                      vertically: true,
                    ),
                    DecoratedBox(
                      position:
                          axisLine.position == AxisLinePosition.background
                              ? DecorationPosition.background
                              : DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              axisLine.bottom?.borderSide ?? BorderSide.none,
                          left: axisLine.left?.borderSide ?? BorderSide.none,
                          top: axisLine.top?.borderSide ?? BorderSide.none,
                          right: axisLine.right?.borderSide ?? BorderSide.none,
                        ),
                      ),
                      child: buildChartVertically(),
                    ),
                  ],
                ),
              ),
              MeasureTickLayout(
                max: max,
                measureAxis: measureAxis,
                vertically: true,
              ),
              SizedBox(height: measureAxis.gapTickLabel),
              MeasureLabelLayout(
                max: max,
                measureAxis: measureAxis,
                vertically: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLayoutHorizontally({
    required List<ChartData> data,
    required ConfigRenderBar configRenderBar,
    required DomainAxis domainAxis,
    required MeasureAxis measureAxis,
    required AxisLine axisLine,
  }) {
    final max = data
        .map((e) => e.measure ?? 1)
        .reduce((v, e) => math.max(v, e));
    final domains = data.map((e) => e.domain).toList();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                children: [
                  MeasureLabelLayout(max: max, measureAxis: measureAxis),
                  SizedBox(width: measureAxis.gapTickLabel),
                  MeasureTickLayout(max: max, measureAxis: measureAxis),
                ],
              ),
            ),
            SizedBox(
              height:
                  domainAxis.tickLength +
                  domainAxis.gapTickLabel +
                  domainAxis.xAxisLabelSpace,
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MeasureGridLineLayout(
                      max: data
                          .map((e) => e.measure ?? 1)
                          .reduce((v, e) => math.max(v, e)),
                      measureAxis: measureAxis,
                    ),
                    DomainGridLineLayout(
                      domains: data.map((e) => e.domain).toList(),
                      domainAxis: domainAxis,
                    ),
                    DecoratedBox(
                      position:
                          axisLine.position == AxisLinePosition.background
                              ? DecorationPosition.background
                              : DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              axisLine.bottom?.borderSide ?? BorderSide.none,
                          left: axisLine.left?.borderSide ?? BorderSide.none,
                          top: axisLine.top?.borderSide ?? BorderSide.none,
                          right: axisLine.right?.borderSide ?? BorderSide.none,
                        ),
                      ),
                      child: buildChartHorizontally(),
                    ),
                  ],
                ),
              ),
              DomainTickLayout(domains: domains, domainAxis: domainAxis),
              SizedBox(height: domainAxis.gapTickLabel),
              DomainLabelLayout(domains: domains, domainAxis: domainAxis),
            ],
          ),
        ),
      ],
    );
  }
}
