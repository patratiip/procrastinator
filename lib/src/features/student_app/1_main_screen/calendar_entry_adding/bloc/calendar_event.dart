part of 'calendar_bloc.dart';

sealed class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

final class CalendarSubscriptionsRequested extends CalendarEvent {}

final class CalendarNothingToAddEvent extends CalendarEvent {}

final class CalendarSomethingToAddEvent extends CalendarEvent {}

final class CalendarDateChanged extends CalendarEvent {
  const CalendarDateChanged({required this.date});
  final DateTime date;
  @override
  List<Object> get props => [date];
}

final class CalendarEntryTypeChanged extends CalendarEvent {
  const CalendarEntryTypeChanged({required this.entryType});
  final EntryType entryType;
  @override
  List<Object> get props => [entryType];
}

final class CalendarFormatChanged extends CalendarEvent {
  const CalendarFormatChanged({required this.calendarFormat});
  final CalendarFormat calendarFormat;
  @override
  List<Object> get props => [calendarFormat];
}

class CalendarEntriesUpdated extends CalendarEvent {
  final List<Entry>? entriesList;

  const CalendarEntriesUpdated(this.entriesList);

  @override
  List<Object?> get props => [entriesList];
}

class CalendarLectionsUpdated extends CalendarEvent {
  final List<Lection>? lectionsList;

  const CalendarLectionsUpdated(this.lectionsList);

  @override
  List<Object?> get props => [lectionsList];
}

final class CalendarAddEntry extends CalendarEvent {}
