/// Extensions on the String class to add common text manipulation methods.
/// Simplifies tasks like formatting text for display in UI components.
extension StringExtensions on String {
  /// Capitalizes the first letter of the string and lowercases the rest.
  /// Useful for formatting titles or names consistently.
  String capitalize() {
    // Return unchanged if the string is empty
    if (isEmpty) return this;
    // Take the first character, uppercase it, and lowercase the rest
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Shortens the string to [maxLength] and adds an [ellipsis] if truncated.
  /// Great for displaying previews of long text in limited space.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    // Return unchanged if the string is already short enough
    if (length <= maxLength) return this;
    // Take the first [maxLength] characters and append the ellipsis
    return '${substring(0, maxLength)}$ellipsis';
  }
}