part of 'last_entrys_list_bloc.dart';

@immutable
sealed class EntrysListEvent extends Equatable {
  const EntrysListEvent();

  @override
  List<Object?> get props => [];
}

class EntrysListChangedEvent extends EntrysListEvent {
  final List<Entry>? entriesList;

  const EntrysListChangedEvent(this.entriesList);
}

class DeleteEntry extends EntrysListEvent {
  final String entryRef;

  const DeleteEntry({required this.entryRef});

  @override
  List<Object?> get props => [entryRef];
}
