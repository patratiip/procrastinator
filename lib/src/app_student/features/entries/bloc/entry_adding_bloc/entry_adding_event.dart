part of 'entry_adding_bloc.dart';

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

  /// User want to add an Entry
  const factory EntryAddingEvent.add() = _AddEntryAddingEvent;
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

final class _AddEntryAddingEvent extends EntryAddingEvent {
  const _AddEntryAddingEvent();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _StateDataChangedEntryAddingEvent;
  }

  @override
  int get hashCode;

  @override
  String toString() => 'EntryAddingEvent.add()';
}
