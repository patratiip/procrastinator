part of 'last_entries_list_bloc.dart';

sealed class EntriesListEvent extends Equatable {
  const EntriesListEvent();

  @override
  List<Object?> get props => [];
}

final class EntriesListChangedEvent extends EntriesListEvent {
  final List<Entry>? entriesList;

  const EntriesListChangedEvent(this.entriesList);

  @override
  List<Object?> get props => [entriesList];
}

final class DeleteEntryEvent extends EntriesListEvent {
  final String entryRef;

  const DeleteEntryEvent({required this.entryRef});

  @override
  List<Object> get props => [entryRef];
}
