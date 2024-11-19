part of 'calendar_entry_adding_button_bloc.dart';

sealed class CalendarEntryAddingButtonState extends Equatable {
  const CalendarEntryAddingButtonState();

  @override
  List<Object?> get props => [];
}

final class CalendarEntryAddingButtonDisabled
    extends CalendarEntryAddingButtonState {}

final class CalendarEntryAddingButtonEnabled
    extends CalendarEntryAddingButtonState {
  final DateTime date;
  final EntryType entryType;

  const CalendarEntryAddingButtonEnabled(this.date, this.entryType);

  @override
  List<Object> get props => [date, entryType];
}

final class CalendarEntryAddingButtonInProgress
    extends CalendarEntryAddingButtonState {
  final DateTime date;
  final EntryType entryType;

  const CalendarEntryAddingButtonInProgress(this.date, this.entryType);

  @override
  List<Object> get props => [date, entryType];
}

final class CalendarEntryAddingButtonSuccess
    extends CalendarEntryAddingButtonState {
  const CalendarEntryAddingButtonSuccess();
}

final class CalendarEntryAddingButtonError
    extends CalendarEntryAddingButtonState {
  final Object error;
  final ErrorType errorType;

  const CalendarEntryAddingButtonError(
    this.error,
    this.errorType,
  );

  @override
  List<Object> get props => [error, errorType];
}

final class CalendarEntryAddingButtonDistanceError
    extends CalendarEntryAddingButtonState {
  final int distance;
  final ErrorType errorType;

  const CalendarEntryAddingButtonDistanceError(
    this.distance,
    this.errorType,
  );

  @override
  List<Object> get props => [distance, errorType];
}
