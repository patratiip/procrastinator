// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'loosed_entries_bloc.dart';

sealed class LoosedEntriesEvent {
  /// The lectionsList
  final List<Lection>? lectionsList;

  /// The entriesList
  final List<Entry>? entriesList;

  const LoosedEntriesEvent({
     this.lectionsList,
     this.entriesList,
  });

  /// The lectionsList changed.
  const factory LoosedEntriesEvent.lectionsListChanged({
     List<Lection> lectionsList,
     List<Entry> entriesList,
  }) = _LoosedEntriesEventChanged;
}

final class _LoosedEntriesEventChanged extends LoosedEntriesEvent {
  const _LoosedEntriesEventChanged({
     super.lectionsList,
     super.entriesList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _LoosedEntriesEventChanged &&
        listEquals(other.entriesList, entriesList) &&
        listEquals(other.lectionsList, lectionsList);
  }

  @override
  int get hashCode => Object.hash(entriesList, lectionsList);

  @override
  String toString() =>
      'LoosedEntriesEvent.lectionsListChanged( entriesList: $entriesList, lectionsList: $lectionsList)';
}
