import 'package:flutter/material.dart';

/// A utility class to assist with responsive layout design.
/// Provides methods to determine screen size categories and calculate sizes.
class ResponsiveHelper {
  static late final ResponsiveHelper _instance;
  final BuildContext _context;

  // Private constructor
  ResponsiveHelper._internal(this._context);

  /// Initializes the ResponsiveHelper with a BuildContext.
  /// Must be called once in the app's lifecycle (e.g., in the main widget).
  static void init(BuildContext context) {
    _instance = ResponsiveHelper._internal(context);
  }

  /// Provides access to the singleton instance of ResponsiveHelper.
  static ResponsiveHelper get instance => _instance;

  double get screenWidth => MediaQuery.of(_context).size.width;
  double get screenHeight => MediaQuery.of(_context).size.height;

  bool get isSmall => screenWidth < 600;
  bool get isMedium => screenWidth >= 600 && screenWidth < 1200;
  bool get isLarge => screenWidth >= 1200;

  T value<T>({required T small, required T medium, required T large}) {
    if (isSmall) return small;
    if (isMedium) return medium;
    return large;
  }

  double widthPercentage(double percentage) => screenWidth * (percentage / 100);
  double heightPercentage(double percentage) => screenHeight * (percentage / 100);

  Orientation get orientation => MediaQuery.of(_context).orientation;

  /// Defines custom breakpoints for responsive design.
  T breakpoint<T>(Map<double, T> breakpoints, T defaultValue) {
    final screenWidth = this.screenWidth;
    for (final breakpoint in breakpoints.keys) {
      if (screenWidth < breakpoint) {
        return breakpoints[breakpoint]!;
      }
    }
    return defaultValue;
  }
}