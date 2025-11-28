/// A utility class with static methods for validating user input.
/// Helps ensure data meets requirements before processing (e.g., in forms).
class Validators {
  /// Validates an email address string.
  /// Returns null if valid, or an error message if invalid or empty.
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) return 'Invalid email format';
    return null;
  }

  /// Ensures a field is not empty and meets a minimum length.
  /// Returns null if valid, or an error message if invalid.
  static String? required(String? value, {int minLength = 1, String? message}) {
    if (value == null || value.length < minLength) {
      return message ?? 'This field is required and must be at least $minLength characters long';
    }
    return null;
  }

  /// Validates a password based on length and complexity.
  /// Returns null if valid, or an error message if invalid.
  static String? password(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < minLength) return 'Password must be at least $minLength characters long';
    // Add more complexity checks as needed (e.g., uppercase, numbers, symbols)
    return null;
  }

  /// Validates if a string contains only numbers.
  /// Returns null if valid, or an error message if invalid.
  static String? number(String? value) {
    if (value == null || value.isEmpty) return 'A number is required';
    if (double.tryParse(value) == null) return 'Invalid number format';
    return null;
  }

  /// Validates a URL string.
  /// Returns null if valid, or an error message if invalid.
  static String? url(String? value) {
    if (value == null || value.isEmpty) return 'URL is required';
    final urlRegex = RegExp(
        r'^(?:http|https)?:\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])?$');
    if (!urlRegex.hasMatch(value)) return 'Invalid URL format';
    return null;
  }
}