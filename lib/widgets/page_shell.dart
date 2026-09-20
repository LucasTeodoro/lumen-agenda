import 'package:flutter/material.dart';

class PageShell extends StatelessWidget {
  const PageShell({
    super.key,
    required this.child,
    this.maxWidth,
  });

  final Widget child;
  final double? maxWidth;

  static double widthFor(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) {
      return 760;
    }
    if (width >= 800) {
      return 620;
    }
    return double.infinity;
  }

  static EdgeInsets paddingFor(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width >= 800 ? 32.0 : 20.0;
    return EdgeInsets.fromLTRB(horizontal, 16, horizontal, 28);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? widthFor(context)),
        child: child,
      ),
    );
  }
}
