import 'package:flutter/foundation.dart' show kReleaseMode, debugPrint;
import 'package:logging/logging.dart';

final log = Logger('StatballApp');

void setupLogging() {
  if (kReleaseMode) {
    Logger.root.level = Level.OFF;
  } else {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      debugPrint(
        '[${record.level.name}] ${record.loggerName} - ${record.time}: ${record.message}',
      );

      if (record.error != null) {
        debugPrint('ERROR: ${record.error}');
      }
      if (record.stackTrace != null) {
        debugPrint('STACKTRACE:\n${record.stackTrace}');
      }
    });
  }
}
