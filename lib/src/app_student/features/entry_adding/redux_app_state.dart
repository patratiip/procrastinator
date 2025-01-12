// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:procrastinator/src/app_student/features/entry_adding/redux_entry_adding_state/redux_entry_adding_state.dart';

/// {@template redux_app_state}
/// Global App state [ReduxAppState].
/// {@endtemplate}

class ReduxAppState {
  final ReduxEntryAddingState reduxEntryAddingState;

  /// Creating initial state of [ReduxAppState]
  static ReduxAppState initialState() => ReduxAppState(
      reduxEntryAddingState: ReduxEntryAddingState.initialState());

  /// {@macro redux_app_state}
  ReduxAppState({
    required this.reduxEntryAddingState,
  });

  /// Returns copy of [ReduxAppState]
  ReduxAppState copy({
    ReduxEntryAddingState? reduxEntryAddingState,
  }) {
    return ReduxAppState(
      reduxEntryAddingState:
          reduxEntryAddingState ?? this.reduxEntryAddingState,
    );
  }

  @override
  bool operator ==(covariant ReduxAppState other) {
    if (identical(this, other)) return true;

    return other.reduxEntryAddingState == reduxEntryAddingState;
  }

  @override
  int get hashCode => reduxEntryAddingState.hashCode;

  @override
  String toString() =>
      'ReduxAppState(reduxEntryAddingState: $reduxEntryAddingState)';
}
