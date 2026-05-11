import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Wraps a child with a scale-in animation.
class ScaleAnimation extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Curve curve;

  const ScaleAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.elasticOut,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .scale(
          duration: duration,
          curve: curve,
          begin: const Offset(0.6, 0.6),
          end: const Offset(1.0, 1.0),
        )
        .fadeIn(duration: duration ~/ 2);
  }
}