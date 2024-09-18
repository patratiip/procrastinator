part of 'loosed_entries_bloc.dart';

abstract class LoosedEntriesState extends Equatable {}

final class LoosedEntrysInitial extends LoosedEntriesState {
  @override
  List<Object?> get props => [];
}

final class CompairingEntrysState extends LoosedEntriesState {
  @override
  List<Object?> get props => [];
}

final class ComaredEntrysState extends LoosedEntriesState {
  final List<Lection>? loosedLectionsList;

  ComaredEntrysState({required this.loosedLectionsList});

  @override
  List<Object?> get props => [loosedLectionsList];
}

final class CopmaredAllClear extends LoosedEntriesState {
  @override
  List<Object?> get props => [];
}

final class CompairingEntrysFailure extends LoosedEntriesState {
  final Object? exception;

  CompairingEntrysFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
