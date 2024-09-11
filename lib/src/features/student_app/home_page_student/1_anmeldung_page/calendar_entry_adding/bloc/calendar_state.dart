part of 'calendar_bloc.dart';

enum CalendarStateStatus {
  disabled,
  hasDate,
  hasType,
  inProgress,
  readyToAdding,
  success,
  error,
  allDone,
}

enum CalendarStateMessage {
  //default
  empty,
  //all is done
  allEntriesAdded,
  //errors
  futureError,
  schoolOnlyToday,
  enrtyWithThisDateExists,
  noLessonsToday,
  distanceToSchool,
  errorOnGeopositionCheck
}

final class CalendarState extends Equatable {
  const CalendarState({
    this.date,
    this.calendarFormat,
    this.type,
    this.isValid = true,
    this.value,
    this.message = CalendarStateMessage.empty,
    this.status = CalendarStateStatus.disabled,
  });

  final DateTime? date;
  final CalendarFormat? calendarFormat;
  final String? type;
  final bool isValid;
  final dynamic value;
  final CalendarStateMessage message;
  final CalendarStateStatus status;

  CalendarState copyWith({
    DateTime? date,
    CalendarFormat? calendarFormat,
    String? type,
    bool? isValid,
    dynamic value,
    CalendarStateMessage? message,
    CalendarStateStatus? status,
  }) {
    return CalendarState(
      date: date ?? this.date,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      type: type ?? this.type,
      isValid: isValid ?? this.isValid,
      value: value ?? this.value,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [date, calendarFormat, type, isValid, value, message, status];
}
