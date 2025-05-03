import 'package:flutter/material.dart';

import '../../axis/domain_axis.dart';
import '../../draw/tick.dart';
import 'domain_layout.dart';

class DomainTickLayout extends DomainLayout {
  const DomainTickLayout({
    super.key,
    required super.domains,
    required super.domainAxis,
    super.vertically,
  });

  @override
  Widget build(BuildContext context) {
    final viewport =
        domainAxis.viewport ?? (start: domains.first, count: domains.length);
    if (vertically) {
      return _DomainTickVertically(
        domainAxis: domainAxis,
        viewport: viewport,
      );
    }
    return _DomainTickHorizontally(
      domainAxis: domainAxis,
      viewport: viewport,
    );
  }
}

class _DomainTickVertically extends StatelessWidget {
  const _DomainTickVertically({
    required this.domainAxis,
    required this.viewport,
  });

  final DomainAxis domainAxis;
  final ({int count, String? start}) viewport;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: domainAxis.tickLength,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutHeight = constraints.maxHeight;
        final segmentSpace = maxLayoutHeight / viewport.count;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(viewport.count, (index) {
            return DrawTick(
              vertical: false,
              tickStyle: domainAxis.tickStyle.copyWith(width: segmentSpace),
            );
          }),
        );
      }),
    );
  }
}

class _DomainTickHorizontally extends StatelessWidget {
  const _DomainTickHorizontally({
    required this.domainAxis,
    required this.viewport,
  });

  final DomainAxis domainAxis;
  final ({int count, String? start}) viewport;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: domainAxis.tickLength,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final segmentSpace = maxLayoutWidth / viewport.count;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(viewport.count, (index) {
            return DrawTick(
              vertical: true,
              tickStyle: domainAxis.tickStyle.copyWith(width: segmentSpace),
            );
          }),
        );
      }),
    );
  }
}
