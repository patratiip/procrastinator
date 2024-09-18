part of 'kursplan_bloc.dart';

sealed class KursplanEvent extends Equatable {
  const KursplanEvent();

  @override
  List<Object> get props => [];
}

class LectionsListChangedEvent extends KursplanEvent {
  final List<Lection>? lectionsList;

  const LectionsListChangedEvent(this.lectionsList);
}
