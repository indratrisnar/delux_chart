import 'package:flutter/material.dart';

import '../../axis/domain_axis.dart';

abstract class DomainLayout<T> extends StatelessWidget {
  const DomainLayout({
    super.key,
    required this.domainAxis,
    required this.direction,
    required this.labelsInViewport,
  });

  final DomainAxis<T> domainAxis;
  final Axis direction;
  final List<T> labelsInViewport;

  Widget buildHorizontal();
  Widget buildVertical();

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) return buildHorizontal();
    return buildVertical();
  }

  int get tickCount => labelsInViewport.length;
}
