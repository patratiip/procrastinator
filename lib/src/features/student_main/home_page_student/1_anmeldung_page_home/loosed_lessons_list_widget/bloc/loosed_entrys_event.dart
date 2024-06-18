// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'loosed_entrys_bloc.dart';

sealed class LoosedEntrysEvent extends Equatable {
  const LoosedEntrysEvent();

  @override
  List<Object> get props => [];
}

class ComairingLectionsAndVisitsEvent extends LoosedEntrysEvent {
  List<Lection>? lectionsList;
  List<Entry>? entriesList;

  ComairingLectionsAndVisitsEvent(
    this.lectionsList,
    this.entriesList,
  );

  // ComairingLectionsAndVisitsEvent copyWith({
  //   List<Lection>? lectionsList,
  //   List<Entry>? entriesList,
  // }) {
  //   return ComairingLectionsAndVisitsEvent(
  //     lectionsList ?? this.lectionsList,
  //     entriesList ?? this.entriesList,
  //   );
  // }
}
