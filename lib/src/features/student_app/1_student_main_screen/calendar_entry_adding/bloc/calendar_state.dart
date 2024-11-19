part of 'calendar_bloc.dart';

enum CalendarStateStatus {
  initial,
  hasDate,
  hasType,
  inProgress,
  readyToAdding,
  error,
  allDone
}

enum CalendarStateMessage {
  empty,
  allEntriesAdded,
  futureError,
  schoolOnlyToday,
  enrtyWithThisDateExists,
  noLessonsToday
}

final class CalendarState extends Equatable {
  final DateTime? date;
  final CalendarFormat? calendarFormat;
  final EntryType? entryType;
  final List<Entry> entriesList;
  final List<Lection> lectionsList;
  final dynamic value;
  final ErrorType? errorType;
  final CalendarStateStatus status;

  const CalendarState({
    this.date,
    this.calendarFormat,
    this.entryType,
    this.entriesList = const [],
    this.lectionsList = const [],
    this.value,
    this.errorType,
    this.status = CalendarStateStatus.initial,
  });

  CalendarState copyWith({
    DateTime? date,
    CalendarFormat? calendarFormat,
    EntryType? entryType,
    List<Entry>? entriesList,
    List<Lection>? lectionsList,
    dynamic value,
    ErrorType? errorType,
    CalendarStateStatus? status,
  }) {
    return CalendarState(
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

  @override
  List<Object?> get props => [
        date,
        calendarFormat,
        entryType,
        entriesList,
        lectionsList,
        value,
        errorType,
        status,
      ];
}
