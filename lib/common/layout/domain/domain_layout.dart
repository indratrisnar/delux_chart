import 'package:flutter/material.dart';

import '../../axis/domain_axis.dart';

abstract class DomainLayout extends StatelessWidget {
  const DomainLayout({
    super.key,
    required this.domains,
    required this.domainAxis,
    this.vertically = false,
  });

  final List<String?> domains;
  final DomainAxis domainAxis;
  final bool vertically;
}
