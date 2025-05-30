import 'package:flutter/material.dart';

class DrawTickLabel<T> extends StatelessWidget {
  const DrawTickLabel({
    super.key,
    required this.label,
    this.labelFormatter,
    this.labelStyle,
  });

  final T label;

  final String Function(T label)? labelFormatter;

  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      labelFormatter != null ? labelFormatter!(label) : _defaultFormat(label),
      style: labelStyle,
    );
  }

  String _defaultFormat(T label) {
    if (label is num) {
      if (label % 1 == 0) return '${label.toInt()}';
      return label.toDouble().toStringAsFixed(1);
    }
    return '$label';
  }
}
