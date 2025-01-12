// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'entry_adding_bloc.dart';

class EntryAddingValidationResponse {
  final StateValidityType stateValidityType;
  final dynamic value;

  EntryAddingValidationResponse({required this.stateValidityType, this.value});

  @override
  String toString() =>
      'EntryAddingValidationResponse(stateInvalidityType: $stateValidityType, value: $value)';
}

enum StateValidityType {
  noEntryType,
  futureError,
  schoolOnlyToday,
  enrtyWithThisDateExists,
  noLessonsToday,
  distanceToSchool,
  errorOnGeopositionCheck,
  unexpectedError,
}

sealed class EntryAddingState {
  /// The date
  final DateTime date;
  final EntryType? entryType;
  final CalendarFormat calendarFormat;
  final List<Entry> entriesList;
  final List<Lection> lectionsList;
  final EntryAddingValidationResponse? validationResponse;

  const EntryAddingState(
      {required this.date,
      required this.entryType,
      required this.calendarFormat,
      required this.entriesList,
      required this.lectionsList,
      required this.validationResponse});

  /// The date is idle.
  const factory EntryAddingState.idle({
    required DateTime date,
    required EntryType? entryType,
    required CalendarFormat calendarFormat,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
    required EntryAddingValidationResponse? validationResponse,
  }) = _IdleEntryAddingState;

  /// The date is validating.
  const factory EntryAddingState.validating({
    required DateTime date,
    required EntryType? entryType,
    required CalendarFormat calendarFormat,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
    required EntryAddingValidationResponse? validationResponse,
  }) = _ValidatingEntryAddingState;

  /// The date is success.
  const factory EntryAddingState.success({
    required DateTime date,
    required EntryType entryType,
    required CalendarFormat calendarFormat,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
    required EntryAddingValidationResponse? validationResponse,
  }) = _SuccesEntryAddingState;

  /// The date has an error.
  const factory EntryAddingState.error({
    required Object error,
    required DateTime date,
    required EntryType? entryType,
    required CalendarFormat calendarFormat,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
    required EntryAddingValidationResponse validationResponse,
  }) = _ErrorEntryAddingState;

  /// Check if state is is an Valid state.
  bool get isValid => validationResponse == null;

  /// Check if state is idle.
  bool get idle => switch (this) {
        _IdleEntryAddingState _ => true,
        _ => false,
      };

  /// Check if state is validating.
  bool get validating => switch (this) {
        _ValidatingEntryAddingState _ => true,
        _ => false,
      };

  /// Check if state is success.
  bool get success => switch (this) {
        _SuccesEntryAddingState _ => true,
        _ => false,
      };

  /// Check if state is error.
  bool get isError => switch (this) {
        _ErrorEntryAddingState _ => true,
        _ => false,
      };
}

final class _IdleEntryAddingState extends EntryAddingState {
  const _IdleEntryAddingState({
    required super.date,
    super.entryType,
    required super.calendarFormat,
    required super.entriesList,
    required super.lectionsList,
    required super.validationResponse,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _IdleEntryAddingState &&
        other.date == date &&
        other.entryType == entryType &&
        other.calendarFormat == calendarFormat &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(
        date,
        entryType,
        calendarFormat,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'EntryAddingState.idle(date: $date, entryType: $entryType, calendarFormat: $calendarFormat, entriesList: $entriesList, lectionsList: $lectionsList)';
}

final class _ValidatingEntryAddingState extends EntryAddingState {
  const _ValidatingEntryAddingState({
    required super.date,
    required super.entryType,
    required super.calendarFormat,
    required super.entriesList,
    required super.lectionsList,
    required super.validationResponse,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ValidatingEntryAddingState &&
        other.date == date &&
        other.entryType == entryType &&
        other.calendarFormat == calendarFormat &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(
        date,
        entryType,
        calendarFormat,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'EntryAddingState.validating(date: $date, entryType: $entryType, calendarFormat: $calendarFormat, entriesList: $entriesList, lectionsList: $lectionsList)';
}

final class _SuccesEntryAddingState extends EntryAddingState {
  const _SuccesEntryAddingState({
    required super.date,
    required super.entryType,
    required super.calendarFormat,
    required super.entriesList,
    required super.lectionsList,
    required super.validationResponse,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _SuccesEntryAddingState &&
        other.date == date &&
        other.entryType == entryType &&
        other.calendarFormat == calendarFormat &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(
        date,
        entryType,
        calendarFormat,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'EntryAddingState.success(date: $date, entryType: $entryType, calendarFormat: $calendarFormat, entriesList: $entriesList, lectionsList: $lectionsList)';
}

final class _ErrorEntryAddingState extends EntryAddingState {
  /// The error.
  final Object error;

  const _ErrorEntryAddingState({
    required this.error,
    required super.date,
    required super.entryType,
    required super.calendarFormat,
    required super.entriesList,
    required super.lectionsList,
    required super.validationResponse,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ErrorEntryAddingState &&
        other.error == error &&
        other.date == date &&
        other.entryType == entryType &&
        other.calendarFormat == calendarFormat &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(
        error,
        date,
        entryType,
        calendarFormat,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'EntryAddingState.error(error: $error, date: $date, entryType: $entryType, calendarFormat: $calendarFormat, entriesList: $entriesList, lectionsList: $lectionsList)';
}
