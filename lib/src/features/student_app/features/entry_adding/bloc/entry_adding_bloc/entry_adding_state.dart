// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'entry_adding_bloc.dart';

class EntryAddingValidationResponse {
  final StateInvalidityType stateInvalidityType;
  final dynamic value;

  EntryAddingValidationResponse(
      {required this.stateInvalidityType, this.value});

  @override
  String toString() =>
      'EntryAddingValidationResponse(stateInvalidityType: $stateInvalidityType, value: $value)';
}

enum StateInvalidityType {
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
      {required this.calendarFormat,
      required this.entryType,
      required this.entriesList,
      required this.lectionsList,
      required this.date,
      required this.validationResponse});

  /// The date is initial.
  const factory EntryAddingState.initial({
    required DateTime date,
    required EntryType? entryType,
    required CalendarFormat calendarFormat,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
    required EntryAddingValidationResponse? validationResponse,
  }) = _InitialEntryAddingState;

  /// The date is validating.
  const factory EntryAddingState.validating({
    required DateTime date,
    required EntryType? entryType,
    required CalendarFormat calendarFormat,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
    required EntryAddingValidationResponse? validationResponse,
  }) = _ValidatingEntryAddingState;

  /// The date is succes.
  const factory EntryAddingState.succes({
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

  /// Check if state is initial.
  bool get initial => switch (this) {
        _InitialEntryAddingState _ => true,
        _ => false,
      };

  /// Check if state is validating.
  bool get validating => switch (this) {
        _ValidatingEntryAddingState _ => true,
        _ => false,
      };

  /// Check if state is succes.
  bool get succes => switch (this) {
        _SuccesEntryAddingState _ => true,
        _ => false,
      };

  /// Check if state is error.
  bool get isError => switch (this) {
        _ErrorEntryAddingState _ => true,
        _ => false,
      };
}

final class _InitialEntryAddingState extends EntryAddingState {
  const _InitialEntryAddingState({
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
    return other is _InitialEntryAddingState &&
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
      'EntryAddingState.initial(date: $date, entryType: $entryType, calendarFormat: $calendarFormat, entriesList: $entriesList, lectionsList: $lectionsList)';
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
      'EntryAddingState.valid(date: $date, entryType: $entryType, calendarFormat: $calendarFormat, entriesList: $entriesList, lectionsList: $lectionsList)';
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



// enum CalendarStateStatus {
//   initial,
//   hasDate,
//   hasType,
//   inProgress,
//   readyToAdding,
//   error,
//   allDone
// }

// final class CalendarEntryAddingState {
//   final DateTime? date;
//   final CalendarFormat? calendarFormat;
//   final EntryType? entryType;
//   final List<Entry> entriesList;
//   final List<Lection> lectionsList;
//   final dynamic value;
//   final StateInvalidityType? errorType;
//   final CalendarStateStatus status;

//   const CalendarEntryAddingState({
//     this.date,
//     this.calendarFormat,
//     this.entryType,
//     this.entriesList = const [],
//     this.lectionsList = const [],
//     this.value,
//     this.errorType,
//     this.status = CalendarStateStatus.initial,
//   });

//   CalendarEntryAddingState copyWith({
//     DateTime? date,
//     CalendarFormat? calendarFormat,
//     EntryType? entryType,
//     List<Entry>? entriesList,
//     List<Lection>? lectionsList,
//     dynamic value,
//     StateInvalidityType? errorType,
//     CalendarStateStatus? status,
//   }) {
//     return CalendarEntryAddingState(
//       date: date ?? this.date,
//       calendarFormat: calendarFormat ?? this.calendarFormat,
//       entryType: entryType ?? this.entryType,
//       entriesList: entriesList ?? this.entriesList,
//       lectionsList: lectionsList ?? this.lectionsList,
//       value: value ?? this.value,
//       errorType: errorType ?? this.errorType,
//       status: status ?? this.status,
//     );
//   }

//   @override
//   bool operator ==(covariant CalendarEntryAddingState other) {
//     if (identical(this, other)) return true;

//     return other.date == date &&
//         other.calendarFormat == calendarFormat &&
//         other.entryType == entryType &&
//         listEquals(other.entriesList, entriesList) &&
//         listEquals(other.lectionsList, lectionsList) &&
//         other.value == value &&
//         other.errorType == errorType &&
//         other.status == status;
//   }

//   @override
//   int get hashCode {
//     return date.hashCode ^
//         calendarFormat.hashCode ^
//         entryType.hashCode ^
//         entriesList.hashCode ^
//         lectionsList.hashCode ^
//         value.hashCode ^
//         errorType.hashCode ^
//         status.hashCode;
//   }

//   @override
//   String toString() {
//     return 'CalendarState(date: $date, calendarFormat: $calendarFormat, entryType: $entryType, entriesList: $entriesList, lectionsList: $lectionsList, value: $value, errorType: $errorType, status: $status)';
//   }
// }
