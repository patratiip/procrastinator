// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_state_data_changed.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/app_action.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';

/// {@template initialize_entry_adding_subscriptions_action}
/// [InitializeEntryAddingSubscriptionsAction] is an action that handles data from [IEntryAddingRepository].
/// {@endtemplate}

class InitializeEntryAddingSubscriptionsAction extends AppAction {
  final IEntryAddingRepository _entryAddingRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

/// {@macro initialize_entry_adding_subscriptions_action}
  InitializeEntryAddingSubscriptionsAction({
    required IEntryAddingRepository entryAddingRepository,
  }) : _entryAddingRepository = entryAddingRepository;

  @override
  Future<ReduxAppState?> reduce() async {
    /// Subscriptons initialization method
    void _initializeListeners() {
      _entrysListListener = _entryAddingRepository.entriesStream().listen(
        (entriesList) {
          dispatch(StateDataChangedAction(entriesList: entriesList));
        },
        cancelOnError: false,
      );

      _lectionListListener = _entryAddingRepository.lectionsStream().listen(
        (lectionsList) {
          dispatch(StateDataChangedAction(lectionsList: lectionsList));
        },
        cancelOnError: false,
      );

      /// Adding list of [Entry] stream subscription to store props
      setProp(
          "_entriesListListener_ReduxEntryAddingState", _entrysListListener);

      /// Adding list of [Lection] stream subscription to store props
      setProp(
          "_lectionListListener_ReduxEntryAddingState", _lectionListListener);
    }

    /// Subscriptons initialization
    _initializeListeners();

    return null;
  }
}
