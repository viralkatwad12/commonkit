import '../config/global_config.dart';

/// A simple logging utility with levels, controlled by GlobalConfig debug mode.
/// Outputs messages to the console when debug mode is enabled.
class Logger {
  /// Logs an info-level message.
  static void info(String message) {
    if (GlobalConfig().isDebugMode) {
      print('[INFO] $message');
    }
  }

  /// Logs a warning-level message.
  static void warning(String message) {
    if (GlobalConfig().isDebugMode) {
      print('[WARNING] $message');
    }
  }

  /// Logs an error-level message.
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (GlobalConfig().isDebugMode) {
      print('[ERROR] $message');
      if (error != null) print('  Error: $error');
      if (stackTrace != null) print('  Stack: $stackTrace');
    }
  }
}