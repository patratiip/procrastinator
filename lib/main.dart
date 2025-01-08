import 'dart:async';
import 'package:async_redux/async_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';
import 'package:procrastinator/src/core/utils/logger.dart';
import 'package:procrastinator/app_runner.dart';


////////////////////////////////////////////////////

// // Global AsyncRedux app state
// late Store<ReduxAppState> store;

// Global ServiceLocator
GetIt getIt = GetIt.instance;

////////////////////////////////////////////////////


void main() {
  runZonedGuarded(
    () => const AppRunner().initializeAndRun(),
    logger.logZoneError,
  );
}
