part of 'statistic_diagramm_bloc.dart';

sealed class StatisticDiagrammState extends Equatable {
  const StatisticDiagrammState();

  @override
  List<Object?> get props => [];
}

final class StatisticDiagrammInitial extends StatisticDiagrammState {}

final class LoadingEntriesCountState extends StatisticDiagrammState {}

final class LoadedEntriesCountState extends StatisticDiagrammState {
  final int totalDays;
  final int? schoolVisitsCount;
  final int? homeOfficeCount;
  final int? sickCount;
  final int? looseCount;

  const LoadedEntriesCountState(
      {required this.totalDays,
      this.homeOfficeCount,
      this.sickCount,
      this.looseCount,
      this.schoolVisitsCount});

  @override
  List<Object?> get props => [
        totalDays,
        schoolVisitsCount,
        homeOfficeCount,
        sickCount,
        looseCount,
      ];
}
