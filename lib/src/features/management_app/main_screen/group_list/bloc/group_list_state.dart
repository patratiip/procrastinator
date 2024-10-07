part of 'group_list_bloc.dart';

sealed class GroupListState extends Equatable {
  const GroupListState();
  
  @override
  List<Object?> get props => [];
}

final class GroupListInitial extends GroupListState {}

final class GroupListLoadingState extends GroupListState {
  @override
  List<Object?> get props => [];
}

final class GroupListLoadedState extends GroupListState {
  final List<Group>? groupList;

  const GroupListLoadedState({required this.groupList});

  @override
  List<Object?> get props => [groupList];
}

final class GroupListFailure extends GroupListState {
  final String exception;

  const GroupListFailure({required this.exception});
  @override
  List<Object?> get props => [exception];
}