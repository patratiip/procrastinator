import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'last_entrys_list_event.dart';
part 'last_entrys_list_state.dart';

class LastEntrysListBloc extends Bloc<EntrysListEvent, EntrysListState> {
  final EntryRepositoty _entriesRepository;
  late final StreamSubscription<List<Entry>?> _entrysListListener;

  LastEntrysListBloc({required entrysRepository})
      : _entriesRepository = entrysRepository,
        super(EntrysListInitial()) {
    //Subscription
    _entrysListListener = _entriesRepository.getVisits().listen(
      (entrysList) {
        add(EntrysListChangedEvent(entrysList));
        // print('Entrys Stream Listener Bloc: $entrysList');
      },
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

    on<EntrysListChangedEvent>(
      (event, emit) {
        if (event.entriesList != null) {
          final entriesList = event.entriesList;

          // _entriesRepository.addEntriesToHive(entriesList);

          emit(EntrysListLoadedState(userVisits: entriesList));

          print('Bloc: Entrys data was updated ${event.entriesList}');
        } else {
          emit(EntrysListLoadingState());
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
        emit(EntrysListLoadingState());

        _entriesRepository.deleteEntry(event.entryRef);

        // try {
        //   final visits = await firestoreService.getVisits();
        //   emit(LastEntrysListLoaded(userVisits: visits));
        // } catch (e) {
        //   emit(LastEntrysListFailure(exception: 'Failure'));
        // }
      },
    );

    @override
    Future<void> close() {
      _entrysListListener.cancel();
      print('Entrys subscription was cancelled');
      return super.close();
    }
  }
}
