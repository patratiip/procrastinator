import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';

part 'lection_plan_event.dart';
part 'lection_plan_state.dart';

class LectionPlanBloc extends Bloc<LectionPlanEvent, LectionPlanState> {
  final ILectionRepository _lectionsRepository;

  late final StreamSubscription<List<Lection>?> _lectionListListener;

  LectionPlanBloc({required ILectionRepository lectionsRepository})
      : _lectionsRepository = lectionsRepository,
        super(LectionPlanInitialState()) {
    on<LectionPlanEvent>(
      (event, emit) => switch (event) {
        final LectionsListChangedEvent e => _lectionsListChangedEvent(e, emit),
      },
      transformer: sequential(),
    );

    /// Subscription
    _lectionListListener = _lectionsRepository.getLections().listen(
      (lectionsList) {
        add(LectionsListChangedEvent(lectionsList));
      },
      cancelOnError: false,
    );
  }

  Future<void> _lectionsListChangedEvent(
      LectionsListChangedEvent event, Emitter<LectionPlanState> emit) async {
    if (event.lectionsList != null) {
      final lectionsList = event.lectionsList!;

      emit(LectionsListLoadedState(lectionsList: lectionsList));
    } else {
      emit(LectionsListLoadingState());
    }
  }

  @override
  Future<void> close() {
    _lectionListListener.cancel();
    log('Lections subscription was cancelled');
    return super.close();
  }
}