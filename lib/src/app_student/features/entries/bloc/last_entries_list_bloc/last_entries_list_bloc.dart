import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:procrastinator/src/app_student/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';

part 'last_entries_list_event.dart';
part 'last_entries_list_state.dart';

class EntriesListBloc extends Bloc<EntriesListEvent, LastEntriesListState> {
  final IEntryRepository _entriesRepository;
  late final StreamSubscription<List<Entry>?> _entriesListListener;

  EntriesListBloc({required entrysRepository})
      : _entriesRepository = entrysRepository,
        super(const _IdleLastEntriesListState(entriesList: [])) {
    on<EntriesListEvent>(
      (event, emit) => switch (event) {
        final _EntriesListEventChanged e => _entriesListEventChanged(e, emit),
        final _EntriesListEventDelete e => _entriesListEventDelete(e, emit)
      },
      transformer: sequential(),
    );

    // User entries collection subscription
    _entriesListListener = _entriesRepository.entriesStream().listen(
      (entriesList) {
        if (entriesList.isNotEmpty) {
          add(_EntriesListEventChanged(entriesList: entriesList));
        }
      },
      cancelOnError: false,
    );
  }

  /// User entries list changed
  Future<void> _entriesListEventChanged(_EntriesListEventChanged event,
      Emitter<LastEntriesListState> emit) async {
    try {
      emit(_LoadingLastEntriesListState(entriesList: state.entriesList));
      emit(_LoadedLastEntriesListState(entriesList: event.entriesList));
    } on Object catch (e, st) {
      onError(e, st);
      emit(
          _ErrorLastEntriesListState(entriesList: event.entriesList, error: e));
    } finally {
      emit(_IdleLastEntriesListState(entriesList: state.entriesList));
    }
  }

  /// Deleting entry
  Future<void> _entriesListEventDelete(
      _EntriesListEventDelete event, Emitter<LastEntriesListState> emit) async {
    try {
      emit(_LoadingLastEntriesListState(entriesList: state.entriesList));
      _entriesRepository.deleteEntry(event.entryRef);
    } on Object catch (e, st) {
      onError(e, st);
      emit(_ErrorLastEntriesListState(
          entryRef: event.entryRef, entriesList: state.entriesList, error: e));
    }
  }

  @override
  Future<void> close() {
    _entriesListListener.cancel();
    log('Entries collection subscription was cancelled');
    return super.close();
  }
}
