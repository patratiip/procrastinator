import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';

part 'loosed_entrys_event.dart';
part 'loosed_entrys_state.dart';

class LoosedEntrysBloc extends Bloc<LoosedEntrysEvent, LoosedEntrysState> {
  final ComparingLectionsAndEntrysRepository _comaringRepository;
  //
  final LastEntrysListBloc _entrysListBloc;
  late final StreamSubscription _entriesBloctreamSubscription;
  //
  final KursplanBloc _kursplanBloc;
  late final StreamSubscription _kursplanBlocStreamSubscription;

  LoosedEntrysBloc(this._entrysListBloc, this._kursplanBloc,
      {required comaringRepository})
      : _comaringRepository = comaringRepository,
        super(LoosedEntrysInitial()) {
    //


    //Subscription
    _entriesBloctreamSubscription = _entrysListBloc.stream.listen(
      (state) {
        final kursplanBlocState = _kursplanBloc.state;
        if (state is EntrysListLoaded &&
            kursplanBlocState is LectionsListLoadedState) {
          add(ComairingLectionsAndVisitsEvent());
        }
      },
      cancelOnError: false,
    );

    //Subscription
    _kursplanBlocStreamSubscription = _kursplanBloc.stream.listen(
      (state) {
        final entriesBlocState = _entrysListBloc.state;
        if (state is LectionsListLoadedState &&
            entriesBlocState is EntrysListLoaded) {
          add(ComairingLectionsAndVisitsEvent());
        }
      },
      cancelOnError: false,
    );

    on<ComairingLectionsAndVisitsEvent>(
      (event, emit) async {
        emit(CompairingEntrysState());

        // final entries = event.entriesList;
        // final lections = event.lectionsList;
        // final filteredLections = lections!
        //     .where((lection) => lection.date!.isBefore(DateTime.now()))
        //     .toList();

        final loosedLections =
            await  _comaringRepository.comareLectionsAndEntrys();
        
        // await _comaringRepository.comareLectionsAndEntrys();

        // Future.delayed(Duration(seconds: 5), () {
        //   emit(ComaredEntrysState(loosedLectionsList: loosedLections));
        //   print('Bloc: compared $loosedLections');
        // });
        if (loosedLections.isNotEmpty) {
          emit(ComaredEntrysState(loosedLectionsList: loosedLections));
          print('Bloc: compared $loosedLections');
          // } catch (e) {
          //   CompairingEntrysFailure(exception: e);
          // }
        } else {
          emit(LoosedEntrysInitial());
        }

        // finally {
        //   event.completer?.complete();
        // }
      },
      transformer: sequential(),
    );

    @override
    Future<void> close() {
      _entriesBloctreamSubscription.cancel();
      _kursplanBlocStreamSubscription.cancel();
      print('Entrys subscription was cancelled');
      return super.close();
    }
  }
}
