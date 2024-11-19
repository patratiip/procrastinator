import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/bloc/calendar_bloc.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/calendar_entry_adding_button/bloc/calendar_entry_adding_button_bloc.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/calendar_error_message_widget/bloc/calendar_error_message_bloc.dart';

/// {@template error_message_calendar_widget}
/// Widget that shows error message in [CalendarEntryAddingWidget]
/// {@endtemplate}
class ErrorMessageCalendarWidget extends StatelessWidget {
  /// {@macro error_message_calendar_widget}
  const ErrorMessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CalendarBloc, CalendarState>(
          // listenWhen: (previous, current) => (previous != current),
          listener: (context, state) {
            if (state.status == CalendarStateStatus.error) {
              context.read<CalendarErrorMessageBloc>().add(
                  (EnableCalendarErrorMessageEvent(
                      errorType: state.errorType!)));
            } else {
              context
                  .read<CalendarErrorMessageBloc>()
                  .add((DisableCalendarErrorMessageEvent()));
            }
            log(state.toString());
          },
        ),
        BlocListener<CalendarEntryAddingButtonBloc,
            CalendarEntryAddingButtonState>(
          // listenWhen: (previous, current) => (previous != current),
          listener: (context, state) {
            if (state is CalendarEntryAddingButtonError) {
              context.read<CalendarErrorMessageBloc>().add(
                  (EnableCalendarErrorMessageEvent(
                      errorType: state.errorType)));
            } else if (state is CalendarEntryAddingButtonDistanceError) {
              context.read<CalendarErrorMessageBloc>().add(
                  (EnableCalendarErrorMessageEvent(
                      value: state.distance, errorType: state.errorType)));
            } else {
              context
                  .read<CalendarErrorMessageBloc>()
                  .add((DisableCalendarErrorMessageEvent()));
            }
          },
        ),
      ],
      child: BlocBuilder<CalendarErrorMessageBloc, CalendarErrorMessageState>(
          builder: (context, state) {
        if (state is CalendarErrorMessageDisabled) {
          return const SizedBox.shrink();
        } else {
          return Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            color: MyAppColorScheme.errorColor,
            child: Text(
              switch (state) {
                CalendarErrorMessageDisabled() => '',
                CalendarErrorMessageFutureError() =>
                  Localization.of(context).calendarStateErrorMessage_future,
                CalendarErrorMessageSchoolOnlyToday() =>
                  Localization.of(context)
                      .calendarStateErrorMessage_schoolTypeOnlyToday,
                CalendarErrorMessageEnrtyWithThisDateExists() =>
                  Localization.of(context)
                      .calendarStateErrorMessage_thisDateExists,
                CalendarErrorMessageNoLessonsToday() => Localization.of(context)
                    .calendarStateErrorMessage_noLessonsToday,
                CalendarErrorMessageDistanceToSchool() => Localization.of(
                        context)
                    .calendarStateErrorMessage_distanceToSchool(state.distance),
                // TODO Location settings message
                CalendarErrorMessageErrorOnGeopositionCheck() => '',
              },
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          );
        }
      }),
    );
  }
}
