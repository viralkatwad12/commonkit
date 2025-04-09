import 'package:flutter/material.dart';

/// Extensions on BuildContext to provide quick access to common properties.
/// Simplifies getting screen size and theme data in widgets.
extension ContextExtensions on BuildContext {
  /// Returns the width of the screen in logical pixels.
  /// Useful for responsive layouts.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the height of the screen in logical pixels.
  /// Helpful for positioning or sizing widgets.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns the current ThemeData for the app.
  /// Provides access to colors, typography, and more.
  ThemeData get theme => Theme.of(this);

  /// Returns the current TextTheme from the app's theme.
  /// Makes it easy to apply consistent text styles.
  TextTheme get textTheme => theme.textTheme;
}