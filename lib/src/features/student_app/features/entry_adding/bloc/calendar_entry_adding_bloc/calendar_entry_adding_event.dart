part of 'calendar_entry_adding_bloc.dart';

sealed class CalendarEntryAddingEvent extends Equatable {
  const CalendarEntryAddingEvent();

  @override
  List<Object?> get props => [];
}

// final class CalendarSubscriptionsRequested extends CalendarEvent {}

final class CalendarNothingToAddEvent extends CalendarEntryAddingEvent {}

// final class CalendarSomethingToAddEvent extends CalendarEvent {}

final class CalendarDateChanged extends CalendarEntryAddingEvent {
  const CalendarDateChanged({required this.date});
  final DateTime date;
  @override
  List<Object> get props => [date];
}

final class CalendarEntryTypeChanged extends CalendarEntryAddingEvent {
  const CalendarEntryTypeChanged({required this.entryType});
  final EntryType entryType;
  @override
  List<Object> get props => [entryType];
}

final class CalendarFormatChanged extends CalendarEntryAddingEvent {
  const CalendarFormatChanged({required this.calendarFormat});
  final CalendarFormat calendarFormat;
  @override
  List<Object> get props => [calendarFormat];
}

final class CalendarEntriesUpdated extends CalendarEntryAddingEvent {
  final List<Entry>? entriesList;

  const CalendarEntriesUpdated(this.entriesList);

  @override
  List<Object?> get props => [entriesList];
}

final class CalendarLectionsUpdated extends CalendarEntryAddingEvent {
  final List<Lection>? lectionsList;

  const CalendarLectionsUpdated(this.lectionsList);

  @override
  List<Object?> get props => [lectionsList];
}
