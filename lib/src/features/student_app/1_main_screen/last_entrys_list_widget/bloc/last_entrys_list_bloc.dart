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
        // print('Entrys Stream Listener Bloc: $entrysList');
      },
      // onError: (error, stackTrace) {
      //   print('Error in entries stream: $error');

      //   print('StackTrace: $stackTrace');
      // },
      cancelOnError: false,
    );

    // on<AddEntryToListEvent>(
    //   (event, emit) async {
    //     _entrysListListener.pause();

    //     _entriesRepository.addEntryToHive(event.entry!);
    //     final entriesList = await _entriesRepository.getEntriesFromHive();

    //     emit(EntrysListLoaded(userVisits: entriesList));

    //     print('Bloc: Entrys data was updated from HIVE ${entriesList}');
    //     _entrysListListener.resume();
    //   },
    //   transformer: sequential(),
    // );

    on<EntriesListChangedEvent>(
      (event, emit) {
        if (event.entriesList != null) {
          final entriesList = event.entriesList;

          // _entriesRepository.addEntriesToHive(entriesList);

          emit(EntriesListLoadedState(userVisits: entriesList));

          log('Bloc: Entrys data was updated ${event.entriesList}');
        } else {
          emit(EntriesListLoadingState());
        }
      },
      transformer: sequential(),
    );

    // on<LoadLastEntrys>((event, emit) async {
    //   emit(LastEntrysListLoading());

    //   try {
    //     final visits = firestoreService.getVisits();
    //     emit(LastEntrysListLoaded(userVisits: visits));
    //     print('loaded');
    //   } catch (e) {
    //     emit(LastEntrysListFailure(exception: 'Failure'));
    //   }
    // });

    on<DeleteEntryEvent>(
      (event, emit) async {
        emit(EntriesListLoadingState());

        _entriesRepository.deleteEntry(event.entryRef);

        // try {
        //   final visits = await firestoreService.getVisits();
        //   emit(LastEntrysListLoaded(userVisits: visits));
        // } catch (e) {
        //   emit(LastEntrysListFailure(exception: 'Failure'));
        // }
      },
    );
  }
  @override
  Future<void> close() {
    _entrysListListener.cancel();
    log('Entrys subscription was cancelled');
    return super.close();
  }
}
