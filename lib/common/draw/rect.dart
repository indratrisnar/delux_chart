import 'package:flutter/material.dart';

import '../specs/label_spec.dart';
import '../specs/tooltip_spec.dart';

class DrawRect extends StatelessWidget {
  const DrawRect({
    super.key,
    required this.strokeColor,
    required this.strokeWidth,
    this.borderRadius,
    this.fillColor,
    this.fillGradient,
    this.strokeGradient,
    this.tooltipSpec,
    this.labelSpec,
  });

  final Color strokeColor;
  final double strokeWidth;
  final BorderRadiusGeometry? borderRadius;
  final Color? fillColor;
  final Gradient? fillGradient;
  final Gradient? strokeGradient;
  final TooltipSpec? tooltipSpec;
  final LabelSpec? labelSpec;

  @override
  Widget build(BuildContext context) {
    final decor = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: strokeColor,
        gradient: strokeGradient,
      ),
      child: Padding(
        padding: EdgeInsets.all(strokeWidth),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: fillColor,
                gradient: fillGradient,
              ),
            ),
            if (labelSpec != null) labelSpec!.build(),
          ],
        ),
      ),
    );
    return tooltipSpec?.build(decor) ?? decor;
  }
}
