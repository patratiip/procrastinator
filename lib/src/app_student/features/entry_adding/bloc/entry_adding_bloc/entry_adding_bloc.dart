import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/business.dart';
import 'package:procrastinator/main.dart';

import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/ACTION_state_data_changed.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/core/utils/little_helpers.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

part 'entry_adding_event.dart';
part 'entry_adding_state.dart';
part 'validators_calendar_bloc.dart';

class EntryAddingBloc extends Bloc<EntryAddingEvent, EntryAddingState> {
  final IEntryAddingRepository _entryAddingRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  EntryAddingBloc({
    required IEntryAddingRepository entryAddingRepository,
  })  : _entryAddingRepository = entryAddingRepository,
        super(_IdleEntryAddingState(
          date: dateNormalizer(DateTime.now()),
          entryType: null,
          calendarFormat: CalendarFormat.week,
          entriesList: [],
          lectionsList: [],
          validationResponse: EntryAddingValidationResponse(
              stateValidityType: StateValidityType.noEntryType),
        )) {
    /// Subscriptons initialization
    _initializeListeners();

    on<EntryAddingEvent>(
      (event, emit) => switch (event) {
        final _StateDataChangedEntryAddingEvent e =>
          _stateDataChangedEntryAddingEvent(e, emit),
        final _AddEntryAddingEvent e => _addEntryAddingEvent(e, emit),
      },
      transformer: sequential(),
    );
  }

  /// Subscriptons initialization method
  void _initializeListeners() {
    _entrysListListener = _entryAddingRepository.entriesStream().listen(
      (entriesList) {
        add(_StateDataChangedEntryAddingEvent(entriesList: entriesList));
      },
      cancelOnError: false,
    );

    _lectionListListener = _entryAddingRepository.lectionsStream().listen(
      (lectionsList) {
        add(_StateDataChangedEntryAddingEvent(lectionsList: lectionsList));
      },
      cancelOnError: false,
    );
  }

  /// State data was changed
  ///
  Future<void> _stateDataChangedEntryAddingEvent(
      _StateDataChangedEntryAddingEvent event,
      Emitter<EntryAddingState> emit) async {
    try {
      emit(_ValidatingEntryAddingState(
        date: dateNormalizer(event.date ?? state.date),
        entryType: event.entryType ?? state.entryType,
        calendarFormat: event.calendarFormat ?? state.calendarFormat,
        entriesList: event.entriesList ?? state.entriesList,
        lectionsList: event.lectionsList ?? state.lectionsList,
        validationResponse: state.validationResponse,
      ));

      ///

      // log('1' + Business.store.state.reduxEntryAddingState.toString());

      Business.store.dispatch(StateDataChangedAction(
        date: dateNormalizer(event.date ?? state.date),
        entryType: event.entryType ?? state.entryType,
        calendarFormat: event.calendarFormat ?? state.calendarFormat,
        entriesList: event.entriesList ?? state.entriesList,
        lectionsList: event.lectionsList ?? state.lectionsList,
      ));
      // log(Business.store.state.reduxEntryAddingState.toString());

      ///

      final validationResponse = await _isNewStateValid(actualState: state);

      emit(_IdleEntryAddingState(
        date: state.date,
        entryType: state.entryType,
        calendarFormat: state.calendarFormat,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        validationResponse: validationResponse,
      ));
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
      emit(_ErrorEntryAddingState(
        error: error,
        date: state.date,
        entryType: state.entryType,
        calendarFormat: state.calendarFormat,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        validationResponse: state.validationResponse,
      ));
    } finally {
      emit(_IdleEntryAddingState(
        date: state.date,
        entryType: state.entryType,
        calendarFormat: state.calendarFormat,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        validationResponse: state.validationResponse,
      ));
    }
  }

  /// User want to add an Entry
  ///
  Future<void> _addEntryAddingEvent(
      _AddEntryAddingEvent event, Emitter<EntryAddingState> emit) async {
    try {
      emit(_ValidatingEntryAddingState(
        date: state.date,
        entryType: state.entryType,
        calendarFormat: state.calendarFormat,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        validationResponse:
            await _isStudentInSchool(entryType: state.entryType!),
      ));

      if (state.validationResponse != null) {
        return;
      }

      final Entry entry = Entry(
          visitID: const Uuid().v4(),
          date: state.date,
          entryType: state.entryType!);

      // Entry Adding
      _entryAddingRepository.addEntry(entry);
      emit(_SuccesEntryAddingState(
        date: state.date,
        entryType: state.entryType,
        calendarFormat: state.calendarFormat,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        validationResponse: state.validationResponse,
      ));
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
      emit(_ErrorEntryAddingState(
        error: error,
        date: state.date,
        entryType: state.entryType,
        calendarFormat: state.calendarFormat,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        validationResponse: state.validationResponse,
      ));
    } finally {
      emit(_IdleEntryAddingState(
        date: state.date,
        entryType: state.entryType,
        calendarFormat: state.calendarFormat,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        validationResponse: state.validationResponse,
      ));
    }
  }

  /// Checks if Student is in the scool
  /// or handled an Error State with a distance to school
  Future<EntryAddingValidationResponse?> _isStudentInSchool(
      {required EntryType entryType}) async {
    if (entryType != EntryType.schoolVisit) return null;
    try {
      //TODO: Handle situation, when user denied acces to device geolocation services
      final userSchoolGeoposition =
          await _entryAddingRepository.getUserSchoolPosition();
      final userGeoPosition = await _entryAddingRepository.determinePosition();

      final distanceToSchool = _entryAddingRepository.distanceToSchool(
          userGeoposition: userGeoPosition,
          schoolLatitude: userSchoolGeoposition.latitude,
          schoolLongtitude: userSchoolGeoposition.longitude);

      if (distanceToSchool >= 100) {
        return EntryAddingValidationResponse(
            stateValidityType: StateValidityType.distanceToSchool,
            value: distanceToSchool.toInt());
      } else {
        return null;
      }
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
      log(error.toString());
      return EntryAddingValidationResponse(
          stateValidityType: StateValidityType.unexpectedError, value: error);
    }
  }

  //TODO: Add that method
  // /// Nothing to add
  // ///
  // Future<void> _calendarNothingToAddEvent(CalendarNothingToAddEvent event,
  //     Emitter<CalendarEntryAddingState> emit) async {
  //   await Future<void>.delayed(const Duration(seconds: 2));
  //   emit(state.copyWith(
  //     status: CalendarStateStatus.allDone,
  //   ));
  // }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    _lectionListListener.cancel();
    log('EntryAddingBloc listeners are closed');
    return super.close();
  }
}
