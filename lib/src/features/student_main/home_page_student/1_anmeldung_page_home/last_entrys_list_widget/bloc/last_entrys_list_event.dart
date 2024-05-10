part of 'last_entrys_list_bloc.dart';

@immutable
sealed class LastEntrysListEvent {}

class LoadLastEntrys extends LastEntrysListEvent {}

class DeleteEntry extends LastEntrysListEvent {
  final String entryRef;

  DeleteEntry({required this.entryRef});
}
