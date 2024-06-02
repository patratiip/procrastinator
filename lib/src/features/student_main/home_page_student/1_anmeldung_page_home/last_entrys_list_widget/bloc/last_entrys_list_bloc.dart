import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../data/last_entry_model.dart';
import '../domain/entry_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'last_entrys_list_event.dart';
part 'last_entrys_list_state.dart';

class LastEntrysListBloc extends Bloc<EntrysListEvent, EntrysListState> {
  final EntryFirestoreRepository _entrysRepository;
  late final StreamSubscription<List<Entry>?> _entrysListListener;

  LastEntrysListBloc({required entrysRepository})
      : _entrysRepository = entrysRepository,
        super(EntrysListInitial()) {
    //Subscription
    _entrysListListener = _entrysRepository.getVisits().listen(
      (entrysList) {
        add(EntrysListChangedEvent(entrysList));
      },
      cancelOnError: false,
    );

    on<EntrysListChangedEvent>(
      (event, emit) {
        if (event.entriesList != null) {
          final entriesList = event.entriesList!;
          _entrysRepository.addEntrysToHive(entriesList);

          emit(EntrysListLoaded(userVisits: entriesList));

          print('Bloc: Entrys data was updated ${event.entriesList}');
        } else {
          emit(EntrysListLoading());
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

    on<DeleteEntry>(
      (event, emit) async {
        emit(EntrysListLoading());

        entrysRepository.deleteVisit(event.entryRef);

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
