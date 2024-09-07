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

final class CalendarState extends Equatable {
  const CalendarState({
    this.date,
    this.calendarFormat,
    this.type,
    this.isValid = true,
    this.message,
    this.status = CalendarStateStatus.disabled,
  });

  final DateTime? date;
  final CalendarFormat? calendarFormat;
  final String? type;
  final bool isValid;
  final String? message;
  final CalendarStateStatus status;

  CalendarState copyWith({
    DateTime? date,
    CalendarFormat? calendarFormat,
    String? type,
    bool? isValid,
    String? message,
    CalendarStateStatus? status,
  }) {
    return CalendarState(
      date: date ?? this.date,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      type: type ?? this.type,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [date, calendarFormat, type, isValid, message, status];
}
