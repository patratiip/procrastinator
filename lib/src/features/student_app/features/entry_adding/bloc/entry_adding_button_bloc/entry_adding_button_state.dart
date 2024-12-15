part of 'entry_adding_button_bloc.dart';

sealed class EntryAddingButtonState extends Equatable {
  const EntryAddingButtonState();

  @override
  List<Object?> get props => [];
}

final class CalendarEntryAddingButtonDisabled extends EntryAddingButtonState {}

final class CalendarEntryAddingButtonEnabled extends EntryAddingButtonState {
  final DateTime date;
  final EntryType entryType;

  const CalendarEntryAddingButtonEnabled(this.date, this.entryType);

  @override
  List<Object> get props => [date, entryType];
}

final class CalendarEntryAddingButtonInProgress extends EntryAddingButtonState {
  final DateTime date;
  final EntryType entryType;

  const CalendarEntryAddingButtonInProgress(this.date, this.entryType);

  @override
  List<Object> get props => [date, entryType];
}

final class CalendarEntryAddingButtonSuccess extends EntryAddingButtonState {
  const CalendarEntryAddingButtonSuccess();
}

final class CalendarEntryAddingButtonError extends EntryAddingButtonState {
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
    extends EntryAddingButtonState {
  final int distance;
  final ErrorType errorType;

  const CalendarEntryAddingButtonDistanceError(
    this.distance,
    this.errorType,
  );

  @override
  List<Object> get props => [distance, errorType];
}
