import 'package:flutter/material.dart';

/// A helper class to create simple animations like fade and slide.
/// Wraps AnimationController setup for ease of use.
class AnimationHelper {
  /// Fades in a [child] widget over the specified [duration].
  static Widget fadeIn({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeIn,
  }) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: duration,
      curve: curve,
      child: child,
    );
  }

  /// Slides a [child] widget into view from a specified [offset].
  static Widget slideIn({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Offset beginOffset = const Offset(0.0, 1.0), // From bottom
  }) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: beginOffset, end: Offset.zero),
      duration: duration,
      curve: curve,
      builder: (context, offset, child) => Transform.translate(
        offset: offset,
        child: child,
      ),
      child: child,
    );
  }
}