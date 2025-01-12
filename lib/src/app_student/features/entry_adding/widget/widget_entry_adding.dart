import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/main.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_close_subscriptions.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_initialize_subscriptions.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';

import 'package:procrastinator/src/app_student/features/entry_adding/widget/dropdown_entry_type.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/widget/button_entry_adding.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/widget/message_entry_adding.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/widget/calendar_entry_adding.dart';

/// {@template entry_adding_widget}
/// [EntryAddingWidget] that shows all other entry adding widgets.
/// {@endtemplate}
class EntryAddingWidget extends StatelessWidget {
  /// {@macro entry_adding_widget}
  const EntryAddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        onInit: (store) {
          /// Subscriptons initialization
          store.dispatch(InitializeEntryAddingSubscriptionsAction(
              entryAddingRepository: getIt<IEntryAddingRepository>()));
        },
        onDispose: (store) {
          /// Subscriptons closing
          store.dispatch(CloseEntryAddingSubscriptionsAction());
        },
        vm: () => Factory(this),
        builder: (context, vm) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CalendarEntyAddingWidget(),
                      EntryTypeDropdownWidget(),
                      MessageCalendarWidget(),
                      EntryAddingButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

//TODO: Ask about ViewModels, when they're don't needed...
class ViewModel extends Vm {
  // final int counter;
  // final String description;
  // final VoidCallback onIncrement;

  ViewModel(
      //   {
      //   required this.counter,
      //   required this.description,
      //   required this.onIncrement,
      // }
      )
  // : super(
  //   equals: [counter, description]
  //   )
  ;
}

class Factory extends VmFactory<ReduxAppState, EntryAddingWidget, ViewModel> {
  Factory(connector) : super(connector);

  ViewModel fromStore() => ViewModel(
      // counter: state.counter,
      // description: state.description,
      // onIncrement: () => dispatch(IncrementAndGetDescriptionAction()),
      );
}
