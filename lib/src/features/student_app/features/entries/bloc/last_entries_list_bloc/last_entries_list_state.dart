part of 'last_entries_list_bloc.dart';

sealed class LastEntriesListState {
  /// The entriesList
  final List<Entry> entriesList;

  const LastEntriesListState({required this.entriesList});

  /// The entriesList is idle.
  const factory LastEntriesListState.idle({required List<Entry> entriesList}) =
      _IdleLastEntriesListState;

  /// The entriesList is loading.
  const factory LastEntriesListState.loading(
      {required List<Entry> entriesList}) = _LoadingLastEntriesListState;

  /// The entriesList is loaded.
  const factory LastEntriesListState.loaded(
      {required List<Entry> entriesList}) = _LoadedLastEntriesListState;

  /// The entriesList has an error.
  const factory LastEntriesListState.error(
      {required Object error,
      required List<Entry> entriesList,
      String? entryRef}) = _ErrorLastEntriesListState;

  /// Check if state is idle.
  bool get isIdle => switch (this) {
        _IdleLastEntriesListState _ => true,
        _ => false,
      };

  /// Check if state is loading.
  bool get loading => switch (this) {
        _LoadingLastEntriesListState _ => true,
        _ => false,
      };

  /// Check if state is loaded.
  bool get loaded => switch (this) {
        _LoadedLastEntriesListState _ => true,
        _ => false,
      };

  /// Check if state is error.
  bool get isError => switch (this) {
        _ErrorLastEntriesListState _ => true,
        _ => false,
      };
}

final class _IdleLastEntriesListState extends LastEntriesListState {
  const _IdleLastEntriesListState({required super.entriesList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _IdleLastEntriesListState &&
        listEquals(other.entriesList, entriesList);
  }

  @override
  int get hashCode => entriesList.hashCode;

  @override
  String toString() => 'LastEntriesListState.idle(entriesList: $entriesList)';
}

final class _LoadingLastEntriesListState extends LastEntriesListState {
  const _LoadingLastEntriesListState({required super.entriesList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _LoadingLastEntriesListState &&
        listEquals(other.entriesList, entriesList);
  }

  @override
  int get hashCode => entriesList.hashCode;

  @override
  String toString() =>
      'LastEntriesListState.loading(entriesList: $entriesList)';
}

final class _LoadedLastEntriesListState extends LastEntriesListState {
  const _LoadedLastEntriesListState({required super.entriesList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _LoadedLastEntriesListState &&
        listEquals(other.entriesList, entriesList);
  }

  @override
  int get hashCode => entriesList.hashCode;

  @override
  String toString() => 'LastEntriesListState.loaded(entriesList: $entriesList)';
}

class _ErrorLastEntriesListState extends LastEntriesListState {
  /// The error.
  final Object error;

  /// Entry reference to delete
  final String? entryRef;

  const _ErrorLastEntriesListState({
    required this.error,
    required super.entriesList,
    this.entryRef,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ErrorLastEntriesListState &&
        listEquals(other.entriesList, entriesList) &&
        other.entryRef == entryRef &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(error, entryRef, entriesList);

  @override
  String toString() =>
      'LastEntriesListState.error(entriesList: $entriesList, error: $error, entryRef: $entryRef)';
}
