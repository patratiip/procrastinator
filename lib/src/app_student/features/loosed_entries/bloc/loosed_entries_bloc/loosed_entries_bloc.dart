import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/app_student/features/loosed_entries/data/loosed_entries_repository.dart';

part 'loosed_entries_event.dart';
part 'loosed_entries_state.dart';

class LoosedEntriesBloc extends Bloc<LoosedEntriesEvent, LoosedEntriesState> {
  final ILoosedEntriesRepository _loosedEntriesRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  LoosedEntriesBloc({
    required ILoosedEntriesRepository loosedEntriesRepository,
  })  : _loosedEntriesRepository = loosedEntriesRepository,
        super(const _IdleLoosedEntriesState(
          lectionsWithoutEntryList: [],
          entriesList: [],
          lectionsList: [],
        )) {
    on<LoosedEntriesEvent>(
      (event, emit) => switch (event) {
        final _LoosedEntriesEventChanged e =>
          _loosedEntriesEventChanged(e, emit),
      },
      transformer: sequential(),
    );

    /// Subscription - Entries List from Repo
    _entrysListListener = _loosedEntriesRepository.entriesStream().listen(
      (entriesList) {
        add(_LoosedEntriesEventChanged(entriesList: entriesList));
      },
      cancelOnError: false,
    );

    /// Subscription - Lessons List from Repo
    _lectionListListener = _loosedEntriesRepository.lectionsStream().listen(
      (lectionsList) {
        add(_LoosedEntriesEventChanged(lectionsList: lectionsList));
      },
      cancelOnError: false,
    );
  }

  /// [Lection] or [Entry] stream heve some changes
  Future<void> _loosedEntriesEventChanged(_LoosedEntriesEventChanged event,
      Emitter<LoosedEntriesState> emit) async {
    try {
      emit(_CompairingLoosedEntriesState(
        entriesList: event.entriesList ?? state.entriesList,
        lectionsList: event.lectionsList ?? state.lectionsList,
        lectionsWithoutEntryList: state.lectionsWithoutEntryList,
      ));
      final loosedLections = await _loosedEntriesRepository
          .comareLectionsAndEntries(state.lectionsList, state.entriesList);

      emit(_ComparedLoosedEntriesState(
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        lectionsWithoutEntryList: loosedLections,
      ));
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
      emit(_ErrorLoosedEntriesState(
        error: error,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        lectionsWithoutEntryList: state.lectionsWithoutEntryList,
      ));
    } finally {
      emit(_IdleLoosedEntriesState(
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
        lectionsWithoutEntryList: state.lectionsWithoutEntryList,
      ));
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
