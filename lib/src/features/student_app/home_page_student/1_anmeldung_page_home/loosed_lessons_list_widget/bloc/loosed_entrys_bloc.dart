import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';

part 'loosed_entrys_event.dart';
part 'loosed_entrys_state.dart';

class LoosedEntrysBloc extends Bloc<LoosedEntrysEvent, LoosedEntrysState> {
  final ComparingLectionsAndEntriesService _comaringService;
  //Entries Bloc
  final EntrysListBloc _entrysListBloc;
  late final StreamSubscription _entriesBlocStreamSubscription;
  //Lessons Bloc
  final KursplanBloc _kursplanBloc;
  late final StreamSubscription _kursplanBlocStreamSubscription;

  LoosedEntrysBloc(this._entrysListBloc, this._kursplanBloc,
      {required comaringRepository})
      : _comaringService = comaringRepository,
        super(LoosedEntrysInitial()) {
    //

    //Subscription - Entries Bloc
    _entriesBlocStreamSubscription = _entrysListBloc.stream.listen(
      (state) {
        final kursplanBlocState = _kursplanBloc.state;
        if (state is EntrysListLoadedState &&
            kursplanBlocState is LectionsListLoadedState) {
          final enriesListFromState = state.userVisits;
          final lectionsListFromState = kursplanBlocState.lectionsList;
          add(ComairingLectionsAndVisitsEvent(
            lectionsListFromState,
            enriesListFromState,
          ));
        }
      },
      cancelOnError: false,
    );

    //Subscription - Lessons Bloc
    _kursplanBlocStreamSubscription = _kursplanBloc.stream.listen(
      (state) {
        final entriesBlocState = _entrysListBloc.state;
        if (state is LectionsListLoadedState &&
            entriesBlocState is EntrysListLoadedState) {
          final lectionsListFromState = state.lectionsList;
          final enriesListFromState = entriesBlocState.userVisits;
          add(ComairingLectionsAndVisitsEvent(
            lectionsListFromState,
            enriesListFromState,
          ));
        }
      },
      cancelOnError: false,
    );

    on<ComairingLectionsAndVisitsEvent>(
      (event, emit) async {
        if (event.entriesList!.isNotEmpty && event.lectionsList!.isNotEmpty) {
          emit(CompairingEntrysState());

          final loosedLections =
              _comaringService.comareLectionsAndEntrysState(
            event.lectionsList,
            event.entriesList,
          );

          if (loosedLections.isNotEmpty) {
            emit(ComaredEntrysState(loosedLectionsList: loosedLections));
            print('Bloc: compared $loosedLections');
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

    @override
    Future<void> close() {
      _entriesBlocStreamSubscription.cancel();
      _kursplanBlocStreamSubscription.cancel();
      print('Entrys subscription was cancelled');
      return super.close();
    }
  }
}
