import 'package:flutter/material.dart';

/// A utility class to assist with responsive layout design.
/// Provides methods to determine screen size categories and calculate sizes.
class ResponsiveHelper {
  /// The BuildContext to access screen dimensions.
  final BuildContext context;

  /// Constructor requiring a BuildContext.
  ResponsiveHelper(this.context);

  /// Returns the screen width in logical pixels.
  double get screenWidth => MediaQuery.of(context).size.width;

  /// Returns the screen height in logical pixels.
  double get screenHeight => MediaQuery.of(context).size.height;

  /// Determines if the screen is considered small (e.g., mobile).
  bool get isSmall => screenWidth < 600;

  /// Determines if the screen is considered medium (e.g., tablet).
  bool get isMedium => screenWidth >= 600 && screenWidth < 1200;

  /// Determines if the screen is considered large (e.g., desktop).
  bool get isLarge => screenWidth >= 1200;

  /// Calculates a responsive size based on a percentage of screen width.
  double widthPercentage(double percentage) => screenWidth * (percentage / 100);

  /// Calculates a responsive size based on a percentage of screen height.
  double heightPercentage(double percentage) => screenHeight * (percentage / 100);
}