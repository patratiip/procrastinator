import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_state_data_changed.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/utils/extensions/context_extension.dart';
import 'package:procrastinator/src/core/utils/little_helpers.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:table_calendar/table_calendar.dart';

/// {@template calendar_entry_adding_widget}
/// [CalendarEntyAddingWidget].
/// {@endtemplate}
class CalendarEntyAddingWidget extends StatelessWidget {
  /// {@macro calendar_entry_adding_widget}
  const CalendarEntyAddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('de_DE', null);
    initializeDateFormatting('ru_RU', null);

    // Feature Redux state
    final state = context.state.reduxEntryAddingState;
    final formatOfCalendar = state.calendarFormat;
    final today = state.date;

    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      rowHeight: 66,

      // Header Style
      headerStyle: HeaderStyle(
        headerPadding: const EdgeInsets.symmetric(vertical: 8.0),
        leftChevronIcon: const Icon(
          Icons.chevron_left_rounded,
          size: 34,
          color: Colors.grey,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right_rounded,
          size: 34,
          color: Colors.grey,
        ),
        leftChevronPadding:
            const EdgeInsets.only(top: 12, bottom: 12, right: 12),
        rightChevronPadding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 12),

        // Calendar format button
        formatButtonDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).colorScheme.surface,
        ),
        titleTextFormatter: (date, locale) =>
            DateFormat.yMMMM(locale).format(date),
        titleTextStyle: Theme.of(context).textTheme.titleMedium!,
        formatButtonTextStyle: Theme.of(context).textTheme.bodyLarge!,
      ),

      // Calendar style
      calendarStyle: const CalendarStyle(
        markerSize: 44,
        defaultTextStyle: TextStyle(fontSize: 18),
        // Today style
        markerSizeScale: 2,
        todayTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        todayDecoration: BoxDecoration(
            color: Color.fromARGB(255, 162, 159, 255), shape: BoxShape.circle),
        // Selected day style
        selectedTextStyle: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        selectedDecoration: BoxDecoration(
            color: MyAppColorScheme.primary, shape: BoxShape.circle),
      ),

      // Animations
      formatAnimationCurve: Curves.easeInOut,
      formatAnimationDuration: const Duration(milliseconds: 300),

      // Day of week
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) =>
            DateFormat.E(locale).format(date).substring(0, 2),
      ),
      // Focused day
      focusedDay: today,
      firstDay: DateTime(1900),
      lastDay: DateTime(3000),
      selectedDayPredicate: (day) => isSameDay(day, today),
      locale: Localizations.localeOf(context).languageCode,
      // Available calendar formats
      availableCalendarFormats: {
        CalendarFormat.month: Localization.of(context).calendarFormatButton,
        CalendarFormat.twoWeeks:
            Localization.of(context).calendarFormatButtonTwoWeeks,
        CalendarFormat.week: Localization.of(context).calendarFormatButtonWeek
      },
      // Changing calendar format
      onFormatChanged: (format) {
        switch (formatOfCalendar) {
          case CalendarFormat.week:
            context.dispatch(
                StateDataChangedAction(calendarFormat: CalendarFormat.month));
          case CalendarFormat.month:
            context.dispatch(StateDataChangedAction(
                calendarFormat: CalendarFormat.twoWeeks));
          case CalendarFormat.twoWeeks:
            context.dispatch(
                StateDataChangedAction(calendarFormat: CalendarFormat.week));
        }
      },
      calendarFormat: formatOfCalendar,
      startingDayOfWeek: StartingDayOfWeek.monday,

      // Set ReduxEntryAddingState.date
      onDaySelected: (DateTime day, DateTime focusedDay) {
        context.dispatch(StateDataChangedAction(date: dateNormalizer(day)));
      },
    );
  }
}
