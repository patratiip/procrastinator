part of 'loosed_entrys_bloc.dart';

sealed class LoosedEntrysEvent extends Equatable {
  const LoosedEntrysEvent();

  @override
  List<Object> get props => [];
}

class ComairingLectionsAndVisits extends LoosedEntrysEvent {
  Completer? completer;

  ComairingLectionsAndVisits( {this.completer});
}
