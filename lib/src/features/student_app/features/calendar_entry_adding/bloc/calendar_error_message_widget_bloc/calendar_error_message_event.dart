part of 'calendar_error_message_bloc.dart';

enum ErrorType {
  futureError,
  schoolOnlyToday,
  enrtyWithThisDateExists,
  noLessonsToday,
  distanceToSchool,
  errorOnGeopositionCheck,
}

sealed class CalendarErrorMessageEvent extends Equatable {
  const CalendarErrorMessageEvent();

  @override
  List<Object?> get props => [];
}

final class EnableCalendarErrorMessageEvent extends CalendarErrorMessageEvent {
  final ErrorType errorType;
  final int? value;

  const EnableCalendarErrorMessageEvent({this.value, required this.errorType});
  @override
  List<Object?> get props => [errorType, value];
}

final class DisableCalendarErrorMessageEvent
    extends CalendarErrorMessageEvent {}
