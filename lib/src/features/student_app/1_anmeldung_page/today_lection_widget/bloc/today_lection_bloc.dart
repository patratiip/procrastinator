import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';

part 'today_lection_event.dart';
part 'today_lection_state.dart';

class TodayLectionBloc extends Bloc<TodayLectionEvent, TodayLectionState> {
  final LectionRepository _lectionsRepository;
  TodayLectionBloc({required LectionRepository lectionsRepository})
      : _lectionsRepository = lectionsRepository,
        super(TodayLessonInitial()) {
    on<LoadTodayLection>((event, emit) async {
      emit(TodayLectionLoading());

      try {
        final todayLection = await _lectionsRepository.getTodayLection();
        if (todayLection != null) {
          emit(TodayLectionLoaded(todayLection: todayLection));
        } else {
          emit(TodayLectionEmpty());
        }

        // print('TodayLesson BLOC: ');
      } catch (e) {
        emit(const TodayLectionFailure(exception: 'Failure'));
      }
    });
  }
}