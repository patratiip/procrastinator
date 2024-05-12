part of 'today_lesson_bloc.dart';

sealed class TodayLessonState extends Equatable {
  const TodayLessonState();

  @override
  List<Object?> get props => [];
}

final class TodayLessonInitial extends TodayLessonState {}

final class TodayLectionLoading extends TodayLessonState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class TodayLectionLoaded extends TodayLessonState {
  final List<TodayLection> lectionsList;

  TodayLectionLoaded({required this.lectionsList});

  @override
  // TODO: implement props
  List<Object?> get props => [lectionsList];
}

final class TodayLectionFailure extends TodayLessonState {
  final String exception;

  TodayLectionFailure({required this.exception});
  @override
  // TODO: implement props
  List<Object?> get props => [exception];
}
