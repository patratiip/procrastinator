part of 'statistic_diagramm_bloc.dart';

sealed class StatisticDiagrammEvent extends Equatable {
  const StatisticDiagrammEvent();

  @override
  List<Object> get props => [];
}

class EntriesListChanged extends StatisticDiagrammEvent {
  final List<Entry> entriesList;

  const EntriesListChanged(this.entriesList);

  @override
  List<Object> get props => [entriesList];
}
