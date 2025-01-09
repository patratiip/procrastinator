import 'package:animated_icon/animated_icon.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/main.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_add_entry.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_close_subscriptions.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_initialize_subscriptions.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';

import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/widget/dropdown_entry_type.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/widget/button_entry_adding.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/widget/message_entry_adding.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/widget/calendar_entry_adding.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template entry_adding_widget}
/// [EntryAddingWidget] that shows all other entry adding widgets.
/// {@endtemplate}
class EntryAddingWidget extends StatelessWidget {
  /// {@macro entry_adding_widget}
  const EntryAddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // if (!context.isFailed(AddEntryAction)) {
    //         ScaffoldMessenger.of(context).clearSnackBars();
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(
    //             duration: const Duration(seconds: 5),
    //             elevation: 40,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //             behavior: SnackBarBehavior.floating,
    //             backgroundColor: MyAppColorScheme.sucsessColor,
    //             content: Container(
    //               width: double.infinity,
    //               height: 38,
    //               decoration:
    //                   const BoxDecoration(color: MyAppColorScheme.sucsessColor),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(right: 12),
    //                     child: AnimateIcon(
    //                         key: UniqueKey(),
    //                         onTap: () {},
    //                         iconType: IconType.continueAnimation,
    //                         height: 50,
    //                         width: 50,
    //                         color: Colors.white,
    //                         animateIcon: AnimateIcons.upload),
    //                   ),
    //                   Text(
    //                       Localization.of(context)
    //                           .entrySuccessfulAddedCalendarMessage,
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .labelLarge!
    //                           .copyWith(color: Colors.white)),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       }
    return StoreConnector(
        onInit: (store) {
          store.dispatch(InitializeEntryAddingSubscriptionsAction(
              entryAddingRepository: getIt<IEntryAddingRepository>()));
        },
        onDispose: (store) {
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
