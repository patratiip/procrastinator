// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/app_action.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';

/// {@template close_entry_adding_subscriptions_action}
/// [CloseEntryAddingSubscriptionsAction] is an action that closing stream subscriptions from [IEntryAddingRepository].
/// {@endtemplate}

class CloseEntryAddingSubscriptionsAction extends AppAction {
  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  /// {@macro close_entry_adding_subscriptions_action}
  CloseEntryAddingSubscriptionsAction();

  @override
  Future<ReduxAppState?> reduce() async {
    /// Subscriptons closing method
    void _closeListeners() {
      /// Getting [Entry] steam subscription from store.prop
      _entrysListListener = prop<StreamSubscription<List<Entry>?>>(
          "_entriesListListener_ReduxEntryAddingState");

      /// Getting [Lection] steam subscription from store.prop
      _lectionListListener = prop<StreamSubscription<List<Lection>?>>(
          "_lectionListListener_ReduxEntryAddingState");

      /// Closing steam subscriptions from store.prop
      _entrysListListener.cancel();
      _lectionListListener.cancel();
      log('EntryAdding feature listeners are closed');

      store.props.remove("_entriesListListener_ReduxEntryAddingState");
      store.props.remove("_lectionListListener_ReduxEntryAddingState");
    }

    /// Subscriptons closing
    _closeListeners();

    return null;
  }
}
