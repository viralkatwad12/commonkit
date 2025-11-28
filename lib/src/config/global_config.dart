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

  late AppEnvironment _environment;
  late Map<AppEnvironment, String> _baseUrls;
  final Map<String, dynamic> _globalVariables = {};
  bool _isDebugMode = kDebugMode; // Default to Flutter's kDebugMode
  CommonKitTheme? _theme;

  /// Initializes the global configuration.
  /// Must be called once on app startup.
  Future<void> init({
    required AppEnvironment environment,
    required Map<AppEnvironment, String> baseUrls,
    Map<String, dynamic>? variables,
    CommonKitTheme? theme,
  }) async {
    _environment = environment;
    _baseUrls = baseUrls;
    if (variables != null) _globalVariables.addAll(variables);
    _theme = theme;
  }

  AppEnvironment get environment => _environment;
  String get baseUrl => _baseUrls[_environment]!;

  dynamic getVariable(String key) => _globalVariables[key];
  void setVariable(String key, dynamic value) => _globalVariables[key] = value;
  void removeVariable(String key) => _globalVariables.remove(key);
  Map<String, dynamic> get allVariables => Map.unmodifiable(_globalVariables);

  bool get isDebugMode => _isDebugMode;
  set isDebugMode(bool value) => _isDebugMode = value;

  CommonKitTheme? get theme => _theme;
  set theme(CommonKitTheme? value) => _theme = value;

  /// Resets the configuration to a default state.
  void reset() {
    _globalVariables.clear();
    _theme = null;
    // Note: Environment and baseUrls are not reset as they are fundamental
    // to the app's runtime configuration and should be explicitly re-initialized.
  }
}
