part of 'calendar_error_message_bloc.dart';

sealed class CalendarErrorMessageState extends Equatable {
  const CalendarErrorMessageState();

  @override
  List<Object> get props => [];
}

final class CalendarErrorMessageDisabled extends CalendarErrorMessageState {}

final class CalendarErrorMessageFutureError extends CalendarErrorMessageState {}

final class CalendarErrorMessageSchoolOnlyToday
    extends CalendarErrorMessageState {}

final class CalendarErrorMessageEnrtyWithThisDateExists
    extends CalendarErrorMessageState {}

final class CalendarErrorMessageNoLessonsToday
    extends CalendarErrorMessageState {}

final class CalendarErrorMessageDistanceToSchool
    extends CalendarErrorMessageState {
  final int distance;

  const CalendarErrorMessageDistanceToSchool({required this.distance});
  @override
  List<Object> get props => [distance];
}

final class CalendarErrorMessageErrorOnGeopositionCheck
    extends CalendarErrorMessageState {}
