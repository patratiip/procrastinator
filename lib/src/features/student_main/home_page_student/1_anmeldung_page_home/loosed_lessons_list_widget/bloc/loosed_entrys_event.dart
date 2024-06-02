part of 'loosed_entrys_bloc.dart';

sealed class LoosedEntrysEvent extends Equatable {
  const LoosedEntrysEvent();

  @override
  List<Object> get props => [];
}

class ComairingLectionsAndVisitsEvent extends LoosedEntrysEvent {
  // List<Lection>? lectionsList;
  // List<Entry>? entriesList;

  ComairingLectionsAndVisitsEvent(
      // this.lectionsList,
      // this.entriesList,
      );
}
