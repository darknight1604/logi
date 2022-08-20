import 'package:logger/logger.dart';

class Log {
  Log._();
  static final _logger = Logger();

  static void debug(String tag, String message) {
    if (_isDeveloperMode()) {
      _logger.d("$tag: $message");
    }
  }

  static void info(String tag, String message) {
    if (_isDeveloperMode()) {
      _logger.i("$tag: $message");
    }
  }

  static Future<void> error(String tag, String message) async {
    if (_isDeveloperMode()) {
      _logger.e("$tag: $message");
      return;
    }
  }

  static bool _isDeveloperMode() => true;
}
