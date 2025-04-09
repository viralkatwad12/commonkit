/// A utility class with static methods for validating user input.
/// Helps ensure data meets requirements before processing (e.g., in forms).
class Validators {
  /// Validates an email address string.
  /// Returns null if valid, or an error message if invalid or empty.
  static String? email(String? value) {
    // Check if the input is null or empty
    if (value == null || value.isEmpty) return 'Email is required';
    // Use a regex to check basic email format (e.g., user@domain.com)
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Invalid email format';
    }
    // Return null to indicate the input is valid
    return null;
  }

  /// Ensures a field is not empty.
  /// Returns null if the input has content, or an error message if empty.
  static String? required(String? value) {
    // Check if the input is null or empty
    if (value == null || value.isEmpty) return 'This field is required';
    // Return null to indicate the input is valid
    return null;
  }
}