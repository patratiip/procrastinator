import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';

part 'today_lesson_event.dart';
part 'today_lesson_state.dart';

class TodayLessonBloc extends Bloc<TodayLessonEvent, TodayLessonState> {
  final LectionRepository _lectionsRepository;
  TodayLessonBloc({required lectionsRepository})
      : _lectionsRepository = lectionsRepository,
        super(TodayLessonInitial()) {
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
        emit(const TodayLectionFailure(exception: 'Failure'));
      }
    });
  }
}
