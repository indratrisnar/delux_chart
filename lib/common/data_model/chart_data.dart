class ChartData {
  const ChartData(
    this.domain,
    this.measure, {
    this.object,
  });

  /// just like data x
  final String? domain;

  /// just like data y
  final num? measure;

  /// you set your own data
  final Object? object;
}
