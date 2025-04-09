import 'package:flutter/material.dart';
import '../config/theme_config.dart';

/// Displays a customizable snackbar with an optional icon and message.
/// Uses theme colors for background, text, and icons to match app style.
void showCustomSnackbar(
    BuildContext context, {
      required String message,
      IconData? icon,
      CommonKitTheme theme = const CommonKitTheme(),
    }) {
  // Use ScaffoldMessenger to show the snackbar in the app's widget tree
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // Build the snackbar content as a row with optional icon and text
      content: Row(
        children: [
          // Add an icon if provided, styled with the theme's text color
          if (icon != null) ...[
            Icon(
              icon,
              color: theme.snackbarTextStyle?.color ?? theme.textColor,
            ),
            const SizedBox(width: 8), // Space between icon and text
          ],
          // Expand the text to fill available space, applying the theme's style
          Expanded(
            child: Text(
              message,
              style: theme.snackbarTextStyle ??
                  TextStyle(color: theme.textColor),
            ),
          ),
        ],
      ),
      // Use the theme's snackbarBackgroundColor, falling back to neutralColor
      backgroundColor: theme.snackbarBackgroundColor ?? theme.neutralColor,
      // Display the snackbar for 3 seconds before auto-dismissing
      duration: const Duration(seconds: 3),
    ),
  );
}