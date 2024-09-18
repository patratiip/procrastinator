import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/1_anmeldung_page/calendar_entry_adding/bloc/calendar_bloc.dart';
import 'package:procrastinator/src/features/student_app/1_anmeldung_page/loosed_entries_list_widget/bloc/loosed_entries_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEntryAddingWidget extends StatelessWidget {
  const CalendarEntryAddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listenWhen: (previous, current) =>
          previous.status != CalendarStateStatus.success,
      listener: (context, state) {
        if (state.status == CalendarStateStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
              //s
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
          ));
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
                  // CalendarForEntyAdding(),
                  CalendarForEntyAddingNewBloc(),
                  DropDownEntry(),
                  ErrorMessageCalendarWidget(),
                  SuccesMessageCalendarWidget(),
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

///////CALENDAR
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
          formatAnimationCurve: Curves.elasticInOut,
          formatAnimationDuration: const Duration(milliseconds: 800),

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

/////DROP
class DropDownEntry extends StatelessWidget {
  const DropDownEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry> dropDownCalendarOptions = [
      DropdownMenuEntry(
          label: Localization.of(context).schoolEntryType, value: 0),
      DropdownMenuEntry(
          label: Localization.of(context).homeEntryType, value: 1),
      DropdownMenuEntry(
          label: Localization.of(context).sickEntryType, value: 2),
      DropdownMenuEntry(
          label: Localization.of(context).looseEntryType, value: 3),
    ];
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 22, left: 8, right: 8),

      // width: double.infinity,
      child: DropdownMenu(
        enableSearch: false,
        expandedInsets: EdgeInsets.zero,
        // width: double.infinity,
        hintText: Localization.of(context).entryTypeDropdownHintText,
        dropdownMenuEntries: dropDownCalendarOptions,
        textStyle: Theme.of(context).textTheme.titleMedium,
        // controller: ,

        ///INPUT
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),

        ///MENU
        menuStyle: MenuStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            // side: MaterialStatePropertyAll(BorderSide()),
            shape: WidgetStatePropertyAll(OutlinedBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                const RoundedRectangleBorder(),
                0.1))),
        onSelected: (value) {
          final bloc = BlocProvider.of<CalendarBloc>(context);
          late final String? type;
          switch (dropDownCalendarOptions[value].value) {
            case 0:
              type = 'Schule';
            case 1:
              type = 'Heim';
            case 2:
              type = 'Krank';
            case 3:
              type = 'Fehl';
          }

          bloc.add(CalendarTypeChanged(type: type!));
        },
      ),
    );
  }
}

/////ERROR Message
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

/////Succes Message
class SuccesMessageCalendarWidget extends StatelessWidget {
  const SuccesMessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
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

///////BUTTON
class EntryAddingButton extends StatelessWidget {
  const EntryAddingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoosedEntriesBloc, LoosedEntriesState>(
      listener: (context, state) {
        if (state is CopmaredAllClear) {
          context.read<CalendarBloc>().add(CalendarNothingToAddEvent());
        }
      },
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state.status == CalendarStateStatus.readyToAdding) {
            return SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(MyAppColorScheme.primary),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))))),
                  onPressed: () {
                    final bloc = BlocProvider.of<CalendarBloc>(context);

                    bloc.add(CalendarAddEntry());
                  },
                  child: Text(
                    Localization.of(context).addEntryButtonText,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          //fontWeight: FontWeight.w500
                        ),
                  )),
            );
          } else if (state.status == CalendarStateStatus.inProgress) {
            return SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(MyAppColorScheme.primary),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))))),
                onPressed: () {},
                child: const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );

            ////unactive
          } else {
            return SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.grey),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))))),
                  onPressed: () {},
                  child: Text(
                    Localization.of(context).addEntryButtonText,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          //fontWeight: FontWeight.w500
                        ),
                  )),
            );
          }
        },
      ),
    );
  }
}
