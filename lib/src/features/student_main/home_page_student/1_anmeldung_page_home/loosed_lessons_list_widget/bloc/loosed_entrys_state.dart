part of 'loosed_entrys_bloc.dart';

sealed class LoosedEntrysState extends Equatable {
  const LoosedEntrysState();

  @override
  List<Object> get props => [];
}

final class LoosedEntrysInitial extends LoosedEntrysState {}

final class CompareEntrysState extends LoosedEntrysState {}

final class ComaredEntrysState extends LoosedEntrysState {
  final List<Lection> loosedLectionsList;

  const ComaredEntrysState({required this.loosedLectionsList});
}
