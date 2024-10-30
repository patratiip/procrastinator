part of 'loosed_entries_bloc.dart';

sealed class LoosedEntriesState extends Equatable {
  const LoosedEntriesState();
  @override
  List<Object?> get props => [];
}

final class LoosedEntrysInitial extends LoosedEntriesState {
  const LoosedEntrysInitial();
}

final class CompairingEntrysState extends LoosedEntriesState {
  const CompairingEntrysState();
}

final class ComparedEntrysState extends LoosedEntriesState {
  final List<Lection> loosedLectionsList;

  const ComparedEntrysState({required this.loosedLectionsList});

  @override
  List<Object> get props => [loosedLectionsList];
}

final class ComparedAllClear extends LoosedEntriesState {
  const ComparedAllClear();
}

final class CompairingLoosedEntriesFailure extends LoosedEntriesState {
  final Object exception;

  const CompairingLoosedEntriesFailure({required this.exception});
  @override
  List<Object> get props => [exception];
}
