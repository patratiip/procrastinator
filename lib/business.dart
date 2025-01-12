import 'package:async_redux/async_redux.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';

/// {@template business}
/// [Business] is a class that needet to initialize AsyncRedux store.
/// {@endtemplate}

class Business {
  static late Store<ReduxAppState> store;

  /// {@macro business}

  /// Initialize AsyncRedux [Store] and set initial [ReduxAppState]
  static Future<void> init() async {
    store = Store<ReduxAppState>(
      initialState: ReduxAppState.initialState(),
    );
  }
}
