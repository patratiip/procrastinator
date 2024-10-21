import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';
part 'validators_calendar_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final IUserRepository _userRepository;
  final IEntryRepositoty _entriesRepository;
  final ILectionRepository _lectionsRepository;
  final IGeolocationRepository _geolocationRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  CalendarBloc(
      {required IUserRepository userRepository,
      required IEntryRepositoty entriesRepository,
      required ILectionRepository lectionsRepository,
      required IGeolocationRepository geolocationRepository})
      : _userRepository = userRepository,
        _entriesRepository = entriesRepository,
        _lectionsRepository = lectionsRepository,
        _geolocationRepository = geolocationRepository,
        super(CalendarState(
          date: _normalizeDate(DateTime.now()),
          calendarFormat: CalendarFormat.week,
        )) {
    _initializeListeners();

    on<CalendarNothingToAddEvent>(_calendarNothingToAddEvent);

    on<CalendarEntriesUpdated>(_calendarEntriesUpdated,
        transformer: sequential());
    on<CalendarLectionsUpdated>(_calendarLectionsUpdated,
        transformer: sequential());
    //TODO add a timing in that user can change calendar formats
    on<CalendarFormatChanged>(_calendarFormatChanged,
        transformer: sequential());
    on<CalendarDateChanged>(_calendarDateChanged, transformer: sequential());
    on<CalendarEntryTypeChanged>(_calendarEntryTypeChanged,
        transformer: sequential());
    on<CalendarAddEntry>(_calendarAddEntry, transformer: droppable());
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

  /// User submitted choise
  ///
  Future<void> _calendarAddEntry(
      CalendarAddEntry event, Emitter<CalendarState> emit) async {
    if (state.status != CalendarStateStatus.readyToAdding) return;

    emit(state.copyWith(status: CalendarStateStatus.inProgress));

    Entry entry = Entry(
        visitID: const Uuid().v4(),
        date: state.date!,
        entryType: state.entryType!);

    if (!await _isStudentInSchoolAndErrorEmitter(emit: emit)) {
      return;
    }

    // Entry Adding
    try {
      _entriesRepository.addEntry(entry);
      emit(state.copyWith(status: CalendarStateStatus.success));
    } catch (e) {
      emit(state.copyWith(
          value: e,
          message: CalendarStateMessage.errorOnGeopositionCheck,
          status: CalendarStateStatus.error));
      log(e.toString());
      rethrow;
    }
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

  /// Checks if Student is in the scool
  /// or handled an Error State with a distance to school
  Future<bool> _isStudentInSchoolAndErrorEmitter(
      {required Emitter<CalendarState> emit}) async {
    if (state.entryType! != EntryType.schoolVisit) return true;
    try {
      final user = await _userRepository.user.first;
      final schoolPosition = user.schoolGeoPosition;

      final userGeoPosition = await _geolocationRepository.determinePosition();

      final distanceToSchool = _geolocationRepository.distanceToSchool(
          userGeoposition: userGeoPosition,
          schoolLatitude: schoolPosition!.latitude,
          schoolLongtitude: schoolPosition.longitude);

      if (distanceToSchool >= 100) {
        emit(state.copyWith(
          value: distanceToSchool.toInt(),
          message: CalendarStateMessage.distanceToSchool,
          status: CalendarStateStatus.error,
        ));
        return false;
      } else {
        return true;
      }
    } catch (e) {
      emit(state.copyWith(
          value: e,
          message: CalendarStateMessage.errorOnGeopositionCheck,
          status: CalendarStateStatus.error));
      log(e.toString());
      return false;
    }
  }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    _lectionListListener.cancel();
    return super.close();
  }
}
