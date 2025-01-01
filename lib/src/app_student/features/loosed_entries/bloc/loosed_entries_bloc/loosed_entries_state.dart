part of 'loosed_entries_bloc.dart';

sealed class LoosedEntriesState {
  /// The lectionsWithoutEntryList
  final List<Lection> lectionsWithoutEntryList;

  /// The list of users enties
  final List<Entry> entriesList;

  /// The list of lections
  final List<Lection> lectionsList;

  const LoosedEntriesState({
    required this.lectionsWithoutEntryList,
    required this.entriesList,
    required this.lectionsList,
  });

  /// The lectionsWithoutEntryList is idle.
  const factory LoosedEntriesState.idle({
    required List<Lection> lectionsWithoutEntryList,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
  }) = _IdleLoosedEntriesState;

  /// The lectionsWithoutEntryList is compairing.
  const factory LoosedEntriesState.compairing({
    required List<Lection> lectionsWithoutEntryList,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
  }) = _CompairingLoosedEntriesState;

  /// The lectionsWithoutEntryList is compared.
  const factory LoosedEntriesState.compared({
    required List<Lection> lectionsWithoutEntryList,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
  }) = _ComparedLoosedEntriesState;

  /// The lectionsWithoutEntryList has an error.
  const factory LoosedEntriesState.error({
    required Object error,
    required List<Lection> lectionsWithoutEntryList,
    required List<Entry> entriesList,
    required List<Lection> lectionsList,
  }) = _ErrorLoosedEntriesState;

  /// Check if state is idle.
  bool get isIdle => switch (this) {
        _IdleLoosedEntriesState _ => true,
        _ => false,
      };

  /// Check if state is compairing.
  bool get compairing => switch (this) {
        _CompairingLoosedEntriesState _ => true,
        _ => false,
      };

  /// Check if state is compared.
  bool get compared => switch (this) {
        _ComparedLoosedEntriesState _ => true,
        _ => false,
      };

  /// Check if state is error.
  bool get isError => switch (this) {
        _ErrorLoosedEntriesState _ => true,
        _ => false,
      };
}

final class _IdleLoosedEntriesState extends LoosedEntriesState {
  const _IdleLoosedEntriesState({
    required super.lectionsWithoutEntryList,
    required super.entriesList,
    required super.lectionsList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _IdleLoosedEntriesState &&
        other.lectionsWithoutEntryList == lectionsWithoutEntryList &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(
        lectionsWithoutEntryList,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'LoosedEntriesState.idle(lectionsWithoutEntryList: $lectionsWithoutEntryList, entriesList: $entriesList, lectionsList: $lectionsList)';
}

final class _CompairingLoosedEntriesState extends LoosedEntriesState {
  const _CompairingLoosedEntriesState({
    required super.lectionsWithoutEntryList,
    required super.entriesList,
    required super.lectionsList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _CompairingLoosedEntriesState &&
        other.lectionsWithoutEntryList == lectionsWithoutEntryList &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(
        lectionsWithoutEntryList,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'LoosedEntriesState.compairing(lectionsWithoutEntryList: $lectionsWithoutEntryList, entriesList: $entriesList, lectionsList: $lectionsList)';
}

final class _ComparedLoosedEntriesState extends LoosedEntriesState {
  const _ComparedLoosedEntriesState({
    required super.lectionsWithoutEntryList,
    required super.entriesList,
    required super.lectionsList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ComparedLoosedEntriesState &&
        other.lectionsWithoutEntryList == lectionsWithoutEntryList &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(
        lectionsWithoutEntryList,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'LoosedEntriesState.compared(lectionsWithoutEntryList: $lectionsWithoutEntryList, entriesList: $entriesList, lectionsList: $lectionsList)';
}

final class _ErrorLoosedEntriesState extends LoosedEntriesState {
  /// The error.
  final Object error;

  const _ErrorLoosedEntriesState({
    required this.error,
    required super.lectionsWithoutEntryList,
    required super.entriesList,
    required super.lectionsList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ErrorLoosedEntriesState &&
        other.lectionsWithoutEntryList == lectionsWithoutEntryList &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList) &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(
        error,
        lectionsWithoutEntryList,
        entriesList,
        lectionsList,
      );

  @override
  String toString() =>
      'LoosedEntriesState.error(lectionsWithoutEntryList: $lectionsWithoutEntryList, error: $error, entriesList: $entriesList, lectionsList: $lectionsList)';
}
