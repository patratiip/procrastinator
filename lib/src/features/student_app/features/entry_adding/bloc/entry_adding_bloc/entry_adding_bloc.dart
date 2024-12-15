import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/data/entry_adding_repository.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_error_message_bloc/entry_adding_error_message_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';

part 'entry_adding_event.dart';
part 'entry_adding_state.dart';
part 'validators_calendar_bloc.dart';

class CalendarEntryAddingBloc
    extends Bloc<CalendarEntryAddingEvent, CalendarEntryAddingState> {
  final IEntryAddingRepository _entryAddingRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  CalendarEntryAddingBloc({
    required IEntryAddingRepository entryAddingRepository,
  })  : _entryAddingRepository = entryAddingRepository,
        super(CalendarEntryAddingState(
          date: _normalizeDate(DateTime.now()),
          calendarFormat: CalendarFormat.week,
        )) {
    _initializeListeners();

    on<CalendarEntryAddingEvent>(
      (event, emit) => switch (event) {
        final CalendarNothingToAddEvent e =>
          _calendarNothingToAddEvent(e, emit),
        final CalendarEntriesUpdated e => _calendarEntriesUpdated(e, emit),
        final CalendarLectionsUpdated e => _calendarLectionsUpdated(e, emit),
        //TODO add a timing in that user can change calendar formats
        final CalendarFormatChanged e => _calendarFormatChanged(e, emit),
        final CalendarDateChanged e => _calendarDateChanged(e, emit),
        final CalendarEntryTypeChanged e => _calendarEntryTypeChanged(e, emit),
      },
      transformer: sequential(),
    );
  }

  /// Subscriptons initialization
  void _initializeListeners() {
    _entrysListListener = _entryAddingRepository.entriesStream().listen(
      (entriesList) {
        add(CalendarEntriesUpdated(entriesList));
        if (state.status != CalendarStateStatus.initial) {
          add(CalendarDateChanged(date: state.date!));
        }
      },
      cancelOnError: false,
    );

    _lectionListListener = _entryAddingRepository.lectionsStream().listen(
      (lectionsList) {
        add(CalendarLectionsUpdated(lectionsList));
      },
      cancelOnError: false,
    );
  }

  /// Nothing to add
  ///
  Future<void> _calendarNothingToAddEvent(CalendarNothingToAddEvent event,
      Emitter<CalendarEntryAddingState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      status: CalendarStateStatus.allDone,
    ));
  }

  /// User changed calendar format
  ///
  Future<void> _calendarFormatChanged(CalendarFormatChanged event,
      Emitter<CalendarEntryAddingState> emit) async {
    emit(state.copyWith(calendarFormat: event.calendarFormat));
  }

  /// Got new Entries list
  ///
  Future<void> _calendarEntriesUpdated(CalendarEntriesUpdated event,
      Emitter<CalendarEntryAddingState> emit) async {
    emit(state.copyWith(entriesList: event.entriesList));
  }

  /// Got new Entries list
  ///
  Future<void> _calendarLectionsUpdated(CalendarLectionsUpdated event,
      Emitter<CalendarEntryAddingState> emit) async {
    emit(state.copyWith(lectionsList: event.lectionsList));
  }

  /// User changed date
  ///
  Future<void> _calendarDateChanged(
      CalendarDateChanged event, Emitter<CalendarEntryAddingState> emit) async {
    emit(state.copyWith(date: _normalizeDate(event.date)));

    _isStateValidCheckerAndErrorEmitter(emit: emit);
  }

  /// User changed type of entry
  ///
  Future<void> _calendarEntryTypeChanged(CalendarEntryTypeChanged event,
      Emitter<CalendarEntryAddingState> emit) async {
    emit(state.copyWith(entryType: event.entryType));

    _isStateValidCheckerAndErrorEmitter(emit: emit);
  }

  /// Checks if everything is allright or handled an Error State
  bool _isStateValidCheckerAndErrorEmitter(
      {required Emitter<CalendarEntryAddingState> emit}) {
    // Future check
    if (!_isDateInTheFuture(state.date!)) {
      emit(state.copyWith(
        errorType: ErrorType.futureError,
        status: CalendarStateStatus.error,
      ));
      return false;
    }

    // Entry exist check
    if (state.entriesList.isNotEmpty &&
        !_entryAtThatDateExist(state.date!, state.entriesList)) {
      emit(state.copyWith(
        errorType: ErrorType.enrtyWithThisDateExists,
        status: CalendarStateStatus.error,
      ));
      return false;
    }

    // Lection at that date exists check
    if (state.lectionsList.isNotEmpty &&
        !_lectionWithTisDateExist(state.date!, state.lectionsList)) {
      emit(state.copyWith(
        errorType: ErrorType.noLessonsToday,
        status: CalendarStateStatus.error,
      ));
      return false;
    }

    // School and Past check
    if (!_ifTypeIsSchoolDateIsToday(state.entryType, state.date!)) {
      emit(state.copyWith(
        errorType: ErrorType.schoolOnlyToday,
        status: CalendarStateStatus.error,
      ));
      return false;
    }

    emit(state.copyWith(
        status: state.entryType != null
            ? CalendarStateStatus.readyToAdding
            : CalendarStateStatus.hasDate));
    return true;
  }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    _lectionListListener.cancel();
    log('Calendar listeners are closed');
    return super.close();
  }
}
