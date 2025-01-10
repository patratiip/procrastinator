// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entries/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/core/utils/little_helpers.dart';

/// {@template redux_entry_adding_state}
/// State for entry adding feature [ReduxEntryAddingState].
/// {@endtemplate}

class ReduxEntryAddingState {
  final DateTime date;
  final EntryType? entryType;
  final CalendarFormat calendarFormat;
  final List<Entry> entriesList;
  final List<Lection> lectionsList;
  final EntryAddingValidationResponse? validationResponse;

  /// Creating initial state of [ReduxEntryAddingState]
  static ReduxEntryAddingState initialState() => ReduxEntryAddingState(
        date: dateNormalizer(DateTime.now()),
        entryType: null,
        calendarFormat: CalendarFormat.week,
        entriesList: [],
        lectionsList: [],
        validationResponse: EntryAddingValidationResponse(
            stateValidityType: StateValidityType.noEntryType),
      );

  /// {@macro redux_entry_adding_state}
  ReduxEntryAddingState(
      {required this.date,
      required this.entryType,
      required this.calendarFormat,
      required this.entriesList,
      required this.lectionsList,
      required this.validationResponse});

  /// Check if state is is an Valid state.
  bool get isValid => validationResponse == null;

  ReduxEntryAddingState copy({
    DateTime? date,
    EntryType? entryType,
    CalendarFormat? calendarFormat,
    List<Entry>? entriesList,
    List<Lection>? lectionsList,
    EntryAddingValidationResponse? validationResponse,
  }) {
    return ReduxEntryAddingState(
      date: date ?? this.date,
      entryType: entryType ?? this.entryType,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      entriesList: entriesList ?? this.entriesList,
      lectionsList: lectionsList ?? this.lectionsList,
      validationResponse: validationResponse,
    );
  }

  @override
  bool operator ==(covariant ReduxEntryAddingState other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.entryType == entryType &&
        other.calendarFormat == calendarFormat &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList) &&
        other.validationResponse == validationResponse;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        entryType.hashCode ^
        calendarFormat.hashCode ^
        entriesList.hashCode ^
        lectionsList.hashCode ^
        validationResponse.hashCode;
  }

  @override
  String toString() {
    return 'ReduxEntryAddingState(date: $date, entryType: $entryType, calendarFormat: $calendarFormat, entriesList: $entriesList, lectionsList: $lectionsList, validationResponse: $validationResponse)';
  }
}
