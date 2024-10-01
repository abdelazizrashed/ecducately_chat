import 'package:flutter/material.dart';

/// This service could be used to log error to something like crashlytics.
/// Write now I am just logging errors and updates in case of debug
class AppLogger {
  static void error({
    required String tag,
    required dynamic value,
  }) {
    _prettyPrint(
      tag: tag,
      value: value,
      type: LogType.error,
    );
  }

  static void info({
    required String tag,
    required dynamic value,
  }) {
    _prettyPrint(
      tag: tag,
      value: value,
    );
  }

  static void _prettyPrint({
    required String tag,
    required dynamic value,
    LogType type = LogType.info,
  }) {
    switch (type) {
      case LogType.statusCode:
        {
          debugPrint('\x1B[33m${"💎 STATUS CODE $tag: $value"}\x1B[0m');
          break;
        }
      case LogType.info:
        {
          debugPrint('\x1B[32m${"⚡ INFO $tag: $value"}\x1B[0m');
          break;
        }
      case LogType.error:
        {
          debugPrint('\x1B[31m${"🚨 ERROR $tag: $value"}\x1B[0m');
          break;
        }
      case LogType.response:
        {
          debugPrint('\x1B[36m${"💡 RESPONSE $tag: $value"}\x1B[0m');
          break;
        }
      case LogType.url:
        {
          debugPrint('\x1B[34m${"📌 URL $tag: $value"}\x1B[0m');
          break;
        }
    }
  }
}

enum LogType {
  error,
  info,
  url,
  response,
  statusCode,
}
