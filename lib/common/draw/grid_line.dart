import 'package:flutter/material.dart';

import '../styles/line_style.dart';

class DrawGridLine extends StatelessWidget {
  const DrawGridLine({
    super.key,
    required this.lineStyle,
    required this.vertical,
  });

  final bool vertical;
  final LineStyle lineStyle;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return VerticalDivider(
        width: lineStyle.thickness,
        thickness: lineStyle.thickness,
        color: lineStyle.color,
      );
    }
    return Divider(
      height: lineStyle.thickness,
      thickness: lineStyle.thickness,
      color: lineStyle.color,
    );
  }
}
