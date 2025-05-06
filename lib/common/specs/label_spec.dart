import 'package:flutter/material.dart';

class LabelSpec {
  const LabelSpec({
    this.label,
    this.labelStyle,
    this.labelWidget,
    this.labelAlignment,
    this.labelPadding,
  });

  final String? label;
  final TextStyle? labelStyle;
  final Widget? labelWidget;
  final AlignmentGeometry? labelAlignment;
  final EdgeInsetsGeometry? labelPadding;

  Widget build() {
    assert(label != null || labelWidget != null);
    return Align(
      alignment: labelAlignment ?? Alignment.center,
      child: Padding(
        padding: labelPadding ?? const EdgeInsets.all(0),
        child: labelWidget ??
            Text(
              label!,
              style: labelStyle,
            ),
      ),
    );
  }
}
