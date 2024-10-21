import 'dart:async';
import 'dart:developer';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'last_entrys_list_event.dart';
part 'last_entrys_list_state.dart';

class EntrysListBloc extends Bloc<EntriesListEvent, EntriesListState> {
  final IEntryRepositoty _entriesRepository;
  late final StreamSubscription<List<Entry>?> _entrysListListener;

  EntrysListBloc({required entrysRepository})
      : _entriesRepository = entrysRepository,
        super(EntriesListInitial()) {
    //Subscription
    _entrysListListener = _entriesRepository.getVisits().listen(
      (entrysList) {
        add(EntriesListChangedEvent(entrysList));
      },
      cancelOnError: false,
    );

    on<EntriesListChangedEvent>(
      (event, emit) {
        if (event.entriesList != null) {
          final entriesList = event.entriesList;

          emit(EntriesListLoadedState(userVisits: entriesList));
        } else {
          emit(EntriesListLoadingState());
        }
      },
      transformer: sequential(),
    );

    on<DeleteEntryEvent>(
      (event, emit) async {
        emit(EntriesListLoadingState());

        _entriesRepository.deleteEntry(event.entryRef);
      },
    );
  }
  @override
  Future<void> close() {
    _entrysListListener.cancel();
    log('Entries subscription was cancelled');
    return super.close();
  }
}
