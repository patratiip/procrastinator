part of 'kursplan_bloc.dart';

abstract class KursplanState extends Equatable {
  const KursplanState();

  @override
  List<Object?> get props => [];
}

final class KursplanInitial extends KursplanState {}

final class LectionsListLoading extends KursplanState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class LectionsListLoaded extends KursplanState {
  final List<Lection> lectionsList;

  LectionsListLoaded({required this.lectionsList});

  @override
  // TODO: implement props
  List<Object?> get props => [lectionsList];
}

final class LectionsListFailure extends KursplanState {
  final String exception;

  LectionsListFailure({required this.exception});
  @override
  // TODO: implement props
  List<Object?> get props => [exception];
}
