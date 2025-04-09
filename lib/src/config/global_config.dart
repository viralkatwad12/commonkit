import 'package:flutter/material.dart';
import 'package:commonkit/src/helpers/storage_helper.dart';
import 'theme_config.dart';

/// A singleton class to manage global configuration data for the app.
/// Includes base URL, user credentials, and session state.
class GlobalConfig {
  static final GlobalConfig _instance = GlobalConfig._internal();

  factory GlobalConfig() => _instance;

  GlobalConfig._internal();

  String? _baseUrl;
  final Map<String, dynamic> _globalVariables = {};
  bool _isDebugMode = false;
  CommonKitTheme? _theme;

  // New fields for user session
  String? _username;
  String? _password;
  bool _rememberMe = false;
  bool _isLoggedIn = false;

  /// Initializes the global configuration and loads persisted data.
  Future<void> init({
    String? baseUrl,
    Map<String, dynamic>? variables,
    bool isDebugMode = false,
    CommonKitTheme? theme,
  }) async {
    await StorageHelper.init();
    _baseUrl = baseUrl;
    if (variables != null) _globalVariables.addAll(variables);
    _isDebugMode = isDebugMode;
    _theme = theme;

    // Load persisted user data
    _username = await StorageHelper.read('username') as String?;
    _password = await StorageHelper.read('password') as String?;
    _rememberMe = await StorageHelper.read('rememberMe') as bool? ?? false;
    _isLoggedIn = await StorageHelper.read('isLoggedIn') as bool? ?? false;
  }

  String? get baseUrl => _baseUrl;
  set baseUrl(String? value) => _baseUrl = value;

  dynamic getVariable(String key) => _globalVariables[key];
  void setVariable(String key, dynamic value) => _globalVariables[key] = value;
  void removeVariable(String key) => _globalVariables.remove(key);
  Map<String, dynamic> get allVariables => Map.unmodifiable(_globalVariables);

  bool get isDebugMode => _isDebugMode;
  set isDebugMode(bool value) => _isDebugMode = value;

  CommonKitTheme? get theme => _theme;
  set theme(CommonKitTheme? value) => _theme = value;

  // User session getters and setters
  String? get username => _username;
  set username(String? value) {
    _username = value;
    if (_rememberMe && value != null) StorageHelper.write('username', value);
  }

  String? get password => _password;
  set password(String? value) {
    _password = value;
    if (_rememberMe && value != null) StorageHelper.write('password', value);
  }

  bool get rememberMe => _rememberMe;
  set rememberMe(bool value) {
    _rememberMe = value;
    StorageHelper.write('rememberMe', value);
    if (!value) {
      StorageHelper.remove('username');
      StorageHelper.remove('password');
    }
  }

  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    StorageHelper.write('isLoggedIn', value);
  }

  void reset() {
    _baseUrl = null;
    _globalVariables.clear();
    _isDebugMode = false;
    _theme = null;
    _username = null;
    _password = null;
    _rememberMe = false;
    _isLoggedIn = false;
    StorageHelper.clear();
  }
}