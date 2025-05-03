import 'package:flutter/material.dart';

import '../../axis/domain_axis.dart';
import '../../draw/tick_label.dart';
import 'domain_layout.dart';

class DomainLabelLayout<T> extends DomainLayout {
  const DomainLabelLayout({
    super.key,
    required super.domains,
    required super.domainAxis,
    super.vertically,
  });

  @override
  Widget build(BuildContext context) {
    final viewport =
        domainAxis.viewport ?? (start: domains.first, count: domains.length);
    final initialIndex = domains.indexWhere((e) => e == viewport.start);
    if (vertically) {
      return _DomainLabelVertically(
        domainAxis: domainAxis,
        viewport: viewport,
        domains: domains,
        initialIndex: initialIndex,
      );
    }
    return _DomainLabelHorizontally(
      domainAxis: domainAxis,
      viewport: viewport,
      domains: domains,
      initialIndex: initialIndex,
    );
  }
}

class _DomainLabelVertically extends StatelessWidget {
  const _DomainLabelVertically({
    required this.domainAxis,
    required this.viewport,
    required this.domains,
    required this.initialIndex,
  });

  final DomainAxis domainAxis;
  final ({int count, String? start}) viewport;
  final List<String?> domains;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxLayoutHeight = constraints.maxHeight;
      final segmentSpace = maxLayoutHeight / viewport.count;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(viewport.count, (index) {
          final label = domains[initialIndex + index];
          final labelText = DrawTickLabel(
            label: label,
            labelFormatter: domainAxis.labelFormatter,
            labelStyle: domainAxis.labelStyle,
          );
          return SizedBox(
            height: segmentSpace,
            child: Transform.translate(
              offset: domainAxis.labelOffset,
              child: Align(
                alignment: Alignment.center,
                child: domainAxis.labelWidget != null
                    ? domainAxis.labelWidget!(label) ?? labelText
                    : labelText,
              ),
            ),
          );
        }),
      );
    });
  }
}

class _DomainLabelHorizontally extends StatelessWidget {
  const _DomainLabelHorizontally({
    required this.domainAxis,
    required this.viewport,
    required this.domains,
    required this.initialIndex,
  });

  final DomainAxis domainAxis;
  final ({int count, String? start}) viewport;
  final List<String?> domains;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: domainAxis.xAxisLabelSpace,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxLayoutWidth = constraints.maxWidth;
        final segmentSpace = maxLayoutWidth / viewport.count;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(viewport.count, (index) {
            final label = domains[initialIndex + index];
            final labelText = DrawTickLabel(
              label: label,
              labelFormatter: domainAxis.labelFormatter,
              labelStyle: domainAxis.labelStyle,
            );
            return SizedBox(
              width: segmentSpace,
              child: Transform.translate(
                offset: domainAxis.labelOffset,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: domainAxis.labelWidget != null
                      ? domainAxis.labelWidget!(label) ?? labelText
                      : labelText,
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
