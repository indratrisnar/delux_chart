import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../common/config/renders/config_render_bar.dart';
import '../common/draw/rect.dart';
import '../common/layout/chart_layout.dart';

class DeluxBarChart extends ChartLayout {
  const DeluxBarChart({
    super.key,
    required super.data,
    super.domainAxis,
    super.measureAxis,
    super.axisLine,
    this.configRenderBar = const ConfigRenderBar(),
    this.vertically = false,
  });

  final ConfigRenderBar configRenderBar;

  final bool vertically;

  @override
  Widget build(BuildContext context) {
    if (vertically) {
      return buildLayoutVertically(
        data: data,
        configRenderBar: configRenderBar,
        domainAxis: domainAxis,
        measureAxis: measureAxis,
        axisLine: axisLine,
      );
    }
    return buildLayoutHorizontally(
      data: data,
      configRenderBar: configRenderBar,
      domainAxis: domainAxis,
      measureAxis: measureAxis,
      axisLine: axisLine,
    );
  }

  @override
  Widget buildChartVertically() {
    final maxMeasure =
        (data.map((e) => e.measure ?? 1).reduce((v, e) => math.max(v, e)));

    final measureViewport = measureAxis.viewport ?? (min: 0, max: maxMeasure);
    final domainViewport =
        domainAxis.viewport ?? (start: data.first.domain, count: data.length);

    return LayoutBuilder(builder: (context, layoutChart) {
      final maxLayoutWidth = layoutChart.maxWidth;
      final maxLayoutHeight = layoutChart.maxHeight;

      //
      final rangeMeasureViewport = measureViewport.max - measureViewport.min;
      final segmentWidth = maxLayoutHeight / domainViewport.count;
      final width = configRenderBar.barWidth ??
          maxLayoutHeight / (domainViewport.count + 1);
      final initialIndex =
          data.indexWhere((e) => e.domain == domainViewport.start);

      return SizedBox(
        height: maxLayoutHeight,
        width: maxLayoutWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(domainViewport.count, (index) {
            final item = data[initialIndex + index];
            if (item.measure == null || item.measure == measureViewport.min) {
              return SizedBox(width: segmentWidth);
            }
            final right = (measureViewport.max - item.measure!) /
                rangeMeasureViewport *
                maxLayoutWidth;
            final left = (0 - measureViewport.min) /
                rangeMeasureViewport *
                maxLayoutWidth;

            final (
              fillColor,
              fillGradient,
              strokeWidth,
              strokeColor,
              strokeGradient
            ) = configRenderBar.generate(item, index);

            final borderRadius = configRenderBar.borderRadiusFn != null
                ? configRenderBar.borderRadiusFn!(item, index)
                : null;

            return SizedBox(
              height: segmentWidth,
              child: Stack(
                children: [
                  Positioned(
                    left: left,
                    right: right,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: DrawRect(
                        item: item,
                        height: width,
                        width: double.infinity,
                        strokeColor: strokeColor,
                        strokeWidth: strokeWidth,
                        borderRadius: borderRadius,
                        fillColor: fillColor,
                        fillGradient: fillGradient,
                        strokeGradient: strokeGradient,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }

  @override
  Widget buildChartHorizontally() {
    final maxMeasure =
        (data.map((e) => e.measure ?? 1).reduce((v, e) => math.max(v, e)));

    final measureViewport = measureAxis.viewport ?? (min: 0, max: maxMeasure);
    final domainViewport =
        domainAxis.viewport ?? (start: data.first.domain, count: data.length);

    return LayoutBuilder(builder: (context, layoutChart) {
      final maxLayoutWidth = layoutChart.maxWidth;
      final maxLayoutHeight = layoutChart.maxHeight;

      //
      final rangeMeasureViewport = measureViewport.max - measureViewport.min;
      final segmentWidth = maxLayoutWidth / domainViewport.count;
      final width = configRenderBar.barWidth ??
          maxLayoutWidth / (domainViewport.count + 1);
      final initialIndex =
          data.indexWhere((e) => e.domain == domainViewport.start);

      return SizedBox(
        height: maxLayoutHeight,
        width: maxLayoutWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(domainViewport.count, (index) {
            final item = data[initialIndex + index];
            if (item.measure == null || item.measure == measureViewport.min) {
              return SizedBox(width: segmentWidth);
            }
            final top = (measureViewport.max - item.measure!) /
                rangeMeasureViewport *
                maxLayoutHeight;
            final bottom = (0 - measureViewport.min) /
                rangeMeasureViewport *
                maxLayoutHeight;

            final (
              fillColor,
              fillGradient,
              strokeWidth,
              strokeColor,
              strokeGradient
            ) = configRenderBar.generate(item, index);

            final borderRadius = configRenderBar.borderRadiusFn != null
                ? configRenderBar.borderRadiusFn!(item, index)
                : null;

            return SizedBox(
              width: segmentWidth,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: top,
                    bottom: bottom.toDouble(),
                    child: Center(
                      child: DrawRect(
                        item: item,
                        height: double.infinity,
                        width: width,
                        strokeColor: strokeColor,
                        strokeWidth: strokeWidth,
                        borderRadius: borderRadius,
                        fillColor: fillColor,
                        fillGradient: fillGradient,
                        strokeGradient: strokeGradient,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}
