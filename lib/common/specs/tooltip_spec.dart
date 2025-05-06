import 'package:flutter/material.dart';

class TooltipSpec {
  const TooltipSpec({
    required this.richMessage,
    this.decoration,
    this.verticalOffset,
    this.margin,
    this.padding,
  });

  final InlineSpan richMessage;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? verticalOffset;

  Tooltip build(Widget child) {
    return Tooltip(
      richMessage: richMessage,
      decoration: decoration,
      margin: margin,
      padding: padding,
      verticalOffset: verticalOffset,
      child: child,
    );
  }
}
