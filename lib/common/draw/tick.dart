import 'package:flutter/material.dart';

import '../styles/tick_style.dart';

class DrawTick extends StatelessWidget {
  const DrawTick({
    super.key,
    required this.tickStyle,
    required this.vertical,
  });

  final TickStyle tickStyle;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return VerticalDivider(
        width: tickStyle.thickness,
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
