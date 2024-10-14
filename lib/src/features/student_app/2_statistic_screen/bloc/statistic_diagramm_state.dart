part of 'statistic_diagramm_bloc.dart';

sealed class StatisticDiagrammState extends Equatable {
  const StatisticDiagrammState();

  @override
  List<Object> get props => [];
}

final class StatisticDiagrammInitial extends StatisticDiagrammState {}

final class LoadingEntrysCountState extends StatisticDiagrammState {}

final class LoadedEntrysCountState extends StatisticDiagrammState {
  final int totalDays;
  final int? schoolVisitsCount;
  final int? homeOfficeCount;
  final int? sickCount;
  final int? looseCount;

  const LoadedEntrysCountState(
      {required this.totalDays,
      this.homeOfficeCount,
      this.sickCount,
      this.looseCount,
      this.schoolVisitsCount});
}
