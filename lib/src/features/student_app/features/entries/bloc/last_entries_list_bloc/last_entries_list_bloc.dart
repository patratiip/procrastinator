import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:procrastinator/src/features/student_app/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';

part 'last_entries_list_event.dart';
part 'last_entries_list_state.dart';

class EntriesListBloc extends Bloc<EntriesListEvent, EntriesListState> {
  final IEntryRepositoty _entriesRepository;
  late final StreamSubscription<List<Entry>?> _entrysListListener;

  EntriesListBloc({required entrysRepository})
      : _entriesRepository = entrysRepository,
        super(EntriesListInitial()) {
    on<EntriesListEvent>(
      (event, emit) => switch (event) {
        final EntriesListChangedEvent e => _entriesListChangedEvent(e, emit),
        final DeleteEntryEvent e => _deleteEntryEvent(e, emit)
      },
      transformer: sequential(),
    );

    // Users entries collection subscription
    _entrysListListener = _entriesRepository.entriesStream().listen(
      (entrysList) {
        if (entrysList != null && entrysList.isNotEmpty) {
          add(EntriesListChangedEvent(entrysList));
        }
      },
      cancelOnError: false,
    );
  }

  Future<void> _entriesListChangedEvent(
      EntriesListChangedEvent event, Emitter<EntriesListState> emit) async {
    try {
      emit(EntriesListLoadingState());
      emit(EntriesListLoadedState(userVisits: event.entriesList));
    } on Object catch (e, st) {
      onError(e, st);
      emit(EntriesListFailure(exception: e));
    }
  }

  Future<void> _deleteEntryEvent(
      DeleteEntryEvent event, Emitter<EntriesListState> emit) async {
    try {
      emit(EntriesListLoadingState());
      _entriesRepository.deleteEntry(event.entryRef);
    } on Object catch (e, st) {
      onError(e, st);
      emit(EntriesListFailure(exception: e));
    }
  }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    log('Entries subscription was cancelled');
    return super.close();
  }
}
