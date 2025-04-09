import 'dart:convert';
import 'logger.dart';

/// A utility class to serialize and deserialize JSON data with error handling.
/// Simplifies converting objects to/from JSON strings.
class DataSerializer {
  /// Serializes a Dart object to a JSON string.
  static String serialize(dynamic data) {
    try {
      return jsonEncode(data);
    } catch (e, stackTrace) {
      Logger.error('Serialization failed', e, stackTrace);
      throw Exception('Failed to serialize data: $e');
    }
  }

  /// Deserializes a JSON string to a Dart object.
  static dynamic deserialize(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e, stackTrace) {
      Logger.error('Deserialization failed', e, stackTrace);
      throw Exception('Failed to deserialize data: $e');
    }
  }
}