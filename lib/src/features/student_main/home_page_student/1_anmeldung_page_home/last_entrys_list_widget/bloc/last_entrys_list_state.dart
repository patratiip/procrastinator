part of 'last_entrys_list_bloc.dart';

abstract class EntrysListState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class EntrysListInitial extends EntrysListState {
  @override
  List<Object?> get props => [];
}

final class EntrysListLoadingState extends EntrysListState {
  @override
  List<Object?> get props => [];
}

final class EntrysListLoadedState extends EntrysListState {
  final List<Entry>? userVisits;

  EntrysListLoadedState({required this.userVisits});

  @override
  List<Object?> get props => [userVisits];
}

final class EntrysListFailure extends EntrysListState {
  final String exception;

  EntrysListFailure({required this.exception});
  @override
  List<Object?> get props => [exception];
}
