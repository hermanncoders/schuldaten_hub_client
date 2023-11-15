import 'package:flutter/foundation.dart';
import 'extensions.dart';

final debug = Debug();

class Debug {
  void success(String message) {
    debugPrint(message.logSuccess());
  }

  void warning(String message) {
    debugPrint(message.logWarning());
  }

  void error(String message) {
    debugPrint(message.logError());
  }

  void info(String message) {
    debugPrint(message.logInfo());
  }
}
