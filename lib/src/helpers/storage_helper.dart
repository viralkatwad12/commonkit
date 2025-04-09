import 'package:shared_preferences/shared_preferences.dart';

/// A helper class for managing key-value storage using shared preferences.
/// Simplifies reading, writing, and removing persistent data.
class StorageHelper {
  /// Internal instance of SharedPreferences.
  static Future<SharedPreferences>? _prefs;

  /// Initializes the SharedPreferences instance.
  static Future<void> init() async {
    _prefs = SharedPreferences.getInstance();
  }

  /// Writes a [value] to storage with the given [key].
  static Future<void> write(String key, dynamic value) async {
    final prefs = await (_prefs ?? SharedPreferences.getInstance());
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else {
      throw UnsupportedError('Type ${value.runtimeType} is not supported');
    }
  }

  /// Reads a value from storage for the given [key].
  /// Returns null if the key doesn’t exist.
  static Future<dynamic> read(String key) async {
    final prefs = await (_prefs ?? SharedPreferences.getInstance());
    return prefs.get(key);
  }

  /// Removes a value from storage for the given [key].
  static Future<void> remove(String key) async {
    final prefs = await (_prefs ?? SharedPreferences.getInstance());
    await prefs.remove(key);
  }

  /// Clears all stored data.
  static Future<void> clear() async {
    final prefs = await (_prefs ?? SharedPreferences.getInstance());
    await prefs.clear();
  }
}