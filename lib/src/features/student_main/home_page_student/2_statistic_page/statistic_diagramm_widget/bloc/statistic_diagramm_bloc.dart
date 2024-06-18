import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_repository.dart';

part 'statistic_diagramm_event.dart';
part 'statistic_diagramm_state.dart';

class StatisticDiagrammBloc
    extends Bloc<StatisticDiagrammEvent, StatisticDiagrammState> {
  final StatisticRepositoryLocal _repositoryStatistic;
  //Entries Bloc
  final LastEntrysListBloc _entrysListBloc;
  late final StreamSubscription _entriesBloctreamSubscription;

  StatisticDiagrammBloc(this._entrysListBloc, this._repositoryStatistic)
      : super(StatisticDiagrammInitial()) {
    //Subscription - Entries Bloc
    _entriesBloctreamSubscription = _entrysListBloc.stream.listen(
      (state) {
        if (state is EntrysListLoadedState) {
          add(LoadSchoolVisitsCount(state.userVisits));
        }
      },
      cancelOnError: false,
    );

    on<LoadSchoolVisitsCount>(
      (event, emit) async {
        emit(LoadingEntrysCountState());
        if (event.entriesList!.isNotEmpty) {
          final entrysList = event.entriesList;

          // final schoolVisits = await _repositoryStatistic.getSchoolVisitsQty();
          // final homeOffice = await _repositoryStatistic.getHomeOfficeQty();
          // final krank = await _repositoryStatistic.getKrankQty();
          // final fehl = await _repositoryStatistic.getFehlQty();

          final schoolVisits =
              _repositoryStatistic.computeSchoolVisitsQty(entrysList!);
          final homeOffice =
              _repositoryStatistic.computeHomeOfficeQty(entrysList);
          final krank = _repositoryStatistic.computeKrankQty(entrysList);
          final fehl = _repositoryStatistic.computeFehlQty(entrysList);

          emit(LoadedEntrysCountState(
            schoolVisitsCount: schoolVisits,
            homeOfficeCount: homeOffice,
            krankCount: krank,
            fehlCount: fehl,
          ));
        }
      },
      transformer: sequential(),
    );

    @override
    Future<void> close() {
      _entriesBloctreamSubscription.cancel();
      print('Entrys subscription was cancelled');
      return super.close();
    }
  }
}
