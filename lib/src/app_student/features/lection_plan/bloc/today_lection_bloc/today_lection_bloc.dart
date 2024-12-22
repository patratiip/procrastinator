import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/data/lection_repository.dart';

part 'today_lection_event.dart';
part 'today_lection_state.dart';

class TodayLectionBloc extends Bloc<TodayLectionEvent, TodayLectionState> {
  final ILectionRepository _lectionsRepository;
  TodayLectionBloc({required ILectionRepository lectionsRepository})
      : _lectionsRepository = lectionsRepository,
        super(const _IdleTodayLectionState()) {
    on<TodayLectionEvent>(
      (event, emit) => switch (event) {
        final _LoadLectionEvent e => _loadTodayLection(e, emit)
      },
      transformer: sequential(),
    );
  }

  /// Loading Lection on that day if exist
  Future<void> _loadTodayLection(
      _LoadLectionEvent event, Emitter<TodayLectionState> emit) async {
    try {
      emit(_LoadingTodayLectionState(lection: state.lection));
      // TODO: Check no lection found situation. Sometimes exception coming
      final todayLection = await _lectionsRepository.getTodayLection();
      emit(_LoadedTodayLectionState(lection: todayLection));
    } on Object catch (e, st) {
      onError(e, st);
      emit(_ErrorTodayLectionState(error: e, lection: state.lection));
    } finally {
      emit(_IdleTodayLectionState(lection: state.lection));
    }
  }
}
