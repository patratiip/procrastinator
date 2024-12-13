import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_repository/group_repository.dart';
import 'package:procrastinator/src/features/student_app/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/statistic/service/statistic_computing_service.dart';

part 'statistic_diagramm_event.dart';
part 'statistic_diagramm_state.dart';

class StatisticDiagrammBloc
    extends Bloc<StatisticDiagrammEvent, StatisticDiagrammState> {
  final IEntryRepositoty _entriesRepository;
  final IStudentGroupRepository _groupRepository;

  final StatisticComputingServise _computingService;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  final String studentGroupID;

  StatisticDiagrammBloc(this.studentGroupID,
      {required IEntryRepositoty entriesRepository,
      required IStudentGroupRepository groupRepository,
      required StatisticComputingServise computingService})
      : _entriesRepository = entriesRepository,
        _groupRepository = groupRepository,
        _computingService = computingService,
        super(StatisticDiagrammInitial()) {
    on<StatisticDiagrammEvent>(
      (event, emit) => switch (event) {
        final EntriesListChanged e => _entriesListChanged(e, emit),
      },
      transformer: sequential(),
    );

    /// Subscription - Entries List from Repo
    _entrysListListener = _entriesRepository.entriesStream().listen(
      (entriesList) {
        if (entriesList != null && entriesList.isNotEmpty) {
          add(EntriesListChanged(entriesList));
        }
      },
      cancelOnError: false,
    );
  }

  Future<void> _entriesListChanged(
      EntriesListChanged event, Emitter<StatisticDiagrammState> emit) async {
    try {
      emit(LoadingEntriesCountState());

      //TODO add exceptions check
      final totalDaysFromGroup = await _groupRepository
          .getGroupData(studentGroupID)
          .first
          .then((group) => group.totalDays);

      final entrysList = event.entriesList;

      final schoolVisits = _computingService.computeSchoolVisitsQty(entrysList);
      final homeOffice = _computingService.computeHomeOfficeQty(entrysList);
      final krank = _computingService.computeKrankQty(entrysList);
      final fehl = _computingService.computeFehlQty(entrysList);

      emit(
        LoadedEntriesCountState(
          totalDays: totalDaysFromGroup,
          schoolVisitsCount: schoolVisits,
          homeOfficeCount: homeOffice,
          sickCount: krank,
          looseCount: fehl,
        ),
      );
    } on Object catch (e, st) {
      onError(e, st);
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    log('EntrysStats subscription was cancelled');
    return super.close();
  }
}
