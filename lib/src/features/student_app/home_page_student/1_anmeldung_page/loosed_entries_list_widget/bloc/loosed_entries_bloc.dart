import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/loosed_entries_list_widget/domain/comaring_loosed_entries_repository.dart';

part 'loosed_entries_event.dart';
part 'loosed_entries_state.dart';

class LoosedEntriesBloc extends Bloc<LoosedEntriesEvent, LoosedEntriesState> {
  final ComparingLectionsAndEntriesService _comaringService;
  //Entries Repo
  final EntryRepositoty _entriesRepository;
  late final StreamSubscription<List<Entry>?> _entrysListListener;
  //Lessons Repo
  final LectionRepository _lectionsRepository;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  LoosedEntriesBloc(
      {required EntryRepositoty entriesRepository,
      required LectionRepository lectionsRepository,
      required comaringService})
      : _comaringService = comaringService,
        _entriesRepository = entriesRepository,
        _lectionsRepository = lectionsRepository,
        super(LoosedEntrysInitial()) {
    //

    List<Entry> entriesListFromStream = [];
    List<Lection> lectionsListFromStream = [];

    //Subscription - Entries List from Repo
    _entrysListListener = entriesRepository.getVisits().listen(
      (entriesList) {
        if (entriesList != null && entriesList.isNotEmpty) {
          entriesListFromStream = entriesList;
        }
        // print('Loosed Bloc Stram (Enrty): e: $entriesList, _l: $_lectionsList');
        if (entriesListFromStream.isNotEmpty &&
            lectionsListFromStream.isNotEmpty) {
          add(ComairingLectionsAndVisitsEvent(
            lectionsListFromStream,
            entriesListFromStream,
          ));
        }
      },
      // cancelOnError: false,
    );

    //Subscription - Lessons Bloc
    _lectionListListener = lectionsRepository.getLections().listen(
      (lectionsList) {
        if (lectionsList != null && lectionsList.isNotEmpty) {
          lectionsListFromStream = lectionsList;
        }
        // print( 'Loosed Bloc Stram (Lection): _e: $_entriesList, l: $lectionsList');
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

    on<ComairingLectionsAndVisitsEvent>(
      (event, emit) async {
        if (event.entriesList!.isNotEmpty && event.lectionsList!.isNotEmpty) {
          emit(CompairingEntrysState());

          final loosedLections = _comaringService.comareLectionsAndEntrysState(
            event.lectionsList,
            event.entriesList,
          );

          if (loosedLections.isNotEmpty) {
            emit(ComaredEntrysState(loosedLectionsList: loosedLections));
            // print('Bloc: compared $loosedLections');
            // } catch (e) {
            //   CompairingEntrysFailure(exception: e);
            // }
          } else {
            emit(CopmaredAllClear());
          }
        }
      },
      transformer: sequential(),
    );
  }
  @override
  Future<void> close() {
    _entrysListListener.cancel();
    _lectionListListener.cancel();
    print('Loosed lections subscription was cancelled');
    return super.close();
  }
}
