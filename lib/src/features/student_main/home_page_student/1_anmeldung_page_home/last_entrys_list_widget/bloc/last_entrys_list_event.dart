part of 'last_entrys_list_bloc.dart';

@immutable
sealed class LastEntrysListEvent extends Equatable {}

class LoadLastEntrys extends LastEntrysListEvent {
  @override
  List<Object?> get props => [];
}

class DeleteEntry extends LastEntrysListEvent {
  final String entryRef;

  DeleteEntry({required this.entryRef});

  @override
  List<Object?> get props => [entryRef];
}
