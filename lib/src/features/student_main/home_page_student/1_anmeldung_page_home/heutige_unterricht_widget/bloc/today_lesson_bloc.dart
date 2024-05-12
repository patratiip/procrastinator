import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/data/today_lection_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/domain/today_lection_repository.dart';

part 'today_lesson_event.dart';
part 'today_lesson_state.dart';

class TodayLessonBloc extends Bloc<TodayLessonEvent, TodayLessonState> {
  final TodayLectionFirestoreRepository _lectionsRepository;
  TodayLessonBloc(this._lectionsRepository) : super(TodayLessonInitial()) {
    on<LoadTodayLection>((event, emit) async {
      emit(TodayLectionLoading());
      Future.delayed(const Duration(seconds: 15));
      try {
        final _todayLection = await _lectionsRepository.getTodayLection().first;
        emit(TodayLectionLoaded(lectionsList: _todayLection));
      } catch (e) {
        emit(TodayLectionFailure(exception: 'Failure'));
      }
    });
  }
}
