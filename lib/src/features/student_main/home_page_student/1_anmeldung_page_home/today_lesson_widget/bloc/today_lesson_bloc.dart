import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lection_repository/lection_repository.dart';

part 'today_lesson_event.dart';
part 'today_lesson_state.dart';

class TodayLessonBloc extends Bloc<TodayLessonEvent, TodayLessonState> {
  final LectionRepository _lectionsRepository;
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
