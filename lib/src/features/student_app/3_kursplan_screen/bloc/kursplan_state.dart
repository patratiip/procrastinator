part of 'kursplan_bloc.dart';

abstract class KursplanState extends Equatable {
  const KursplanState();

  @override
  List<Object?> get props => [];
}

final class KursplanInitialState extends KursplanState {}

final class LectionsListLoadingState extends KursplanState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class LectionsListLoadedState extends KursplanState {
  final List<Lection> lectionsList;

  const LectionsListLoadedState({required this.lectionsList});

  @override
  List<Object?> get props => [lectionsList];
}

final class LectionsListFailureState extends KursplanState {
  final String exception;

  const LectionsListFailureState({required this.exception});
  @override
  List<Object?> get props => [exception];
}
