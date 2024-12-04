part of 'today_lection_bloc.dart';

sealed class TodayLectionEvent extends Equatable {
  const TodayLectionEvent();

  @override
  List<Object> get props => [];
}

final class LoadTodayLection extends TodayLectionEvent {}
