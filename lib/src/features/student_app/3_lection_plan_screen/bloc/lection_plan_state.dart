part of 'lection_plan_bloc.dart';

sealed class LectionPlanState extends Equatable {
  const LectionPlanState();

  @override
  List<Object?> get props => [];
}

final class LectionPlanInitialState extends LectionPlanState {}

final class LectionsListLoadingState extends LectionPlanState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class LectionsListLoadedState extends LectionPlanState {
  final List<Lection> lectionsList;

  const LectionsListLoadedState({required this.lectionsList});

  @override
  List<Object?> get props => [lectionsList];
}

final class LectionsListFailureState extends LectionPlanState {
  final String exception;

  const LectionsListFailureState({required this.exception});
  @override
  List<Object?> get props => [exception];
}
