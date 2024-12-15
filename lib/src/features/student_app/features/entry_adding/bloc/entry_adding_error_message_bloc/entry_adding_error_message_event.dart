part of 'entry_adding_error_message_bloc.dart';

enum ErrorType {
  futureError,
  schoolOnlyToday,
  enrtyWithThisDateExists,
  noLessonsToday,
  distanceToSchool,
  errorOnGeopositionCheck,
}

sealed class EntryAddingErrorMessageEvent extends Equatable {
  const EntryAddingErrorMessageEvent();

  @override
  List<Object?> get props => [];
}

final class EnableCalendarErrorMessageEvent
    extends EntryAddingErrorMessageEvent {
  final ErrorType errorType;
  final int? value;

  const EnableCalendarErrorMessageEvent({this.value, required this.errorType});
  @override
  List<Object?> get props => [errorType, value];
}

final class DisableCalendarErrorMessageEvent
    extends EntryAddingErrorMessageEvent {}