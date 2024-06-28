part of 'today_lesson_bloc.dart';

sealed class TodayLessonState extends Equatable {
  const TodayLessonState();

  @override
  List<Object?> get props => [];
}

final class TodayLessonInitial extends TodayLessonState {}

final class TodayLectionLoading extends TodayLessonState {
  @override
  List<Object?> get props => [];
}

final class TodayLectionLoaded extends TodayLessonState {
  final Lection? todayLection;

  const TodayLectionLoaded({required this.todayLection});

  @override
  List<Object?> get props => [todayLection];
}

final class TodayLessonEmpty extends TodayLessonState {}

final class TodayLectionFailure extends TodayLessonState {
  final String exception;

  const TodayLectionFailure({required this.exception});
  @override
  List<Object?> get props => [exception];
}
