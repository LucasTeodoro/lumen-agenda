import 'package:flutter/material.dart';

import '../theme/lumen_theme.dart';

class LumenButton extends StatelessWidget {
  const LumenButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = LumenButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final LumenButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final primary = variant == LumenButtonVariant.primary;
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Material(
        color: primary ? LumenColors.primary : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LumenTheme.radius),
          side: primary
              ? BorderSide.none
              : const BorderSide(color: LumenColors.border),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(LumenTheme.radius),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: primary ? LumenColors.primaryForeground : LumenColors.text,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum LumenButtonVariant { primary, outline }
