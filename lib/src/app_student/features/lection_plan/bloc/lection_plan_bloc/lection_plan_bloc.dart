import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/data/lection_repository.dart';

part 'lection_plan_event.dart';
part 'lection_plan_state.dart';

class LectionPlanBloc extends Bloc<LectionPlanEvent, LectionPlanState> {
  final ILectionRepository _lectionsRepository;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  LectionPlanBloc({required ILectionRepository lectionsRepository})
      : _lectionsRepository = lectionsRepository,
        super(const _IdleLectionPlanState(lectionsList: [])) {
    on<LectionPlanEvent>(
      (event, emit) => switch (event) {
        final _LectionsListChangedEvent e => _lectionsListChangedEvent(e, emit),
      },
      transformer: sequential(),
    );

    /// Lections plan subscription
    _lectionListListener = _lectionsRepository.lectionsStream().listen(
      (lectionsList) {
        if (lectionsList.isNotEmpty) {
          add(_LectionsListChangedEvent(lectionsList: lectionsList));
        }
      },
      cancelOnError: false,
    );
  }

  /// Lections collection changed
  Future<void> _lectionsListChangedEvent(
      _LectionsListChangedEvent event, Emitter<LectionPlanState> emit) async {
    try {
      emit(_LoadingLectionPlanState(lectionsList: state.lectionsList));
      emit(_LoadedLectionPlanState(lectionsList: event.lectionsList));
    } on Object catch (e, st) {
      onError(e, st);
      emit(_ErrorLectionPlanState(lectionsList: event.lectionsList, error: e));
    } finally {
      emit(_IdleLectionPlanState(lectionsList: state.lectionsList));
    }
  }

  @override
  Future<void> close() {
    _lectionListListener.cancel();
    log('Lections subscription was cancelled');
    return super.close();
  }
}
