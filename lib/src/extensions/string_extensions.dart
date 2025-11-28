/// Extensions on the String class to add common text manipulation methods.
/// Simplifies tasks like formatting text for display in UI components.
extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  /// Useful for formatting titles or names consistently.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Shortens the string to [maxLength] and adds an [ellipsis] if truncated.
  /// Great for displaying previews of long text in limited space.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    final truncatedLength = maxLength - ellipsis.length;
    if (truncatedLength <= 0) return ellipsis;
    return '${substring(0, truncatedLength)}$ellipsis';
  }
}