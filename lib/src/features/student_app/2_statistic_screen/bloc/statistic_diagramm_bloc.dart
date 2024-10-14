import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_repository/group_repository.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_screen/domain/statistic_computing_service.dart';

part 'statistic_diagramm_event.dart';
part 'statistic_diagramm_state.dart';

class StatisticDiagrammBloc
    extends Bloc<StatisticDiagrammEvent, StatisticDiagrammState> {
  //Entries Repo
  final IEntryRepositoty _entriesRepository;
  //Entries Repo
  final IGroupRepository _groupRepository;
  final String studentGroupID;
  final StatisticComputingServise _computingService;
  late final StreamSubscription<List<Entry>?> _entrysListListener;

  StatisticDiagrammBloc(this.studentGroupID,
      {required IEntryRepositoty entriesRepository,
      required IGroupRepository groupRepository,
      required StatisticComputingServise computingService})
      : _entriesRepository = entriesRepository,
        _groupRepository = groupRepository,
        _computingService = computingService,
        super(StatisticDiagrammInitial()) {
    /// Subscription - Entries List from Repo
    _entrysListListener = entriesRepository.getVisits().listen(
      (entriesList) {
        if (entriesList != null && entriesList.isNotEmpty) {
          add(LoadSchoolVisitsCount(entriesList));
        }
      },
      cancelOnError: false,
    );

    on<LoadSchoolVisitsCount>(
      (event, emit) async {
        emit(LoadingEntrysCountState());
        if (event.entriesList!.isNotEmpty) {
          //TODO add exceptions check
          final totalDaysFromGroup = await groupRepository
              .getGroupData(studentGroupID)
              .first
              .then((group) => group.totalDays);

          final entrysList = event.entriesList;

          final schoolVisits =
              _computingService.computeSchoolVisitsQty(entrysList!);
          final homeOffice = _computingService.computeHomeOfficeQty(entrysList);
          final krank = _computingService.computeKrankQty(entrysList);
          final fehl = _computingService.computeFehlQty(entrysList);

          emit(LoadedEntrysCountState(
            totalDays: totalDaysFromGroup,
            schoolVisitsCount: schoolVisits,
            homeOfficeCount: homeOffice,
            sickCount: krank,
            looseCount: fehl,
          ));
        }
      },
      transformer: sequential(),
    );
  }
  @override
  Future<void> close() {
    _entrysListListener.cancel();
    log('EntrysStats subscription was cancelled');
    return super.close();
  }
}
