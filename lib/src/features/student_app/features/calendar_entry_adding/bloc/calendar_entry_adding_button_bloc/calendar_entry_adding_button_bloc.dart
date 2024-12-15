import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:procrastinator/src/features/student_app/features/calendar_entry_adding/bloc/calendar_error_message_widget_bloc/calendar_error_message_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

part 'calendar_entry_adding_button_event.dart';
part 'calendar_entry_adding_button_state.dart';

class CalendarEntryAddingButtonBloc extends Bloc<CalendarEntryAddingButtonEvent,
    CalendarEntryAddingButtonState> {
  final IEntryRepository _entriesRepository;
  final IGeolocationRepository _geolocationRepository;
  final SchoolGeoPosition _userSchoolGeoposition;

  CalendarEntryAddingButtonBloc(
      {required IEntryRepository entriesRepository,
      required IGeolocationRepository geolocationRepository,
      required SchoolGeoPosition userSchoolGeoposition})
      : _entriesRepository = entriesRepository,
        _geolocationRepository = geolocationRepository,
        _userSchoolGeoposition = userSchoolGeoposition,
        super(CalendarEntryAddingButtonDisabled()) {
    on<CalendarEntryAddingButtonEvent>(
      (event, emit) => switch (event) {
        final CalendarButtonDisableButtonEvent e =>
          _calendarButtonDisableButtonEvent(e, emit),
        final CalendarButtonIsReadyEvent e =>
          _calendarButtonIsReadyEvent(e, emit),
        final CalendarButtonAddEntryEvent e =>
          _calendarButtonAddEntryEvent(e, emit),
      },
      transformer: sequential(),
    );
  }

  Future<void> _calendarButtonDisableButtonEvent(
      CalendarButtonDisableButtonEvent event,
      Emitter<CalendarEntryAddingButtonState> emit) async {
    emit(CalendarEntryAddingButtonDisabled());
  }

  Future<void> _calendarButtonIsReadyEvent(CalendarButtonIsReadyEvent event,
      Emitter<CalendarEntryAddingButtonState> emit) async {
    emit(CalendarEntryAddingButtonEnabled(event.date, event.entryType));
  }

  Future<void> _calendarButtonAddEntryEvent(CalendarButtonAddEntryEvent event,
      Emitter<CalendarEntryAddingButtonState> emit) async {
    try {
      emit(CalendarEntryAddingButtonInProgress(event.date, event.entryType));

      Entry entry = Entry(
          visitID: const Uuid().v4(),
          date: event.date,
          entryType: event.entryType);

      if (!await _isStudentInSchoolAndErrorEmitter(
          entryType: event.entryType, emit: emit)) {
        return;
      }

      // Entry Adding
      _entriesRepository.addEntry(entry);
      emit(const CalendarEntryAddingButtonSuccess());
    } on Object catch (e, st) {
      onError(e, st);
      // emit(CalendarEntryAddingButtonError(e, ErrorType.somethingWentWrong));
      log(e.toString());
      rethrow;
    }
  }

  /// Checks if Student is in the scool
  /// or handled an Error State with a distance to school
  Future<bool> _isStudentInSchoolAndErrorEmitter(
      {required EntryType entryType,
      required Emitter<CalendarEntryAddingButtonState> emit}) async {
    if (entryType != EntryType.schoolVisit) return true;
    try {
      final userGeoPosition = await _geolocationRepository.determinePosition();

      final distanceToSchool = _geolocationRepository.distanceToSchool(
          userGeoposition: userGeoPosition,
          schoolLatitude: _userSchoolGeoposition.latitude,
          schoolLongtitude: _userSchoolGeoposition.longitude);

      if (distanceToSchool >= 100) {
        emit(CalendarEntryAddingButtonDistanceError(
            distanceToSchool.toInt(), ErrorType.distanceToSchool));
        return false;
      } else {
        return true;
      }
    } on Object catch (e, st) {
      onError(e, st);
      // emit(

      //      emit(const CalendarEntryAddingButtonError());

      //   state.copyWith(
      //     value: e,
      //     message: CalendarStateMessage.errorOnGeopositionCheck,
      //     status: CalendarStateStatus.error));
      log(e.toString());
      return false;
    }
  }
}
