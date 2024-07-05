part of 'last_entrys_list_bloc.dart';


sealed class EntrysListEvent extends Equatable {
  const EntrysListEvent();

  @override
  List<Object?> get props => [];
}

class EntrysListChangedEvent extends EntrysListEvent {
  final List<Entry>? entriesList;

  const EntrysListChangedEvent(this.entriesList);

  @override
  List<Object?> get props => [entriesList];
}

// class AddEntryToListEvent extends EntrysListEvent {
//   final Entry? entry;

//   const AddEntryToListEvent(this.entry);
// }

class DeleteEntryEvent extends EntrysListEvent {
  final String entryRef;

  const DeleteEntryEvent({required this.entryRef});

  @override
  List<Object?> get props => [entryRef];
}
