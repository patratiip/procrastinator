part of 'last_entries_list_bloc.dart';

sealed class EntriesListEvent {
  const EntriesListEvent();

  /// The entriesList changed.
  const factory EntriesListEvent.entriesListChanged(
      {required List<Entry> entriesList}) = _EntriesListEventChanged;

  /// Delete entry.
  const factory EntriesListEvent.deleteEntry({required String entryRef}) =
      _EntriesListEventDelete;
}

final class _EntriesListEventChanged extends EntriesListEvent {
  /// The changed entries list
  final List<Entry> entriesList;
  const _EntriesListEventChanged({required this.entriesList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _EntriesListEventChanged &&
        other.entriesList == entriesList;
  }

  @override
  int get hashCode => entriesList.hashCode;

  @override
  String toString() =>
      'EntriesListEvent.entriesListChanged(entriesList: $entriesList)';
}

final class _EntriesListEventDelete extends EntriesListEvent {
  /// Entry reference to delete
  final String entryRef;
  const _EntriesListEventDelete({required this.entryRef});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _EntriesListEventDelete && other.entryRef == entryRef;
  }

  @override
  int get hashCode => entryRef.hashCode;

  @override
  String toString() => 'EntriesListEvent.deleteEntry( entryRef: $entryRef)';
}
