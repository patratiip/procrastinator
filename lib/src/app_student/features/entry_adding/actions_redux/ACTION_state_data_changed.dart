// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/app_action.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_entry_adding_state/redux_entry_adding_state.dart';

import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/core/utils/little_helpers.dart';
import 'package:table_calendar/table_calendar.dart';

/// {@template state_data_changed_action}
/// [StateDataChangedAction] is an action that handles a new [ReduxEntryAddingState].
/// {@endtemplate}

class StateDataChangedAction extends AppAction {
  final DateTime? date;
  final EntryType? entryType;
  final CalendarFormat? calendarFormat;
  final List<Entry>? entriesList;
  final List<Lection>? lectionsList;

  /// {@macro state_data_changed_action}
  StateDataChangedAction({
    this.date,
    this.entryType,
    this.calendarFormat,
    this.entriesList,
    this.lectionsList,
  });

  //
  @override
  ReduxAppState? reduce() {
    log(date.toString());
    final actualState = state.reduxEntryAddingState;
    log('1' + state.reduxEntryAddingState.toString());

    final validatingState = state.copy(
      reduxEntryAddingState: state.reduxEntryAddingState.copy(
        date: dateNormalizer(date ?? actualState.date),
        entryType: entryType ?? actualState.entryType,
        calendarFormat: calendarFormat ?? actualState.calendarFormat,
        entriesList: entriesList ?? actualState.entriesList,
        lectionsList: lectionsList ?? actualState.lectionsList,
        validationResponse: actualState.validationResponse,
      ),
    );
    log(validatingState.toString());
    final validationResponse =
        _isNewStateValid(actualState: validatingState.reduxEntryAddingState);

    final successState = validatingState.copy(
      reduxEntryAddingState: validatingState.reduxEntryAddingState.copy(
        validationResponse: validationResponse,
      ),
    );
    log(successState.toString());

  
    return state.copy(
        reduxEntryAddingState: successState.reduxEntryAddingState);
  }
}

/// Checks if everything is allright or handled an Error State
EntryAddingValidationResponse? _isNewStateValid(
    {required ReduxEntryAddingState actualState}) {
  // TODO: Add validation for situations:
  // state have no entryType, lections list is empty

  // Future check
  if (!_isDateInTheFuture(actualState.date)) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.futureError);
  }

  // Entry exist check
  if (actualState.entriesList.isNotEmpty &&
      !_entryAtThatDateExist(actualState.date, actualState.entriesList)) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.enrtyWithThisDateExists);
  }

  // Lection at that date exists check
  if (actualState.lectionsList.isNotEmpty &&
      !_lectionWithTisDateExist(actualState.date, actualState.lectionsList)) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.noLessonsToday);
  }

  // School and Past check
  if (!_ifTypeIsSchoolDateIsToday(actualState.entryType, actualState.date)) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.schoolOnlyToday);
  }

  // State entryType is null
  if (actualState.entryType == null) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.noEntryType);
  }

  return null;
}

/// Checking if entry at that date already exist in [entriesList]
bool _entryAtThatDateExist(DateTime date, List<Entry> entriesList) {
  return !entriesList.any((entry) => entry.date == date);
}

/// Checking if entry at that date exist in [lectionsList]
bool _lectionWithTisDateExist(DateTime date, List<Lection> lectionsList) {
  return lectionsList.any((lection) => lection.date == date);
}

/// Checking if actual [state.date] is in a future
bool _isDateInTheFuture(DateTime date) {
  final today = dateNormalizer(DateTime.now());
  return !date.isAfter(today);
}

/// Checking if actual [state.date] is today when user choosed [EntryType.schoolVisit]
bool _ifTypeIsSchoolDateIsToday(EntryType? type, DateTime date) {
  final today = dateNormalizer(DateTime.now());

  if (type == EntryType.schoolVisit && !date.isAtSameMomentAs(today)) {
    return false;
  }
  return true;
}
