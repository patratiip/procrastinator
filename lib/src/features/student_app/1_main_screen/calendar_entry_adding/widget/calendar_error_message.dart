import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/calendar_entry_adding/bloc/calendar_bloc.dart';


/// ERROR Message
class ErrorMessageCalendarWidget extends StatelessWidget {
  const ErrorMessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
      if (state.status == CalendarStateStatus.error) {
        return Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          color: MyAppColorScheme.errorColor,
          child: Text(
            switch (state.message) {
              CalendarStateMessage.empty => '',
              CalendarStateMessage.allEntriesAdded => '',
              CalendarStateMessage.futureError =>
                Localization.of(context).calendarStateErrorMessage_future,
              CalendarStateMessage.schoolOnlyToday => Localization.of(context)
                  .calendarStateErrorMessage_schoolTypeOnlyToday,
              CalendarStateMessage.enrtyWithThisDateExists =>
                Localization.of(context)
                    .calendarStateErrorMessage_thisDateExists,
              CalendarStateMessage.noLessonsToday => Localization.of(context)
                  .calendarStateErrorMessage_noLessonsToday,
              CalendarStateMessage.distanceToSchool => Localization.of(context)
                  .calendarStateErrorMessage_distanceToSchool(state.value),
              CalendarStateMessage.errorOnGeopositionCheck => state.value,
            },
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        );
      } else {
        return const SizedBox(
            // height: 24
            );
      }
    });
  }
}