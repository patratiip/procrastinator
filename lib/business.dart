import 'package:async_redux/async_redux.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';

class Business {
  static late Store<ReduxAppState> store;

  static Future<void> init() async {
    store = Store<ReduxAppState>(
      initialState: ReduxAppState.initialState(),
    );
  }
}
