import 'package:flutter/material.dart';
import '../config/theme_config.dart';

/// A widget that displays a full-screen loading overlay when active.
/// Shows a spinner over a semi-transparent background with customizable colors.
class LoadingOverlay extends StatelessWidget {
  /// Determines whether the loading overlay is visible.
  /// If true, shows the overlay; if false, renders an empty space.
  final bool isLoading;

  /// Theme configuration for customizing the overlay's appearance.
  /// Uses CommonKitTheme to set colors like overlay and spinner.
  final CommonKitTheme theme;

  /// Constructor for LoadingOverlay.
  /// Requires [isLoading] and optionally takes a [theme].
  const LoadingOverlay({
    required this.isLoading,
    this.theme = const CommonKitTheme(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Return the overlay if isLoading is true, otherwise return an empty widget
    return isLoading
        ? Container(
      // Use the theme's loadingOverlayColor for the background
      color: theme.loadingOverlayColor,
      // Center the loading spinner in the overlay
      child: Center(
        child: CircularProgressIndicator(
          // Use the theme's loadingSpinnerColor, falling back to primaryColor
          color: theme.loadingSpinnerColor ?? theme.primaryColor,
        ),
      ),
    )
        : const SizedBox.shrink(); // Empty widget to take no space
  }
}