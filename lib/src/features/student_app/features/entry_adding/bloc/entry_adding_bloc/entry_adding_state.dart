// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'entry_adding_bloc.dart';

enum CalendarStateStatus {
  initial,
  hasDate,
  hasType,
  inProgress,
  readyToAdding,
  error,
  allDone
}

final class CalendarEntryAddingState {
  final DateTime? date;
  final CalendarFormat? calendarFormat;
  final EntryType? entryType;
  final List<Entry> entriesList;
  final List<Lection> lectionsList;
  final dynamic value;
  final ErrorType? errorType;
  final CalendarStateStatus status;

  const CalendarEntryAddingState({
    this.date,
    this.calendarFormat,
    this.entryType,
    this.entriesList = const [],
    this.lectionsList = const [],
    this.value,
    this.errorType,
    this.status = CalendarStateStatus.initial,
  });

  CalendarEntryAddingState copyWith({
    DateTime? date,
    CalendarFormat? calendarFormat,
    EntryType? entryType,
    List<Entry>? entriesList,
    List<Lection>? lectionsList,
    dynamic value,
    ErrorType? errorType,
    CalendarStateStatus? status,
  }) {
    return CalendarEntryAddingState(
      date: date ?? this.date,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      entryType: entryType ?? this.entryType,
      entriesList: entriesList ?? this.entriesList,
      lectionsList: lectionsList ?? this.lectionsList,
      value: value ?? this.value,
      errorType: errorType ?? this.errorType,
      status: status ?? this.status,
    );
  }

  // @override
  // List<Object?> get props => [
  //       date,
  //       calendarFormat,
  //       entryType,
  //       entriesList,
  //       lectionsList,
  //       value,
  //       errorType,
  //       status,
  //     ];

  @override
  bool operator ==(covariant CalendarEntryAddingState other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.calendarFormat == calendarFormat &&
        other.entryType == entryType &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList) &&
        other.value == value &&
        other.errorType == errorType &&
        other.status == status;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        calendarFormat.hashCode ^
        entryType.hashCode ^
        entriesList.hashCode ^
        lectionsList.hashCode ^
        value.hashCode ^
        errorType.hashCode ^
        status.hashCode;
  }

  @override
  String toString() {
    return 'CalendarState(date: $date, calendarFormat: $calendarFormat, entryType: $entryType, entriesList: $entriesList, lectionsList: $lectionsList, value: $value, errorType: $errorType, status: $status)';
  }
}
