import 'package:flutter/material.dart';

class ScaleAnimation extends StatelessWidget {
  final Widget child;

  const ScaleAnimation({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1,
      duration: const Duration(milliseconds: 400),
      child: child,
    );
  }
}