import 'package:flutter/services.dart';

/// A utility class to manage clipboard operations.
/// Simplifies copying and pasting text.
class ClipboardManager {
  /// Copies [text] to the clipboard.
  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  /// Retrieves text from the clipboard.
  /// Returns null if no text is available.
  static Future<String?> paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }
}