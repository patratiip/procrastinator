import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/bloc/calendar_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

/// CALENDAR
class CalendarForEntyAddingNewBloc extends StatelessWidget {
  const CalendarForEntyAddingNewBloc({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('de_DE', null);
    initializeDateFormatting('ru', null);
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<CalendarBloc>(context);
        var formatOfCalendar = state.calendarFormat;
        var today = state.date;
        return TableCalendar(
          availableGestures: AvailableGestures.horizontalSwipe,

          rowHeight: 66,

          ///HEADER Style
          headerStyle: HeaderStyle(
            // leftChevronVisible: false,
            // rightChevronVisible: false,

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

            rightChevronMargin: const EdgeInsets.symmetric(horizontal: 0),
            leftChevronMargin: const EdgeInsets.symmetric(horizontal: 0),
            leftChevronPadding:
                const EdgeInsets.only(top: 12, bottom: 12, right: 12),
            rightChevronPadding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 12),

            //Button
            formatButtonDecoration: BoxDecoration(
              // border: Border.fromBorderSide(BorderSide(color: MyAppColorScheme.primary)),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.surface,
            ),

            titleTextFormatter: (date, locale) =>
                DateFormat.yMMMM(locale).format(date),
            titleTextStyle: Theme.of(context).textTheme.titleMedium!,
            formatButtonTextStyle: Theme.of(context).textTheme.bodyLarge!,
          ),

          calendarStyle: const CalendarStyle(
            markerSize: 44,

            defaultTextStyle: TextStyle(fontSize: 18),

            //TODAY Style

            markerSizeScale: 2,
            todayTextStyle:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 202, 200, 255),
                shape: BoxShape.circle),

            //SELECTED Style
            selectedTextStyle: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
            selectedDecoration: BoxDecoration(
                color: MyAppColorScheme.primary, shape: BoxShape.circle),
          ),
          // daysOfWeekHeight: 24,
          // pageJumpingEnabled: true,
          formatAnimationCurve: Curves.easeInOut,
          formatAnimationDuration: const Duration(milliseconds: 300),

          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) =>
                DateFormat.E(locale).format(date).substring(0, 2),
          ),
          // weekendDays: [DateTime.saturday, DateTime.sunday],
          focusedDay: today!,
          firstDay: DateTime(1900),
          lastDay: DateTime(3000),
          //
          selectedDayPredicate: (day) => isSameDay(day, today),

          locale: Localizations.localeOf(context).languageCode
          // 'de_DE'
          ,

          availableCalendarFormats: {
            CalendarFormat.month: Localization.of(context).calendarFormatButton,
            CalendarFormat.twoWeeks:
                Localization.of(context).calendarFormatButtonTwoWeeks,
            CalendarFormat.week:
                Localization.of(context).calendarFormatButtonWeek
          },

          onFormatChanged: (format) {
            if (formatOfCalendar == CalendarFormat.week) {
              bloc.add(const CalendarFormatChanged(
                  calendarFormat: CalendarFormat.month));
            } else if (formatOfCalendar == CalendarFormat.month) {
              bloc.add(const CalendarFormatChanged(
                  calendarFormat: CalendarFormat.twoWeeks));
            } else if (formatOfCalendar == CalendarFormat.twoWeeks) {
              bloc.add(const CalendarFormatChanged(
                  calendarFormat: CalendarFormat.week));
            }
          },
          calendarFormat: formatOfCalendar!,
          startingDayOfWeek: StartingDayOfWeek.monday,

          //Set Bloc State.date
          onDaySelected: (DateTime day, DateTime focusedDay) {
            bloc.add(CalendarDateChanged(date: day));
          },
        );
      },
    );
  }
}
