part of 'lection_plan_bloc.dart';

sealed class LectionPlanState extends Equatable {
  const LectionPlanState();

  @override
  List<Object> get props => [];
}

final class LectionPlanInitialState extends LectionPlanState {}

final class LectionPlanLoadingState extends LectionPlanState {}

final class LectionPlanLoadedState extends LectionPlanState {
  const LectionPlanLoadedState({required this.lectionsList});
  final List<Lection> lectionsList;

  @override
  List<Object> get props => [lectionsList];
}

final class LectionPlanFailureState extends LectionPlanState {
  const LectionPlanFailureState({required this.exception});
  final Object exception;

  @override
  List<Object> get props => [exception];
}
