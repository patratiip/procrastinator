part of 'last_entrys_list_bloc.dart';

abstract class EntrysListState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class EntrysListInitial extends EntrysListState {
  @override
  List<Object?> get props => [];
}

final class EntrysListLoading extends EntrysListState {
  @override
  List<Object?> get props => [];
}

final class EntrysListLoaded extends EntrysListState {
  final List<Entry>? userVisits;

  EntrysListLoaded({required this.userVisits});

  @override
  List<Object?> get props => [userVisits];
}

final class EntrysListFailure extends EntrysListState {
  final String exception;

  EntrysListFailure({required this.exception});
  @override
  List<Object?> get props => [exception];
}
