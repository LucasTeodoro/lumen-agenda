import 'package:flutter/material.dart';

import '../theme/lumen_theme.dart';

enum LumenButtonVariant { primary, outline, destructive }

class LumenButton extends StatelessWidget {
  const LumenButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = LumenButtonVariant.primary,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final LumenButtonVariant variant;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;
    final BorderSide side;

    switch (variant) {
      case LumenButtonVariant.primary:
        background = LumenColors.teal;
        foreground = LumenColors.primaryForeground;
        side = BorderSide.none;
      case LumenButtonVariant.outline:
        background = Colors.transparent;
        foreground = LumenColors.text;
        side = const BorderSide(color: LumenColors.border);
      case LumenButtonVariant.destructive:
        background = LumenColors.pink;
        foreground = LumenColors.text;
        side = BorderSide.none;
    }

    final button = SizedBox(
      height: 40,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LumenTheme.radius),
          side: side,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(LumenTheme.radius),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: foreground,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (!fullWidth) {
      return button;
    }
    return SizedBox(width: double.infinity, child: button);
  }
}
