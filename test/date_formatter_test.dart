import 'package:flutter_test/flutter_test.dart';
import 'package:commonkit/src/helpers/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    // Test formatDate
    test('formatDate returns formatted date string', () {
      final date = DateTime(2023, 10, 26);
      expect(DateFormatter.formatDate(date, pattern: 'dd/MM/yyyy'), '26/10/2023');
      expect(DateFormatter.formatDate(date, pattern: 'yyyy-MM-dd'), '2023-10-26');
      expect(DateFormatter.formatDate(date, pattern: 'MMM dd, yyyy'), 'Oct 26, 2023');
    });

    // Test timeAgo
    test('timeAgo returns correct time difference', () {
      final now = DateTime.now();
      expect(DateFormatter.timeAgo(now.subtract(const Duration(seconds: 5))), 'Just now');
      expect(DateFormatter.timeAgo(now.subtract(const Duration(minutes: 1))), '1 minute ago');
      expect(DateFormatter.timeAgo(now.subtract(const Duration(minutes: 30))), '30 minutes ago');
      expect(DateFormatter.timeAgo(now.subtract(const Duration(hours: 1))), '1 hour ago');
      expect(DateFormatter.timeAgo(now.subtract(const Duration(hours: 15))), '15 hours ago');
      expect(DateFormatter.timeAgo(now.subtract(const Duration(days: 1))), '1 day ago');
      expect(DateFormatter.timeAgo(now.subtract(const Duration(days: 4))), '4 days ago');
      expect(DateFormatter.timeAgo(now.subtract(const Duration(days: 30))), '1 month ago');
      expect(DateFormatter.timeAgo(now.subtract(const Duration(days: 365))), '1 year ago');
    });
  });
}
