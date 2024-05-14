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
  final TodayLection? todayLection;

  TodayLectionLoaded({required this.todayLection});

  @override
  // TODO: implement props
  List<Object?> get props => [todayLection];
}

final class TodayLectionFailure extends TodayLessonState {
  final String exception;

  TodayLectionFailure({required this.exception});
  @override
  // TODO: implement props
  List<Object?> get props => [exception];
}
