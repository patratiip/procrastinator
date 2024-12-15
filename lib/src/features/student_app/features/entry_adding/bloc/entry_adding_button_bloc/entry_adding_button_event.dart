part of 'entry_adding_button_bloc.dart';

sealed class EntryAddingButtonEvent extends Equatable {
  const EntryAddingButtonEvent();

  @override
  List<Object> get props => [];
}

final class CalendarButtonDisableButtonEvent extends EntryAddingButtonEvent {}

final class CalendarButtonIsReadyEvent extends EntryAddingButtonEvent {
  final DateTime date;
  final EntryType entryType;

  const CalendarButtonIsReadyEvent(this.date, this.entryType);

  @override
  List<Object> get props => [date, entryType];
}

final class CalendarButtonAddEntryEvent extends EntryAddingButtonEvent {
  final DateTime date;
  final EntryType entryType;

  const CalendarButtonAddEntryEvent(this.date, this.entryType);

  @override
  List<Object> get props => [date, entryType];
}
