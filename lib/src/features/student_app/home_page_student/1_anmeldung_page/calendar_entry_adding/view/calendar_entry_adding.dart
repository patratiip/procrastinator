import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/calendar_entry_adding/bloc/calendar_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/loosed_entries_list_widget/bloc/loosed_entries_bloc.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEntryAddingWidget extends StatelessWidget {
  const CalendarEntryAddingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listenWhen: (previous, current) =>
          previous.status != CalendarStateStatus.readyToAdding,
      listener: (context, state) {
        //TODO Change Status to success after snack bar design finishing
        if (state.status == CalendarStateStatus.readyToAdding) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 5),
            elevation: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).cardColor,
            content: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: AnimateIcon(
                      key: UniqueKey(),
                      onTap: () {},
                      iconType: IconType.continueAnimation,
                      // height: 56,
                      // width: 56,
                      color: MyAppColorScheme.sucsessColor,
                      animateIcon: AnimateIcons.upload,
                    ),
                  ),
                  Text(
                    'Hast du das geschaft!',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: MyAppColorScheme.sucsessColor),
                  ),
                ],
              ),
            ),
          ));

          // showCupertinoModalBottomSheet(
          //     closeProgressThreshold: 2,
          //     duration: Duration(seconds: 2),
          //     context: context,
          //     builder: (BuildContext context) {
          //       return Container(
          //         decoration: BoxDecoration(color: Theme.of(context).cardColor),
          //         height: 300,
          //         child: Center(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 'Halellujah!',
          //                 style: Theme.of(context).textTheme.displayLarge,
          //               ),
          //               ElevatedButton(
          //                   onPressed: () {
          //                     Navigator.pop(context);
          //                   },
          //                   child: const Text('Close!'))
          //             ],
          //           ),
          //         ),
          //       );
          //     });
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
              color: Theme.of(context).colorScheme.background,
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

          locale: 'de_DE',

          availableCalendarFormats: const {
            CalendarFormat.month: 'Monat',
            CalendarFormat.twoWeeks: '2 Wochen',
            CalendarFormat.week: 'Woche'
          },

          onFormatChanged: (format) {
            if (formatOfCalendar == CalendarFormat.week) {
              bloc.add(
                  CalendarFormatChanged(calendarFormat: CalendarFormat.month));
            } else if (formatOfCalendar == CalendarFormat.month) {
              bloc.add(CalendarFormatChanged(
                  calendarFormat: CalendarFormat.twoWeeks));
            } else if (formatOfCalendar == CalendarFormat.twoWeeks) {
              bloc.add(
                  CalendarFormatChanged(calendarFormat: CalendarFormat.week));
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
class DropDownEntry extends StatefulWidget {
  const DropDownEntry({super.key});

  @override
  State<DropDownEntry> createState() => _DropDownEntryState();
}

class _DropDownEntryState extends State<DropDownEntry> {
  final List<DropdownMenuEntry> _dropDownCalendarOptions = [
    const DropdownMenuEntry(label: 'Schule', value: 0),
    const DropdownMenuEntry(label: 'Heim', value: 1),
    const DropdownMenuEntry(label: 'Krank', value: 2),
    const DropdownMenuEntry(label: 'Fehl', value: 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 22, left: 8, right: 8),

      // width: double.infinity,
      child: DropdownMenu(
        enableSearch: false,
        expandedInsets: EdgeInsets.zero,
        // width: double.infinity,
        hintText: 'Standort wählen...',
        dropdownMenuEntries: _dropDownCalendarOptions,
        textStyle: Theme.of(context).textTheme.titleMedium,
        // controller: ,

        ///INPUT
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.background,
        ),

        ///MENU
        menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.background),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            // side: MaterialStatePropertyAll(BorderSide()),
            shape: WidgetStatePropertyAll(OutlinedBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                const RoundedRectangleBorder(),
                0.1))),
        onSelected: (value) {
          final bloc = BlocProvider.of<CalendarBloc>(context);
          final type = _dropDownCalendarOptions[value].label;
          bloc.add(CalendarTypeChanged(type: type));
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
            width: double.infinity,
            // height: 24,
            color: MyAppColorScheme.errorColor,
            child: SelectableText(
              textAlign: TextAlign.center,
              state.message!,
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

/////Succes Message
class SuccesMessageCalendarWidget extends StatelessWidget {
  const SuccesMessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
      if (state.status == CalendarStateStatus.allDone) {
        return Container(
            width: double.infinity,
            height: 24,
            color: MyAppColorScheme.sucsessColor,
            child: Text(
              state.message ?? '',
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
            return Container(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(MyAppColorScheme.primary),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))))),
                  onPressed: () {
                    final bloc = BlocProvider.of<CalendarBloc>(context);

                    bloc.add(CalendarAddEntry());
                  },
                  child: Text(
                    'Anmelden',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          //fontWeight: FontWeight.w500
                        ),
                  )),
            );
          } else if (state.status == CalendarStateStatus.inProgress) {
            return Container(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(MyAppColorScheme.primary),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
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

            //   ///error
            // } else if (state.isValid == false) {
            //   return Container(
            //     width: double.infinity,
            //     height: 60,
            //     child: ElevatedButton(
            //         style: const ButtonStyle(
            //             backgroundColor:
            //                 MaterialStatePropertyAll(MyAppColorScheme.errorColor),
            //             shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(
            //                     bottomLeft: Radius.circular(20),
            //                     bottomRight: Radius.circular(20))))),
            //         onPressed: () {},
            //         child: Text(
            //           textAlign: TextAlign.center,
            //           state.status!,
            //           style: Theme.of(context).textTheme.labelLarge!.copyWith(
            //                 color: Colors.white,
            //                 //fontWeight: FontWeight.w500
            //               ),
            //         )),
            //   );

            //   ///You are hero
            // } else if (state.status == 'Hast du alles geschaft!') {
            //   return Container(
            //     width: double.infinity,
            //     height: 60,
            //     child: ElevatedButton(
            //         style: const ButtonStyle(
            //             backgroundColor:
            //                 MaterialStatePropertyAll(MyAppColorScheme.sucsessColor),
            //             shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(
            //                     bottomLeft: Radius.circular(20),
            //                     bottomRight: Radius.circular(20))))),
            //         onPressed: () {},
            //         child: Text(
            //           textAlign: TextAlign.center,
            //           state.status!,
            //           style: Theme.of(context).textTheme.labelLarge!.copyWith(
            //                 color: Colors.white,
            //                 //fontWeight: FontWeight.w500
            //               ),
            //         )),
            //   );

            ////unactive
          } else {
            return Container(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))))),
                  onPressed: () {},
                  child: Text(
                    'Anmelden',
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
