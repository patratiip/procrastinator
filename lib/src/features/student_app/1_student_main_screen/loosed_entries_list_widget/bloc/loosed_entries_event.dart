// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'loosed_entries_bloc.dart';

sealed class LoosedEntriesEvent extends Equatable {
  const LoosedEntriesEvent();

  @override
  List<Object> get props => [];
}

final class ComairingLectionsAndVisitsEvent extends LoosedEntriesEvent {
  final List<Lection> lectionsList;
  final List<Entry> entriesList;

  const ComairingLectionsAndVisitsEvent(
      {required this.lectionsList, required this.entriesList});

  @override
  List<Object> get props => [lectionsList, entriesList];
}
