import 'package:flutter/material.dart';

import '../theme/lumen_theme.dart';

class AuroraBackdrop extends StatelessWidget {
  const AuroraBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: LumenColors.background,
      child: child,
    );
  }
}
