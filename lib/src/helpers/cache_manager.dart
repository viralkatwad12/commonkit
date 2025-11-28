import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Clears all cached data. Intended for testing purposes.
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  Future<void> set(String key, dynamic value, {Duration? duration}) async {
    final cacheData = {
      'data': value,
      'expiry': duration != null ? DateTime.now().add(duration).toIso8601String() : null,
    };
    await _prefs.setString(key, jsonEncode(cacheData));
  }

  Future<T?> get<T>(String key) async {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;

    final cacheData = jsonDecode(jsonString);
    final expiryString = cacheData['expiry'] as String?;

    if (expiryString != null) {
      final expiry = DateTime.parse(expiryString);
      if (expiry.isBefore(DateTime.now())) {
        await _prefs.remove(key); // Remove expired cache
        return null;
      }
    }

    return cacheData['data'] as T?;
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
