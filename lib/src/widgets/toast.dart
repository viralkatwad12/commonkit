import 'package:flutter/material.dart';
import '../config/theme_config.dart';

/// Displays a short-lived toast notification at the bottom of the screen.
/// Styled with CommonKitTheme for consistency.
void showToast(
    BuildContext context, {
      required String message,
      Duration duration = const Duration(seconds: 2),
      CommonKitTheme theme = const CommonKitTheme(),
    }) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50.0,
      left: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        color: theme.neutralColor.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            message,
            style: TextStyle(color: theme.textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);
  Future.delayed(duration, () => entry.remove());
}