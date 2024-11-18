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
  final int? value;
  final DateTime date;
  final EntryType entryType;

  const CalendarEntryAddingButtonError(
    this.error,
    this.value,
    this.date,
    this.entryType,
  );

  @override
  List<Object?> get props => [error, value, date, entryType];
}
