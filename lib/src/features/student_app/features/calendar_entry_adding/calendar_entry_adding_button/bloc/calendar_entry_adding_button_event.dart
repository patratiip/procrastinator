part of 'calendar_entry_adding_button_bloc.dart';

sealed class CalendarEntryAddingButtonEvent extends Equatable {
  const CalendarEntryAddingButtonEvent();

  @override
  List<Object> get props => [];
}

final class CalendarButtonDisableButtonEvent
    extends CalendarEntryAddingButtonEvent {}

final class CalendarButtonIsReadyEvent extends CalendarEntryAddingButtonEvent {
  final DateTime date;
  final EntryType entryType;

  const CalendarButtonIsReadyEvent(this.date, this.entryType);

  @override
  List<Object> get props => [date, entryType];
}

final class CalendarButtonAddEntryEvent extends CalendarEntryAddingButtonEvent {
  final DateTime date;
  final EntryType entryType;

  const CalendarButtonAddEntryEvent(this.date, this.entryType);

  @override
  List<Object> get props => [date, entryType];
}
