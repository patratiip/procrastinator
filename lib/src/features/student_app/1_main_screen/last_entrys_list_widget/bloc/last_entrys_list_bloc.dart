import 'dart:async';
import 'dart:developer';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'last_entrys_list_event.dart';
part 'last_entrys_list_state.dart';

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
    _entrysListListener = _entriesRepository.getVisits().listen(
      (entrysList) {
        add(EntriesListChangedEvent(entrysList));
      },
      cancelOnError: false,
    );
  }

  Future<void> _entriesListChangedEvent(
      EntriesListChangedEvent event, Emitter<EntriesListState> emit) async {
    if (event.entriesList != null) {
      final entriesList = event.entriesList;
      emit(EntriesListLoadedState(userVisits: entriesList));
    } else {
      emit(EntriesListLoadingState());
    }
  }

  Future<void> _deleteEntryEvent(
      DeleteEntryEvent event, Emitter<EntriesListState> emit) async {
    try {
      emit(EntriesListLoadingState());
      _entriesRepository.deleteEntry(event.entryRef);
    } on Object catch (e, st) {
      onError(e, st);
    }
  }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    log('Entries subscription was cancelled');
    return super.close();
  }
}
