import 'dart:developer' as dev;

class AppLogger {
  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    dev.log(message, error: error, stackTrace: stackTrace, level: 1000);
  }
}
