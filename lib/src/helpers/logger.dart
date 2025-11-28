import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../config/global_config.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

abstract class LogOutput {
  void write(String message);
}

class ConsoleOutput extends LogOutput {
  @override
  void write(String message) {
    debugPrint(message);
  }
}

class FileOutput extends LogOutput {
  final File file;

  FileOutput(this.file);

  @override
  void write(String message) {
    file.writeAsStringSync('$message\n', mode: FileMode.append);
  }
}

class LogFormatter {
  String format(LogLevel level, String message, DateTime timestamp) {
    final levelStr = level.toString().split('.').last;
    final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
    return '[$levelStr] [$formattedTimestamp] $message';
  }
}

class Logger {
  static final Logger _instance = Logger._internal();
  factory Logger() => _instance;

  Logger._internal() {
    _outputs.add(ConsoleOutput());
    // In a real app, you might want to configure a FileOutput as well
    // _outputs.add(FileOutput(File('app.log')));
  }

  final List<LogOutput> _outputs = [];
  LogLevel _logLevel = GlobalConfig().isDebugMode ? LogLevel.debug : LogLevel.info;
  final LogFormatter _formatter = LogFormatter();

  /// Clears all registered log outputs. Intended for testing purposes.
  void clearOutputs() {
    _outputs.clear();
  }

  void setLevel(LogLevel level) {
    _logLevel = level;
  }

  void addOutput(LogOutput output) {
    _outputs.add(output);
  }

  void log(LogLevel level, String message) {
    if (level.index >= _logLevel.index) {
      final formattedMessage = _formatter.format(level, message, DateTime.now());
      for (final output in _outputs) {
        output.write(formattedMessage);
      }
    }
  }

  void debug(String message) => log(LogLevel.debug, message);
  void info(String message) => log(LogLevel.info, message);
  void warning(String message) => log(LogLevel.warning, message);
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    log(LogLevel.error, '$message\nError: $error\nStackTrace: $stackTrace');
  }
}
