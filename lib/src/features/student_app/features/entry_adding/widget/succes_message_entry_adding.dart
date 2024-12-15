import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/calendar_entry_adding_bloc/calendar_entry_adding_bloc.dart';

/// {@template succes_message_entry_adding_widget}
/// [SuccesMessageEntryAddingWidget] shows succes by entry adding process.
/// {@endtemplate}
class SuccesMessageEntryAddingWidget extends StatelessWidget {
  /// {@macro succes_message_entry_adding_widget}
  const SuccesMessageEntryAddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarEntryAddingBloc, CalendarEntryAddingState>(
        builder: (context, state) {
      if (state.status == CalendarStateStatus.allDone) {
        return Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            color: MyAppColorScheme.sucsessColor,
            child: Text(
              Localization.of(context).allEntriesAddedSuccessMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    //fontWeight: FontWeight.w500
                  ),
            ));
      } else {
        return const SizedBox(
            // height: 24
            );
      }
    });
  }
}
