part of 'last_entrys_list_bloc.dart';

sealed class EntriesListEvent extends Equatable {
  const EntriesListEvent();

  @override
  List<Object?> get props => [];
}

class EntriesListChangedEvent extends EntriesListEvent {
  final List<Entry>? entriesList;

  const EntriesListChangedEvent(this.entriesList);

  @override
  List<Object?> get props => [entriesList];
}


class DeleteEntryEvent extends EntriesListEvent {
  final String entryRef;

  const DeleteEntryEvent({required this.entryRef});

  @override
  List<Object?> get props => [entryRef];
}
