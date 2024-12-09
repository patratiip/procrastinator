part of 'last_entries_list_bloc.dart';

sealed class EntriesListState extends Equatable {
  const EntriesListState();
  @override
  List<Object> get props => [];
}

final class EntriesListInitial extends EntriesListState {
  @override
  List<Object> get props => [];
}

final class EntriesListLoadingState extends EntriesListState {
  @override
  List<Object> get props => [];
}

final class EntriesListLoadedState extends EntriesListState {
  final List<Entry> userVisits;

  const EntriesListLoadedState({required this.userVisits});

  @override
  List<Object> get props => [userVisits];
}

final class EntriesListFailure extends EntriesListState {
  final Object exception;

  const EntriesListFailure({required this.exception});
  @override
  List<Object> get props => [exception];
}
