import 'package:flutter/material.dart';
import '../config/theme_config.dart';
import 'custom_button.dart';

/// Displays a customizable dialog with title, content, and buttons.
/// Styled with CommonKitTheme for consistency.
void showCustomDialog(
    BuildContext context, {
      required String title,
      required String content,
      String positiveText = 'OK',
      String? negativeText,
      VoidCallback? onPositive,
      VoidCallback? onNegative,
      CommonKitTheme theme = const CommonKitTheme(),
    }) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: theme.backgroundColor,
      title: Text(
        title,
        style: TextStyle(color: theme.textColor),
      ),
      content: Text(
        content,
        style: TextStyle(color: theme.secondaryTextColor),
      ),
      actions: [
        if (negativeText != null)
          CustomButton(
            text: negativeText,
            onPressed: onNegative ?? () => Navigator.pop(context),
            theme: theme,
          ),
        CustomButton(
          text: positiveText,
          onPressed: onPositive ?? () => Navigator.pop(context),
          theme: theme,
        ),
      ],
    ),
  );
}