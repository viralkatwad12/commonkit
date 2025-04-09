import 'package:flutter/material.dart';

/// Configuration class for customizing CommonKit widget themes.
/// Provides a comprehensive set of colors for all common UI states and components.
class CommonKitTheme {
  /// Primary color for main UI elements (e.g., buttons, highlights).
  final Color primaryColor;

  /// Secondary color for supporting UI elements (e.g., secondary buttons).
  final Color secondaryColor;

  /// Accent color for emphasis or highlights (e.g., active states).
  final Color accentColor;

  /// Background color for widgets like overlays or snackbars.
  final Color backgroundColor;

  /// Success color for positive feedback (e.g., completed actions).
  final Color successColor;

  /// Error color for negative feedback (e.g., validation failures).
  final Color errorColor;

  /// Warning color for cautionary feedback (e.g., potential issues).
  final Color warningColor;

  /// Neutral color for subtle elements (e.g., borders, disabled states).
  final Color neutralColor;

  /// Text color for primary text content.
  final Color textColor;

  /// Text color for secondary or muted text.
  final Color secondaryTextColor;

  /// Color of the loading overlay background.
  /// Defaults to semi-transparent black for a subtle overlay effect.
  final Color loadingOverlayColor;

  /// Color of the loading spinner.
  /// Defaults to primaryColor if not set.
  final Color? loadingSpinnerColor;

  /// Background color for snackbars.
  /// Defaults to neutralColor if not set.
  final Color? snackbarBackgroundColor;

  /// Text style for snackbars, including color.
  /// Defaults to textColor if not specified.
  final TextStyle? snackbarTextStyle;

  /// Constructor for CommonKitTheme with default values.
  /// All parameters are optional, with sensible defaults for flexibility.
  const CommonKitTheme({
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.accentColor = Colors.blueAccent,
    this.backgroundColor = Colors.white,
    this.successColor = Colors.green,
    this.errorColor = Colors.red,
    this.warningColor = Colors.orange,
    this.neutralColor = Colors.grey,
    this.textColor = Colors.black,
    this.secondaryTextColor = Colors.grey,
    this.loadingOverlayColor = const Color(0x80000000), // Semi-transparent black
    this.loadingSpinnerColor,
    this.snackbarBackgroundColor,
    this.snackbarTextStyle,
  });
}