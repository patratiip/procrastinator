import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/domain/lection.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/domain/lection_repository.dart';

part 'today_lection_event.dart';
part 'today_lection_state.dart';

class TodayLectionBloc extends Bloc<TodayLectionEvent, TodayLectionState> {
  final ILectionRepository _lectionsRepository;
  TodayLectionBloc({required ILectionRepository lectionsRepository})
      : _lectionsRepository = lectionsRepository,
        super(TodayLessonInitial()) {
    on<TodayLectionEvent>(
      (event, emit) => switch (event) {
        final LoadTodayLection e => _loadTodayLection(e, emit)
      },
      transformer: sequential(),
    );
  }

  /// Loading Lection on that day if exist
  Future<void> _loadTodayLection(
      LoadTodayLection event, Emitter<TodayLectionState> emit) async {
    try {
      emit(TodayLectionLoading());
      // TODO: Check no lection found situation. Sometimes exception coming
      final todayLection = await _lectionsRepository.getTodayLection();
      if (todayLection != null) {
        emit(TodayLectionLoaded(todayLection: todayLection));
      } else {
        emit(TodayLectionEmpty());
      }
    } on Object catch (e, st) {
      onError(e, st);
      emit(TodayLectionFailure(exception: e));
    }
  }
}
