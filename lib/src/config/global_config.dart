import 'package:flutter/foundation.dart';
import 'theme_config.dart';

enum AppEnvironment {
  development,
  production,
}

/// A singleton class to manage global, non-user-specific configuration data.
/// This includes environment settings, API base URLs, and feature flags.
class GlobalConfig {
  static final GlobalConfig _instance = GlobalConfig._internal();
  factory GlobalConfig() => _instance;
  GlobalConfig._internal();

  late AppEnvironment environment;
  late Map<AppEnvironment, String> _baseUrls;
  final Map<String, dynamic> _globalVariables = {};
  bool isDebugMode = kDebugMode; // Default to Flutter's kDebugMode
  CommonKitTheme? theme;

  /// Initializes the global configuration.
  /// Must be called once on app startup.
  Future<void> init({
    required AppEnvironment environment,
    required Map<AppEnvironment, String> baseUrls,
    Map<String, dynamic>? variables,
    CommonKitTheme? theme,
  }) async {
    this.environment = environment;
    _baseUrls = baseUrls;
    if (variables != null) _globalVariables.addAll(variables);
    this.theme = theme;
  }

  String get baseUrl => _baseUrls[environment]!;

  dynamic getVariable(String key) => _globalVariables[key];
  void setVariable(String key, dynamic value) => _globalVariables[key] = value;
  void removeVariable(String key) => _globalVariables.remove(key);
  Map<String, dynamic> get allVariables => Map.unmodifiable(_globalVariables);

  /// Resets the configuration to a default state.
  void reset() {
    _globalVariables.clear();
    theme = null;
    // Note: Environment and baseUrls are not reset as they are fundamental
    // to the app's runtime configuration and should be explicitly re-initialized.
  }

  bool get isLoggedIn => _globalVariables.containsKey('token');
  String? get username => getVariable('username');
}
