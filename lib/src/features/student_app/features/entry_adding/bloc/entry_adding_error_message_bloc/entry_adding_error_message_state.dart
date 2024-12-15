part of 'entry_adding_error_message_bloc.dart';

sealed class EntryAddingErrorMessageState extends Equatable {
  const EntryAddingErrorMessageState();

  @override
  List<Object> get props => [];
}

final class CalendarErrorMessageDisabled extends EntryAddingErrorMessageState {}

final class CalendarErrorMessageFutureError
    extends EntryAddingErrorMessageState {}

final class CalendarErrorMessageSchoolOnlyToday
    extends EntryAddingErrorMessageState {}

final class CalendarErrorMessageEnrtyWithThisDateExists
    extends EntryAddingErrorMessageState {}

final class CalendarErrorMessageNoLessonsToday
    extends EntryAddingErrorMessageState {}

final class CalendarErrorMessageDistanceToSchool
    extends EntryAddingErrorMessageState {
  final int distance;

  const CalendarErrorMessageDistanceToSchool({required this.distance});
  @override
  List<Object> get props => [distance];
}

final class CalendarErrorMessageErrorOnGeopositionCheck
    extends EntryAddingErrorMessageState {}
