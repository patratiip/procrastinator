import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/today_lesson_widget/data/today_lection_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/today_lesson_widget/domain/today_lection_repository.dart';

part 'today_lesson_event.dart';
part 'today_lesson_state.dart';

class TodayLessonBloc extends Bloc<TodayLessonEvent, TodayLessonState> {
  final TodayLectionFirestoreRepository _lectionsRepository;
  // late final StreamSubscription _todayLectionListener;
  TodayLessonBloc({required lectionsRepository})
      : _lectionsRepository = lectionsRepository,
        super(TodayLessonInitial()) {
    // //Subscription
    // _todayLectionListener = _lectionsRepository.getTodayLection().listen(
    //   (entrysList) {
    //     add(EntrysListChangedEvent(entrysList));
    //     // print('Entrys Stream Listener Bloc: $entrysList');
    //   },
    //   cancelOnError: false,
    // );

    on<LoadTodayLection>((event, emit) async {
      emit(TodayLectionLoading());

      try {
        final todayLection = await _lectionsRepository.getTodayLection();
        if (todayLection != null) {
          emit(TodayLectionLoaded(todayLection: todayLection));
        } else {
          emit(TodayLessonEmpty());
        }

        print('heute loaded');
      } catch (e) {
        emit(TodayLectionFailure(exception: 'Failure'));
      }
    });
  }
}
