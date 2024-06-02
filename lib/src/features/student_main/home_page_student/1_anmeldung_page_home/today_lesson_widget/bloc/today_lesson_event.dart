part of 'today_lesson_bloc.dart';

sealed class TodayLessonEvent extends Equatable {
  const TodayLessonEvent();

  @override
  List<Object> get props => [];
}

class LoadTodayLection extends TodayLessonEvent {}