import 'package:flutter/material.dart';

import '../../data_model/chart_data.dart';
import '../../enums.dart';
import 'config_render.dart';

class ConfigRenderBar extends ConfigRender {
  const ConfigRenderBar({
    super.baseColor = Colors.deepPurpleAccent,
    super.colorFn,
    super.fillColorFn,
    super.fillGradientFn,
    super.strokeWidthFn,
    super.strokeColorFn,
    super.strokeGradientFn,
    super.renderType = RenderType.bar,
    this.barWidth,
    this.borderRadiusFn,
  });

  /// width of bar element
  final double? barWidth;

  /// set corner radius
  final BorderRadiusGeometry? Function(ChartData item, int index)?
      borderRadiusFn;
}
