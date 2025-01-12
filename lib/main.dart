import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/core/utils/logger.dart';
import 'package:procrastinator/app_runner.dart';


// Global ServiceLocator instance
GetIt getIt = GetIt.instance;


void main() {
  runZonedGuarded(
    () => const AppRunner().initializeAndRun(),
    logger.logZoneError,
  );
}
