import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_computing_service.dart';

part 'statistic_diagramm_event.dart';
part 'statistic_diagramm_state.dart';

class StatisticDiagrammBloc
    extends Bloc<StatisticDiagrammEvent, StatisticDiagrammState> {
  final StatisticComputingServise _computingService;
  //Entries Bloc
  final EntrysListBloc _entrysListBloc;
  late final StreamSubscription _entriesBloctreamSubscription;

  StatisticDiagrammBloc(this._entrysListBloc, this._computingService)
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

          final schoolVisits =
              _computingService.computeSchoolVisitsQty(entrysList!);
          final homeOffice = _computingService.computeHomeOfficeQty(entrysList);
          final krank = _computingService.computeKrankQty(entrysList);
          final fehl = _computingService.computeFehlQty(entrysList);

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
