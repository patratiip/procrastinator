part of 'statistic_diagramm_bloc.dart';

sealed class StatisticDiagrammEvent extends Equatable {
  const StatisticDiagrammEvent();

  @override
  List<Object> get props => [];
}

class LoadSchoolVisitsCount extends StatisticDiagrammEvent {
  final List<Entry>? entriesList;

  const LoadSchoolVisitsCount(this.entriesList);
}
