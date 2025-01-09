import 'package:async_redux/async_redux.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';

/// {@template app_action}
/// Abstract class serve to simplify wor with Actions [AppAction].
/// {@endtemplate}

abstract class AppAction extends ReduxAction<ReduxAppState> {}
/// {@macro app_action}