part of 'lection_plan_bloc.dart';

sealed class LectionPlanEvent extends Equatable {
  const LectionPlanEvent();

  @override
  List<Object?> get props => [];
}

final class LectionsListChangedEvent extends LectionPlanEvent {
  final List<Lection>? lectionsList;

  const LectionsListChangedEvent(this.lectionsList);
  @override
  List<Object?> get props => [lectionsList];
}
