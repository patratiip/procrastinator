import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';
part 'validators_calendar_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final IEntryRepositoty _entriesRepository;
  final ILectionRepository _lectionsRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  CalendarBloc({
    required IEntryRepositoty entriesRepository,
    required ILectionRepository lectionsRepository,
  })  : _entriesRepository = entriesRepository,
        _lectionsRepository = lectionsRepository,
        super(CalendarState(
          date: _normalizeDate(DateTime.now()),
          calendarFormat: CalendarFormat.week,
        )) {
    _initializeListeners();

    on<CalendarEvent>(
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
    _entrysListListener = _entriesRepository.getVisits().listen(
      (entriesList) {
        add(CalendarEntriesUpdated(entriesList));
        if (state.status != CalendarStateStatus.initial) {
          add(CalendarDateChanged(date: state.date!));
        }
      },
      cancelOnError: false,
    );

    _lectionListListener = _lectionsRepository.getLections().listen(
      (lectionsList) {
        add(CalendarLectionsUpdated(lectionsList));
      },
      cancelOnError: false,
    );
  }

  /// Nothing to add
  ///
  Future<void> _calendarNothingToAddEvent(
      CalendarNothingToAddEvent event, Emitter<CalendarState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
      message: CalendarStateMessage.allEntriesAdded,
      status: CalendarStateStatus.allDone,
    ));
  }

  /// User changed calendar format
  ///
  Future<void> _calendarFormatChanged(
      CalendarFormatChanged event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(calendarFormat: event.calendarFormat));
  }

  /// Got new Entries list
  ///
  Future<void> _calendarEntriesUpdated(
      CalendarEntriesUpdated event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(entriesList: event.entriesList));
  }

  /// Got new Entries list
  ///
  Future<void> _calendarLectionsUpdated(
      CalendarLectionsUpdated event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(lectionsList: event.lectionsList));
  }

  /// User changed date
  ///
  Future<void> _calendarDateChanged(
      CalendarDateChanged event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(date: _normalizeDate(event.date)));

    _isStateValidCheckerAndErrorEmitter(emit: emit);
  }

  /// User changed type of entry
  ///
  Future<void> _calendarEntryTypeChanged(
      CalendarEntryTypeChanged event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(entryType: event.entryType));

    _isStateValidCheckerAndErrorEmitter(emit: emit);
  }

  

  /// Checks if everything is allright or handled an Error State
  bool _isStateValidCheckerAndErrorEmitter(
      {required Emitter<CalendarState> emit}) {
    // Future check
    if (!_isDateInTheFuture(state.date!)) {
      emit(state.copyWith(
        message: CalendarStateMessage.futureError,
        status: CalendarStateStatus.error,
      ));
      return false;
    }

    // School and Past check
    if (!_ifTypeIsSchoolDateIsToday(state.entryType, state.date!)) {
      emit(state.copyWith(
        message: CalendarStateMessage.schoolOnlyToday,
        status: CalendarStateStatus.error,
      ));
      return false;
    }

    // Entry exist check
    if (state.entriesList.isNotEmpty &&
        !_entryAtThatDateExist(state.date!, state.entriesList)) {
      emit(state.copyWith(
        message: CalendarStateMessage.enrtyWithThisDateExists,
        status: CalendarStateStatus.error,
      ));
      return false;
    }

    // Lection at that date exists check
    if (state.lectionsList.isNotEmpty &&
        !_lectionWithTisDateExist(state.date!, state.lectionsList)) {
      emit(state.copyWith(
        message: CalendarStateMessage.noLessonsToday,
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
