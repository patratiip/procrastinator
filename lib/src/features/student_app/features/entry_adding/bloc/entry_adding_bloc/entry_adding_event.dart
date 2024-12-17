part of 'entry_adding_bloc.dart';

// sealed class CalendarEntryAddingEvent extends Equatable {
//   const CalendarEntryAddingEvent();

//   @override
//   List<Object?> get props => [];
// }

// // final class CalendarSubscriptionsRequested extends CalendarEvent {}

// // final class CalendarNothingToAddEvent extends CalendarEntryAddingEvent {}

// // final class CalendarSomethingToAddEvent extends CalendarEvent {}

// final class CalendarDateChanged extends CalendarEntryAddingEvent {
//   const CalendarDateChanged({required this.date});
//   final DateTime date;
//   @override
//   List<Object> get props => [date];
// }

// final class CalendarEntryTypeChanged extends CalendarEntryAddingEvent {
//   const CalendarEntryTypeChanged({required this.entryType});
//   final EntryType entryType;
//   @override
//   List<Object> get props => [entryType];
// }

// final class CalendarFormatChanged extends CalendarEntryAddingEvent {
//   const CalendarFormatChanged({required this.calendarFormat});
//   final CalendarFormat calendarFormat;
//   @override
//   List<Object> get props => [calendarFormat];
// }

// final class CalendarEntriesUpdated extends CalendarEntryAddingEvent {
//   final List<Entry>? entriesList;

//   const CalendarEntriesUpdated(this.entriesList);

//   @override
//   List<Object?> get props => [entriesList];
// }

// final class CalendarLectionsUpdated extends CalendarEntryAddingEvent {
//   final List<Lection>? lectionsList;

//   const CalendarLectionsUpdated(this.lectionsList);

//   @override
//   List<Object?> get props => [lectionsList];
// }

sealed class EntryAddingEvent {
  /// The date
  final DateTime? date;
  final EntryType? entryType;
  final CalendarFormat? calendarFormat;
  final List<Entry>? entriesList;
  final List<Lection>? lectionsList;

  const EntryAddingEvent({
    this.date,
    this.entryType,
    this.calendarFormat,
    this.entriesList,
    this.lectionsList,
  });

  /// The date changed.
  const factory EntryAddingEvent.stateDataChanged({
    DateTime? date,
    EntryType? entryType,
    CalendarFormat? calendarFormat,
    List<Entry>? entriesList,
    List<Lection>? lectionsList,
  }) = _StateDataChangedEntryAddingEvent;
}

final class _StateDataChangedEntryAddingEvent extends EntryAddingEvent {
  const _StateDataChangedEntryAddingEvent({
    super.date,
    super.entryType,
    super.calendarFormat,
    super.entriesList,
    super.lectionsList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _StateDataChangedEntryAddingEvent &&
        other.date == date &&
        other.entryType == entryType &&
        other.calendarFormat == calendarFormat &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(
        date,
        entryType,
        calendarFormat,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'EntryAddingEvent.stateDataChanged(date: $date, entryType: $entryType, calendarFormat: $calendarFormat, entriesList: $entriesList, lectionsList: $lectionsList)';
}
