import 'dart:async';
import 'package:procrastinator/src/core/utils/logger.dart';
import 'package:procrastinator/app_runner.dart';

void main() {
  runZonedGuarded(
    () => const AppRunner().initializeAndRun(),
    logger.logZoneError,
  );
}
