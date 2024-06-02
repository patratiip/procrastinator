import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/calendar_anmelung/bloc/calendar_anmeldung_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/calendar_anmelung/data/add_entry_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/calendar_anmelung/domain/add_entry_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../core/styles/color_scheme_my.dart';

class CalendarAnmeldungWidget extends StatefulWidget {
  const CalendarAnmeldungWidget({super.key});

  @override
  State<CalendarAnmeldungWidget> createState() =>
      _CalendarAnmeldungWidgetState();
}

class _CalendarAnmeldungWidgetState extends State<CalendarAnmeldungWidget> {
  final _block =
      CalendarAnmeldungBloc(GetIt.I<CalenarEntryFirestoreRepository>());
  // final _entrysBlock = LastEntrysListBloc();

  DateTime today = DateTime.now();
  DateTime usersDay = DateTime.now();
  String _dDText = '';
  final AddVisitModel _visitModel = AddVisitModel();

  CalendarFormat formatOfCalendar = CalendarFormat.week;

  final List<DropdownMenuEntry> _dropDownCalendarOptions = [
    const DropdownMenuEntry(
      label: 'Schule',
      value: 0,
    ),
    const DropdownMenuEntry(label: 'Heim', value: 1),
    const DropdownMenuEntry(label: 'Krank', value: 2),
    const DropdownMenuEntry(label: 'Fehl', value: 3),
  ];

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _anmeldenButtonAction() {
    _visitModel.date = today;
    if (_dDText == 'Schule') {
      _visitModel.schoolVisit = true;
    } else if (_dDText == 'Heim') {
      _visitModel.homeOffice = true;
    } else if (_dDText == 'Krank') {
      _visitModel.krank = true;
    } else if (_dDText == 'Fehl') {
      _visitModel.fehl = true;
    }
    //Blocks
    _block.add(AddEntry(newEntry: _visitModel));
    // _entrysBlock.add(LoadLastEntrys());
  }

  @override
  Widget build(BuildContext context) {
    print('calendar');
    initializeDateFormatting('de_DE', null);
    initializeDateFormatting('ru', null);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          // height: 400,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child:

                //
                Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ////////////////////CALENDAR/////////////////////////////
                TableCalendar(
                  availableGestures: AvailableGestures.horizontalSwipe,

                  rowHeight: 66,

                  ///HEADER Style
                  headerStyle: HeaderStyle(
                    // leftChevronVisible: false,
                    // rightChevronVisible: false,
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

                    //Button
                    formatButtonDecoration: BoxDecoration(
                      // border: Border.fromBorderSide(BorderSide(color: MyAppColorScheme.primary)),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Theme.of(context).colorScheme.background,
                    ),

                    titleTextFormatter: (date, locale) =>
                        DateFormat.yMMMM(locale).format(date),
                    titleTextStyle: Theme.of(context).textTheme.titleMedium!,
                    formatButtonTextStyle:
                        Theme.of(context).textTheme.bodyLarge!,
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
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                    selectedDecoration: BoxDecoration(
                        color: MyAppColorScheme.primary,
                        shape: BoxShape.circle),
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
                  focusedDay: today,
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
                    setState(() {
                      if (formatOfCalendar == CalendarFormat.week) {
                        formatOfCalendar = CalendarFormat.month;
                      } else if (formatOfCalendar == CalendarFormat.month) {
                        formatOfCalendar = CalendarFormat.twoWeeks;
                      } else if (formatOfCalendar == CalendarFormat.twoWeeks) {
                        formatOfCalendar = CalendarFormat.week;
                      }
                    });
                  },
                  calendarFormat: formatOfCalendar,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: _onDaySelected,
                ),

                //Drop
                Container(
                  margin: const EdgeInsets.only(
                      top: 12, bottom: 22, left: 8, right: 8),

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
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.background),
                        surfaceTintColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        shadowColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        // side: MaterialStatePropertyAll(BorderSide()),
                        shape: MaterialStatePropertyAll(OutlinedBorder.lerp(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            const RoundedRectangleBorder(),
                            0.1))),
                    onSelected: (value) {
                      setState(() {
                        _dDText = _dropDownCalendarOptions[value].label;
                      });
                    },
                  ),
                ),

                //Button
                Container(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              MyAppColorScheme.primary),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))))),
                      onPressed: _anmeldenButtonAction,
                      child: Text(
                        'Anmelden',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              //fontWeight: FontWeight.w500
                            ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
