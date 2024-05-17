part of 'last_entrys_list_bloc.dart';

abstract class LastEntrysListState extends Equatable {}

final class LastEntrysListInitial extends LastEntrysListState {
  @override
  List<Object?> get props => [];
}

final class LastEntrysListLoading extends LastEntrysListState {
  @override
  List<Object?> get props => [];
}

final class LastEntrysListLoaded extends LastEntrysListState {
  final List<Entry> userVisits;

  LastEntrysListLoaded({required this.userVisits});

  @override
  List<Object?> get props => [userVisits];
}

final class LastEntrysListFailure extends LastEntrysListState {
  final String exception;

  LastEntrysListFailure({required this.exception});
  @override
  List<Object?> get props => [exception];
}
