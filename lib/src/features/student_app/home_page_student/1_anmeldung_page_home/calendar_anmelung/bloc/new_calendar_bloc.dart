import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/bloc/loosed_entrys_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';
import 'package:uuid/uuid.dart';

part 'new_calendar_event.dart';
part 'new_calendar_state.dart';

class CalendarBloc extends Bloc<NewCalendarEvent, NewCalendarState> {
  final EntryRepositoty _entriesRepository;
  //Entries Bloc
  final EntrysListBloc _entrysListBloc;
  //Lessons Bloc
  final KursplanBloc _kursplanBloc;
  //Loosed Bloc
  final LoosedEntrysBloc _loosedEntriesBloc;
  late final StreamSubscription _loosedEntriesBlocStreamSubscription;

  CalendarBloc(
      this._entrysListBloc, this._kursplanBloc, this._loosedEntriesBloc,
      {required entrysRepository})
      : _entriesRepository = entrysRepository,
        super(NewCalendarState(date: DateTime.now())) {
    //

    //Subscription - Loosed Bloc
    _loosedEntriesBlocStreamSubscription = _loosedEntriesBloc.stream.listen(
      (state) {
        if (state is LoosedEntrysInitial) {
          // if (state.loosedLectionsList!.isEmpty) {
          add(CalendarNothingToAddEvent());
          // }
        } else if (state is ComaredEntrysState) {
          add(CalendarSomethingToAddEvent());
        }
      },
      cancelOnError: false,
    );

    ///Initialization
    on<CalendarInitializationEvent>((event, emit) async {
      // await Future<void>.delayed(const Duration(seconds: 2));
      // emit(state.copyWith(
      //   status: 'Hast du alles geschaft!',
      // ));
    });

    ///Nothing to add
    on<CalendarNothingToAddEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(
        status: NewCalendarStateStatus.allDone,
      ));
    });

    ///Something to add
    on<CalendarSomethingToAddEvent>(
      (event, emit) async {
        await Future<void>.delayed(const Duration(seconds: 2));
        emit(state.copyWith(
          status: NewCalendarStateStatus.disabled,
        ));
      },
      transformer: sequential(),
    );

    ///User changed date
    on<CalendarDateChanged>((event, emit) {
      emit(state.copyWith(
        isValid: true,
      ));
      final entriesBlocState = _entrysListBloc.state;
      final lectionsBlocState = _kursplanBloc.state;
      final newDate =
          DateTime(event.date.year, event.date.month, event.date.day);

      //Future check
      if (newDate.isAfter(DateTime.now())) {
        emit(state.copyWith(
          isValid: false,
          errorMessage: 'Achtung! Zukunft',
          status: NewCalendarStateStatus.error,
        ));
      }

      //Entry exist check
      if (state.isValid && entriesBlocState is EntrysListLoadedState) {
        final entriesDateList = entriesBlocState.userVisits!.map((entry) {
          return DateTime(
            entry.date!.year,
            entry.date!.month,
            entry.date!.day,
          );
        }).toList();

        if (entriesDateList.contains(newDate)) {
          emit(state.copyWith(
            isValid: false,
            errorMessage: 'Anmeldung mit diese Datum schon exestiert',
            status: NewCalendarStateStatus.error,
          ));
        } else {
          emit(state.copyWith(
            isValid: true,
          ));
        }
      }

      //Lection at that date exists check
      if (state.isValid && lectionsBlocState is LectionsListLoadedState) {
        final lectionsDateList = lectionsBlocState.lectionsList.map((lection) {
          return DateTime(
            lection.date!.year,
            lection.date!.month,
            lection.date!.day,
          );
        }).toList();

        if (lectionsDateList.contains(newDate) == false) {
          emit(state.copyWith(
            isValid: false,
            errorMessage: 'Keine Unterrichten!',
            status: NewCalendarStateStatus.error,
          ));
        } else {
          emit(state.copyWith(isValid: true));
        }
      }

      //Total Validation check
      if (state.isValid) {
        emit(state.copyWith(
            date: newDate,
            status: state.type != null
                ? NewCalendarStateStatus.readyToAdding
                : NewCalendarStateStatus.hasDate));
      }
    });

    ///User changed type of entry
    on<CalendarTypeChanged>((event, emit) {
      final newType = event.type;
      //TODO Add entry date check
      emit(state.copyWith(type: newType));

      final entriesBlocState = _entrysListBloc.state;
      final lectionsBlocState = _kursplanBloc.state;
      final stateDate =
          DateTime(state.date!.year, state.date!.month, state.date!.day);

      //Future check
      if (stateDate.isAfter(DateTime.now())) {
        emit(state.copyWith(
          isValid: false,
          errorMessage: 'Achtung! Zukunft',
          status: NewCalendarStateStatus.error,
        ));
      }

      //Entry exist check
      if (state.isValid && entriesBlocState is EntrysListLoadedState) {
        final entriesDateList = entriesBlocState.userVisits!.map((entry) {
          return DateTime(
            entry.date!.year,
            entry.date!.month,
            entry.date!.day,
          );
        }).toList();

        if (entriesDateList.contains(stateDate)) {
          emit(state.copyWith(
            isValid: false,
            errorMessage: 'Anmeldung mit diese Datum schon exestiert',
            status: NewCalendarStateStatus.error,
          ));
        } else {
          emit(state.copyWith(
            isValid: true,
          ));
        }
      }

      //Lection at that date exists check
      if (state.isValid && lectionsBlocState is LectionsListLoadedState) {
        final lectionsDateList = lectionsBlocState.lectionsList.map((lection) {
          return DateTime(
            lection.date!.year,
            lection.date!.month,
            lection.date!.day,
          );
        }).toList();

        if (lectionsDateList.contains(stateDate) == false) {
          emit(state.copyWith(
            isValid: false,
            errorMessage: 'Keine Unterrichten!',
            status: NewCalendarStateStatus.error,
          ));
        } else {
          emit(state.copyWith(isValid: true));
        }
      }

      //TODO Add Geoposition check

      //Total Validation check
      if (state.isValid) {
        emit(state.copyWith(
            type: newType,
            status: state.date != null
                ? NewCalendarStateStatus.readyToAdding
                : NewCalendarStateStatus.hasType));
      }
    });

    ///User submitted choise
    on<CalendarAddEntry>((event, emit) async {
      if (state.status == NewCalendarStateStatus.readyToAdding) {
        emit(state.copyWith(
          isValid: true,
          status: NewCalendarStateStatus.inProgress,
        ));

        final entry = Entry(visitID: const Uuid().v4(), date: state.date);

        if (state.type == 'Schule') {
          entry.schoolVisit = true;
        } else if (state.type == 'Heim') {
          entry.homeOffice = true;
        } else if (state.type == 'Krank') {
          entry.krank = true;
        } else if (state.type == 'Fehl') {
          entry.fehl = true;
        }
        _entriesRepository.addEntry(entry);

        await Future<void>.delayed(const Duration(seconds: 1));
        add(CalendarInitializationEvent());
        // emit(state.copyWith(isValid: false, status: 'Added'));
      } else {}
    });

    @override
    Future<void> close() {
      _loosedEntriesBlocStreamSubscription.cancel();
      return super.close();
    }
  }
}
