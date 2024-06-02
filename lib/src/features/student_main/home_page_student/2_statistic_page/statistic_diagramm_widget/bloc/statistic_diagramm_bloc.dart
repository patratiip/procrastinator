import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_repository.dart';

part 'statistic_diagramm_event.dart';
part 'statistic_diagramm_state.dart';

class StatisticDiagrammBloc
    extends Bloc<StatisticDiagrammEvent, StatisticDiagrammState> {
  final StatisticRepository _repositoryStatistic;
  StatisticDiagrammBloc(this._repositoryStatistic)
      : super(StatisticDiagrammInitial()) {
    on<LoadSchoolVisitsCount>((event, emit) async {
      emit(LoadingEntrysCountState());
      final schoolVisits = await _repositoryStatistic.getSchoolVisitsQty();
      final homeOffice = await _repositoryStatistic.getHomeOfficeQty();
      final krank = await _repositoryStatistic.getKrankQty();
      final fehl = await _repositoryStatistic.getFehlQty();

      emit(LoadedEntrysCountState(
          schoolVisitsCount: schoolVisits,
          homeOfficeCount: homeOffice,
          krankCount: krank,
          fehlCount: fehl));
    });
  }
}
