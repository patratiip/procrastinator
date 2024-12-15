import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_button_bloc/entry_adding_button_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/widget/dropdown_entry_type.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/widget/button_entry_adding.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/widget/error_message_entry_adding.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/widget/calendar_entry_adding.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/widget/succes_message_entry_adding.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template entry_adding_widget}
/// [EntryAddingWidget] that shows all other entry adding widgets.
/// {@endtemplate}
class EntryAddingWidget extends StatelessWidget {
  /// {@macro entry_adding_widget}
  const EntryAddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EntryAddingButtonBloc, EntryAddingButtonState>(
      listenWhen: (previous, current) =>
          previous != CalendarEntryAddingButtonSuccess,
      listener: (context, state) {
        if (state is CalendarEntryAddingButtonSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              elevation: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: MyAppColorScheme.sucsessColor,
              content: Container(
                width: double.infinity,
                height: 38,
                decoration:
                    const BoxDecoration(color: MyAppColorScheme.sucsessColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: AnimateIcon(
                          key: UniqueKey(),
                          onTap: () {},
                          iconType: IconType.continueAnimation,
                          height: 50,
                          width: 50,
                          color: Colors.white,
                          animateIcon: AnimateIcons.upload),
                    ),
                    Text(
                        Localization.of(context)
                            .entrySuccessfulAddedCalendarMessage,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
          );
        }
        // if (state.status == CalendarStateStatus.error) {
        //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
        // }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            // height: 400,
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
                  ErrorMessageCalendarWidget(),
                  SuccesMessageEntryAddingWidget(),
                  EntryAddingButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
