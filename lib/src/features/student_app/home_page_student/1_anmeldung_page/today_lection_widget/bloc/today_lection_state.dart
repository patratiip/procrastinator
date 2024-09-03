part of 'today_lection_bloc.dart';

sealed class TodayLectionState extends Equatable {
  const TodayLectionState();

  @override
  List<Object?> get props => [];
}

final class TodayLessonInitial extends TodayLectionState {}

final class TodayLectionLoading extends TodayLectionState {
  @override
  List<Object?> get props => [];
}

final class TodayLectionLoaded extends TodayLectionState {
  final Lection? todayLection;

  const TodayLectionLoaded({required this.todayLection});

  @override
  List<Object?> get props => [todayLection];
}

final class TodayLectionEmpty extends TodayLectionState {}

final class TodayLectionFailure extends TodayLectionState {
  final String exception;

  const TodayLectionFailure({required this.exception});
  @override
  List<Object?> get props => [exception];
}
