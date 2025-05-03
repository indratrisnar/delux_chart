import 'package:flutter/material.dart';

import '../styles/tick_style.dart';

class DrawTick extends StatelessWidget {
  const DrawTick({
    super.key,
    this.vertical = false,
    required this.tickStyle,
  });

  final bool vertical;
  final TickStyle tickStyle;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return VerticalDivider(
        width: tickStyle.width,
        thickness: tickStyle.thickness,
        color: tickStyle.color,
      );
    }
    return Divider(
      height: tickStyle.thickness,
      thickness: tickStyle.thickness,
      color: tickStyle.color,
    );
  }
}
