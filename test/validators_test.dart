import 'package:flutter_test/flutter_test.dart';
import 'package:commonkit/src/helpers/validators.dart';

void main() {
  /// Group of tests for the Validators class.
  group('Validators', () {
    test('email validates correctly', () {
      // Test a valid email
      expect(Validators.email('test@example.com'), null);
      // Test an invalid email
      expect(Validators.email('invalid'), isNotNull);
      // Test an empty email
      expect(Validators.email(''), isNotNull);
    });

    test('required field validates correctly', () {
      // Test a non-empty value
      expect(Validators.required('text'), null);
      // Test an empty value
      expect(Validators.required(''), isNotNull);
      // Test a null value
      expect(Validators.required(null), isNotNull);
    });
  });
}