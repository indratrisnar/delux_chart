import 'package:flutter/material.dart';

import '../../axis/domain_axis.dart';
import '../../draw/grid_line.dart';
import 'domain_layout.dart';

class DomainGridLineLayout extends DomainLayout {
  const DomainGridLineLayout({
    super.key,
    required super.domains,
    required super.domainAxis,
    super.vertically,
  });

  @override
  Widget build(BuildContext context) {
    if (domainAxis.gridLineStyle == null) return const SizedBox();
    final viewport =
        domainAxis.viewport ?? (start: domains.first, count: domains.length);
    if (vertically) {
      return _DomainGridLineVertically(
        viewport: viewport,
        domainAxis: domainAxis,
      );
    }
    return _DomainGridLineHorizontally(
      viewport: viewport,
      domainAxis: domainAxis,
    );
  }
}

class _DomainGridLineVertically extends StatelessWidget {
  const _DomainGridLineVertically({
    required this.viewport,
    required this.domainAxis,
  });

  final ({int count, String? start}) viewport;
  final DomainAxis domainAxis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutHeight = constraints.maxHeight;
        final segmentSpace = maxLayoutHeight / viewport.count;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(viewport.count, (index) {
            return SizedBox(
              height: segmentSpace,
              child: DrawGridLine(
                vertical: false,
                lineStyle: domainAxis.gridLineStyle!,
              ),
            );
          }),
        );
      }),
    );
  }
}

class _DomainGridLineHorizontally extends StatelessWidget {
  const _DomainGridLineHorizontally({
    required this.viewport,
    required this.domainAxis,
  });

  final ({int count, String? start}) viewport;
  final DomainAxis domainAxis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final segmentSpace = maxLayoutWidth / viewport.count;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(viewport.count, (index) {
            return SizedBox(
              width: segmentSpace,
              child: DrawGridLine(
                vertical: true,
                lineStyle: domainAxis.gridLineStyle!,
              ),
            );
          }),
        );
      }),
    );
  }
}
