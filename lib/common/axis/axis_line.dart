import '../enums.dart';
import '../styles/line_style.dart';

class AxisLine {
  const AxisLine({
    this.bottom = const LineStyle(),
    this.left = const LineStyle(),
    this.top,
    this.right,
    this.position = AxisLinePosition.background,
  });
  final LineStyle? bottom;
  final LineStyle? left;
  final LineStyle? top;
  final LineStyle? right;
  final AxisLinePosition position;
}
