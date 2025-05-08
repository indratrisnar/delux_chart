import 'package:flutter/material.dart';

import '../../common/data_model/chart_data.dart';
import '../../common/draw/rect.dart';
import '../../common/enums.dart';
import '../../common/specs/background_spec.dart';
import '../../common/specs/label_spec.dart';
import '../../common/specs/tooltip_spec.dart';
import 'config_series.dart';

class ConfigSeriesBar extends ConfigSeries {
  const ConfigSeriesBar({
    super.baseColor = Colors.deepPurpleAccent,
    super.colorFn,
    super.fillColorFn,
    super.fillGradientFn,
    super.strokeWidthFn,
    super.strokeColorFn,
    super.strokeGradientFn,
    super.tooltipSpecFn,
    super.labelSpecFn,
    super.backgroundSpecFn,
    this.barWidth,
    this.borderRadiusFn,
    this.onTap,
    this.labelPositionFn,
  }) : super(renderType: RenderType.bar);

  /// width of bar element
  final double? barWidth;

  /// set corner radius
  final BorderRadiusGeometry? Function(ChartData item, int index)?
      borderRadiusFn;

  final void Function(ChartData item)? onTap;

  final LabelPosition? Function(ChartData item, int index)? labelPositionFn;

  (
    Color? fillColor,
    Gradient? fillGradient,
    double strokeWidth,
    Color strokeColor,
    Gradient? strokeGradient,
    TooltipSpec? tooltipSpec,
    LabelSpec? labelSpec,
    BackgroundSpec? backgroundSpec,
    BorderRadiusGeometry? borderRadius,
    LabelPosition labelPosition,
    Widget rect,
  ) draw(ChartData item, int index) {
    final (
      fillColor,
      fillGradient,
      strokeWidth,
      strokeColor,
      strokeGradient,
      tooltipSpec,
      labelSpec,
      backgroundSpec,
    ) = generate(item, index);

    final borderRadius =
        borderRadiusFn != null ? borderRadiusFn!(item, index) : null;

    final labelPosition =
        (labelPositionFn != null ? labelPositionFn!(item, index) : null) ??
            LabelPosition.inside;

    final rect = GestureDetector(
      onTap: onTap == null ? null : () => onTap!(item),
      child: DrawRect(
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        borderRadius: borderRadius,
        fillColor: fillColor,
        fillGradient: fillGradient,
        strokeGradient: strokeGradient,
        tooltipSpec: tooltipSpec,
        labelSpec: labelPosition == LabelPosition.inside ? labelSpec : null,
      ),
    );

    return (
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
    );
  }
}
