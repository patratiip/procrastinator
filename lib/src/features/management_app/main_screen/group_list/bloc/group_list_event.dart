part of 'group_list_bloc.dart';

sealed class GroupListEvent extends Equatable {
  const GroupListEvent();

  @override
  List<Object?> get props => [];
}

class GroupListChangedEvent extends GroupListEvent {
  final List<Group>? groupList;

  const GroupListChangedEvent(this.groupList);

  @override
  List<Object?> get props => [groupList];
}

// class AddEntryToListEvent extends EntrysListEvent {
//   final Entry? entry;

//   const AddEntryToListEvent(this.entry);
// }

class DeletGroupEvent extends GroupListEvent {
  final String groupRef;

  const DeletGroupEvent({required this.groupRef});

  @override
  List<Object?> get props => [groupRef];
}
