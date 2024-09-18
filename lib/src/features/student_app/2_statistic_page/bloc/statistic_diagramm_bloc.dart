import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_page/domain/statistic_computing_service.dart';

part 'statistic_diagramm_event.dart';
part 'statistic_diagramm_state.dart';

class StatisticDiagrammBloc
    extends Bloc<StatisticDiagrammEvent, StatisticDiagrammState> {
  final StatisticComputingServise _computingService;
  //Entries Repo
  final EntryRepositoty _entriesRepository;
  late final StreamSubscription<List<Entry>?> _entrysListListener;

  StatisticDiagrammBloc(
      {required EntryRepositoty entriesRepository,
      required StatisticComputingServise computingService})
      : _entriesRepository = entriesRepository,
        _computingService = computingService,
        super(StatisticDiagrammInitial()) {
    //Subscription - Entries List from Repo
    _entrysListListener = entriesRepository.getVisits().listen(
      (entriesList) {
        if (entriesList != null && entriesList.isNotEmpty) {
          add(LoadSchoolVisitsCount(entriesList));
        }
      },
      // cancelOnError: false,
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
  }
  @override
  Future<void> close() {
    _entrysListListener.cancel();
    print('EntrysStats subscription was cancelled');
    return super.close();
  }
}
