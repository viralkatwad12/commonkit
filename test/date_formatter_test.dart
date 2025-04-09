import 'package:flutter_test/flutter_test.dart';
import 'package:commonkit/src/helpers/date_formatter.dart';

void main() {
  test('formatDate works correctly', () {
    // Test formatting a specific date
    final date = DateTime(2025, 4, 4);
    expect(DateFormatter.formatDate(date), '04/04/2025');
  });

  test('timeAgo works correctly', () {
    // Test current time
    final now = DateTime.now();
    expect(DateFormatter.timeAgo(now), 'Just now');
    // Test time 2 hours ago
    expect(DateFormatter.timeAgo(now.subtract(const Duration(hours: 2))).contains('hours ago'), true);
  });
}