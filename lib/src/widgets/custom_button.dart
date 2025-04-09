import 'package:flutter/material.dart';
import '../config/theme_config.dart';

/// A customizable button widget that uses CommonKitTheme for styling.
/// Supports text, icons, and various states (e.g., disabled).
class CustomButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// The callback when the button is pressed.
  final VoidCallback? onPressed;

  /// An optional icon to display before the text.
  final IconData? icon;

  /// Theme configuration for styling the button.
  final CommonKitTheme theme;

  /// Whether the button is disabled.
  final bool isDisabled;

  /// Constructor for CustomButton.
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.theme = const CommonKitTheme(),
    this.isDisabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? theme.neutralColor
            : theme.primaryColor, // Use theme colors
        foregroundColor: theme.textColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: theme.textColor),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(color: theme.textColor),
          ),
        ],
      ),
    );
  }
}