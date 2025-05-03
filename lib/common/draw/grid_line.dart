import 'package:flutter/material.dart';

import '../styles/line_style.dart';

class DrawGridLine extends StatelessWidget {
  const DrawGridLine({
    super.key,
    this.vertical = false,
    required this.lineStyle,
  });

  final bool vertical;
  final LineStyle lineStyle;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return VerticalDivider(
        thickness: lineStyle.thickness,
        color: lineStyle.color,
        width: lineStyle.thickness,
      );
    }
    return Divider(
      height: lineStyle.thickness,
      thickness: lineStyle.thickness,
      color: lineStyle.color,
    );
  }
}
