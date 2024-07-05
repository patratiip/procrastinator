part of 'loosed_entrys_bloc.dart';

abstract class LoosedEntrysState extends Equatable {}

final class LoosedEntrysInitial extends LoosedEntrysState {
  @override
  List<Object?> get props => [];
}

final class CompairingEntrysState extends LoosedEntrysState {
  @override
  List<Object?> get props => [];
}

final class ComaredEntrysState extends LoosedEntrysState {
  final List<Lection>? loosedLectionsList;

  ComaredEntrysState({required this.loosedLectionsList});

  @override
  List<Object?> get props => [loosedLectionsList];
}

final class CopmaredAllClear extends LoosedEntrysState {
  @override
  List<Object?> get props => [];
}

final class CompairingEntrysFailure extends LoosedEntrysState {
  final Object? exception;

  CompairingEntrysFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
