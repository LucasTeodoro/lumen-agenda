import 'package:flutter/material.dart';

import '../theme/lumen_theme.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: LumenColors.card,
        borderRadius: BorderRadius.circular(LumenTheme.cardRadius),
        border: Border.all(color: LumenColors.border),
      ),
      child: child,
    );
  }
}
