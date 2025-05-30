class ChartData {
  const ChartData(
    this.domain,
    this.measure, {
    this.object,
  });

  /// data x in horizontal direction
  final String domain;

  /// data y in horizontal direction
  final num? measure;

  /// you set your own data
  final Object? object;

  @override
  String toString() {
    return 'ChartData(domain: $domain, measure: $measure, object: $object)';
  }
}
