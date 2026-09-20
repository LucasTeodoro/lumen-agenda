import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/lumen_theme.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: padding ?? const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: LumenColors.glass,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: LumenColors.glassBorder),
          ),
          child: child,
        ),
      ),
    );
  }
}
