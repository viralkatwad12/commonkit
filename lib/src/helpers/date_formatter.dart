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
    // Get the current time for comparison
    final now = DateTime.now();
    // Calculate the difference between now and the given date
    final diff = now.difference(date);

    // Return "Just now" if less than a minute has passed
    if (diff.inMinutes < 1) return 'Just now';
    // Return minutes ago if less than an hour has passed
    if (diff.inHours < 1) return '${diff.inMinutes} minutes ago';
    // Return hours ago if less than a day has passed
    if (diff.inDays < 1) return '${diff.inHours} hours ago';
    // Otherwise, return the full formatted date
    return formatDate(date);
  }
}