import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/domain/entry_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

part 'loosed_entrys_event.dart';
part 'loosed_entrys_state.dart';

class LoosedEntrysBloc extends Bloc<LoosedEntrysEvent, LoosedEntrysState> {
  final LectionFirestoreRepository _lectionsRepository;
  final EntryFirestoreRepository _entrysRepository;
  final ComparingLectionsAndEntrysRepository _comaringRepository;
  LoosedEntrysBloc(this._lectionsRepository, this._entrysRepository,
      this._comaringRepository)
      : super(LoosedEntrysInitial()) {
    on<ComairingLectionsAndVisits>((event, emit) async {
      try {
        if (state is! ComaredEntrysState) {
          emit(CompairingEntrysState());
        }

        final entrys = await _entrysRepository.getVisits().first;
        final lections = await _lectionsRepository.getLections().first;
        final filteredLections =
            lections.where((x) => x.date!.isBefore(DateTime.now())).toList();
        final loosedLections =
            await _comaringRepository.comareLectionsAndEntrys(
                kursplanQuery: filteredLections, visitsQuery: entrys);

        emit(ComaredEntrysState(loosedLectionsList: loosedLections));
        print('compared');
      } catch (e) {
        CompairingEntrysFailure(exception: e);
      } finally {
        event.completer?.complete();
      }
    });
  }
}
