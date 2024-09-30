part of 'statistic_diagramm_bloc.dart';

sealed class StatisticDiagrammState extends Equatable {
  const StatisticDiagrammState();

  @override
  List<Object> get props => [];
}

final class StatisticDiagrammInitial extends StatisticDiagrammState {}

final class LoadingEntrysCountState extends StatisticDiagrammState {}

final class LoadedEntrysCountState extends StatisticDiagrammState {
  final int? schoolVisitsCount;
  final int? homeOfficeCount;
  final int? krankCount;
  final int? fehlCount;

  const LoadedEntrysCountState(
      {this.homeOfficeCount,
      this.krankCount,
      this.fehlCount,
      this.schoolVisitsCount});
}
