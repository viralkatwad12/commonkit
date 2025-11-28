import 'package:intl/intl.dart';

/// A utility class for formatting dates and times in a human-readable way.
/// Useful for displaying timestamps or dates in app UIs.
class DateFormatter {
  /// Formats a [date] into a string using the specified [pattern].
  /// Defaults to 'dd/MM/yyyy' (e.g., 04/04/2025).
  static String formatDate(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
    // Use the intl package to format the date according to the pattern
    return DateFormat(pattern).format(date);
  }

  /// Converts a [date] into a "time ago" string (e.g., "2 hours ago").
  /// Makes it easy to show relative time for recent events.
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours hour${hours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 30) {
      final days = difference.inDays;
      return '$days day${days == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }
}
