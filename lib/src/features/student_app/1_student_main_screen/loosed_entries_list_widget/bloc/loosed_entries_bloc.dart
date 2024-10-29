import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/loosed_entries_list_widget/service/comaring_loosed_entries_repository.dart';

part 'loosed_entries_event.dart';
part 'loosed_entries_state.dart';

class LoosedEntriesBloc extends Bloc<LoosedEntriesEvent, LoosedEntriesState> {
  final ComparingLectionsAndEntriesService _comaringService;
  final IEntryRepositoty _entriesRepository;
  final ILectionRepository _lectionsRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  LoosedEntriesBloc(
      {required IEntryRepositoty entriesRepository,
      required ILectionRepository lectionsRepository,
      required comaringService})
      : _comaringService = comaringService,
        _entriesRepository = entriesRepository,
        _lectionsRepository = lectionsRepository,
        super(LoosedEntrysInitial()) {
    //
    on<LoosedEntriesEvent>(
      (event, emit) => switch (event) {
        final ComairingLectionsAndVisitsEvent e =>
          _comairingLectionsAndVisitsEvent(e, emit),
      },
      transformer: sequential(),
    );

    List<Entry> entriesListFromStream = [];
    List<Lection> lectionsListFromStream = [];

    /// Subscription - Entries List from Repo
    _entrysListListener = _entriesRepository.getVisits().listen(
      (entriesList) {
        if (entriesList != null && entriesList.isNotEmpty) {
          entriesListFromStream = entriesList;
        }
        if (entriesListFromStream.isNotEmpty &&
            lectionsListFromStream.isNotEmpty) {
          add(ComairingLectionsAndVisitsEvent(
            lectionsListFromStream,
            entriesListFromStream,
          ));
        }
      },
      cancelOnError: false,
    );

    /// Subscription - Lessons List from Repo
    _lectionListListener = _lectionsRepository.getLections().listen(
      (lectionsList) {
        if (lectionsList != null && lectionsList.isNotEmpty) {
          lectionsListFromStream = lectionsList;
        }
        if (lectionsListFromStream.isNotEmpty &&
            entriesListFromStream.isNotEmpty) {
          add(ComairingLectionsAndVisitsEvent(
            lectionsListFromStream,
            entriesListFromStream,
          ));
        }
      },
      cancelOnError: false,
    );
  }

  Future<void> _comairingLectionsAndVisitsEvent(
      ComairingLectionsAndVisitsEvent event,
      Emitter<LoosedEntriesState> emit) async {
    if (event.entriesList!.isNotEmpty && event.lectionsList!.isNotEmpty) {
      emit(CompairingEntrysState());

      final loosedLections = _comaringService.comareLectionsAndEntrysState(
        event.lectionsList,
        event.entriesList,
      );

      if (loosedLections.isNotEmpty) {
        emit(ComaredEntrysState(loosedLectionsList: loosedLections));
      } else {
        emit(CopmaredAllClear());
      }
    }
  }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    _lectionListListener.cancel();
    log('Loosed lections subscription was cancelled');
    return super.close();
  }
}
