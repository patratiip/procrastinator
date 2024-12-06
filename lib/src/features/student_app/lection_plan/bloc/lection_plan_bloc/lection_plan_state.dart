part of 'lection_plan_bloc.dart';

sealed class LectionPlanState extends Equatable {
  const LectionPlanState();

  @override
  List<Object> get props => [];
}

final class LectionPlanInitialState extends LectionPlanState {}

final class LectionPlanLoadingState extends LectionPlanState {}

final class LectionPlanLoadedState extends LectionPlanState {
  final List<Lection> lectionsList;
  const LectionPlanLoadedState({required this.lectionsList});

  @override
  List<Object> get props => [lectionsList];
}

final class LectionPlanFailureState extends LectionPlanState {
  final Object exception;
  const LectionPlanFailureState({required this.exception});

  @override
  List<Object> get props => [exception];
}
