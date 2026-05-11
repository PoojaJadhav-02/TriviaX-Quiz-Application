import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final Widget child;

  const FadeAnimation({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}