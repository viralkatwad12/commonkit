import 'package:flutter_test/flutter_test.dart';
import 'package:commonkit/src/extensions/string_extensions.dart';

void main() {
  test('capitalize works correctly', () {
    // Test lowercase input
    expect('hello'.capitalize(), 'Hello');
    // Test uppercase input
    expect('HELLO'.capitalize(), 'Hello');
    // Test empty string
    expect(''.capitalize(), '');
  });

  test('truncate works correctly', () {
    // Test truncation with ellipsis
    expect('hello world'.truncate(5), 'hello...');
    // Test no truncation needed
    expect('short'.truncate(10), 'short');
  });
}