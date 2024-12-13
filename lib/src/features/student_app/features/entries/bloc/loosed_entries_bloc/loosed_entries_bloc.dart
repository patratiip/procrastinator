import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entries/data/firebase_entry_repository.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/data/lection_repository.dart';

part 'loosed_entries_event.dart';
part 'loosed_entries_state.dart';

class LoosedEntriesBloc extends Bloc<LoosedEntriesEvent, LoosedEntriesState> {
  final IEntryRepositoty _entriesRepository;
  final ILectionRepository _lectionsRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  LoosedEntriesBloc({
    required IEntryRepositoty entriesRepository,
    required ILectionRepository lectionsRepository,
  })  : _entriesRepository = entriesRepository,
        _lectionsRepository = lectionsRepository,
        super(const LoosedEntrysInitial()) {
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
    _entrysListListener = _entriesRepository.entriesStream().listen(
      (entriesList) {
        if (entriesList != null && entriesList.isNotEmpty) {
          entriesListFromStream = entriesList;
        }
        if (entriesListFromStream.isNotEmpty &&
            lectionsListFromStream.isNotEmpty) {
          add(ComairingLectionsAndVisitsEvent(
              entriesList: entriesListFromStream,
              lectionsList: lectionsListFromStream));
        }
      },
      cancelOnError: false,
    );

    /// Subscription - Lessons List from Repo
    _lectionListListener = _lectionsRepository.lectionsStream().listen(
      (lectionsList) {
        if (lectionsList.isNotEmpty) {
          lectionsListFromStream = lectionsList;
        }
        if (lectionsListFromStream.isNotEmpty &&
            entriesListFromStream.isNotEmpty) {
          add(ComairingLectionsAndVisitsEvent(
            entriesList: entriesListFromStream,
            lectionsList: lectionsListFromStream,
          ));
        }
      },
      cancelOnError: false,
    );
  }

  Future<void> _comairingLectionsAndVisitsEvent(
      ComairingLectionsAndVisitsEvent event,
      Emitter<LoosedEntriesState> emit) async {
    emit(const CompairingEntrysState());

    final loosedLections =
        _comareLectionsAndEntries(event.lectionsList, event.entriesList);

    if (loosedLections.isNotEmpty) {
      emit(ComparedEntrysState(loosedLectionsList: loosedLections));
    } else {
      emit(const ComparedAllClear());
    }
  }

  List<Lection> _comareLectionsAndEntries(
    List<Lection> lectionList,
    List<Entry> entryList,
  ) {
    final filteredLectionsList = lectionList
        .where((lection) => lection.date.isBefore(DateTime.now()))
        .toList();

    final List<Lection> loosedLectionsList = [];

    if (filteredLectionsList.isNotEmpty) {
      for (final lection in filteredLectionsList) {
        bool found = false;
        for (final visit in entryList) {
          if (visit.date == lection.date) {
            found = true;
            break;
          }
        }
        if (!found) {
          loosedLectionsList.add(lection);
        }
      }
    }
    return loosedLectionsList;
  }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    _lectionListListener.cancel();
    log('Loosed lections subscription was cancelled');
    return super.close();
  }
}
