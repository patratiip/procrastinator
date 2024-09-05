part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

final class CalendarInitializationEvent extends CalendarEvent {}

final class CalendarNothingToAddEvent extends CalendarEvent {}

final class CalendarSomethingToAddEvent extends CalendarEvent {}

final class CalendarDateChanged extends CalendarEvent {
  const CalendarDateChanged({required this.date});
  final DateTime date;
  @override
  List<Object> get props => [date];
}

final class CalendarTypeChanged extends CalendarEvent {
  const CalendarTypeChanged({required this.type});
  final String type;
  @override
  List<Object> get props => [type];
}

final class CalendarFormatChanged extends CalendarEvent {
  const CalendarFormatChanged({required this.calendarFormat});
  final CalendarFormat calendarFormat;
  @override
  List<Object> get props => [calendarFormat];
}

final class CalendarAddEntry extends CalendarEvent {}
