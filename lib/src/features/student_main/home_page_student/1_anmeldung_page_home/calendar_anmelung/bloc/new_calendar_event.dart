part of 'new_calendar_bloc.dart';

sealed class NewCalendarEvent extends Equatable {
  const NewCalendarEvent();

  @override
  List<Object> get props => [];
}

final class CalendarInitializationEvent extends NewCalendarEvent {}

final class CalendarNothingToAddEvent extends NewCalendarEvent {}

final class CalendarSomethingToAddEvent extends NewCalendarEvent {}

final class CalendarDateChanged extends NewCalendarEvent {
  const CalendarDateChanged({required this.date});
  final DateTime date;
  @override
  List<Object> get props => [date];
}

final class CalendarTypeChanged extends NewCalendarEvent {
  const CalendarTypeChanged({required this.type});
  final String type;
  @override
  List<Object> get props => [type];
}

final class CalendarAddEntry extends NewCalendarEvent {}
