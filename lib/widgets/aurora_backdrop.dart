import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/lumen_theme.dart';

class AuroraBackdrop extends StatelessWidget {
  const AuroraBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ColoredBox(
          color: LumenColors.background,
          child: SizedBox.expand(),
        ),
        const Positioned(
          top: -90,
          left: -50,
          child: _GlowBlob(color: LumenColors.violet, size: 280),
        ),
        const Positioned(
          top: 140,
          right: -80,
          child: _GlowBlob(color: LumenColors.teal, size: 260),
        ),
        const Positioned(
          bottom: -70,
          left: 30,
          child: _GlowBlob(color: LumenColors.pink, size: 300),
        ),
        child,
      ],
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 55, sigmaY: 55),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.42),
        ),
      ),
    );
  }
}
