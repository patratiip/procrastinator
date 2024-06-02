import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

part 'kursplan_event.dart';
part 'kursplan_state.dart';

class KursplanBloc extends Bloc<KursplanEvent, KursplanState> {
  final LectionFirestoreRepository _lectionsRepository;
  late final StreamSubscription<List<Lection>?> _lectionListListener;
  KursplanBloc({required lectionsRepository})
      : _lectionsRepository = lectionsRepository,
        super(KursplanInitialState()) {
    //Subscription
    _lectionListListener = _lectionsRepository.getLections().listen(
      (lectionsList) {
        add(LectionsListChangedEvent(lectionsList));
      },
      cancelOnError: false,
    );

    on<LectionsListChangedEvent>(
      (event, emit) async {
        if (event.lectionsList != null) {
          final lectionsList = event.lectionsList!;

          final filteredLections = lectionsList
              .where((x) => x.date!.isAfter(DateTime.now()))
              .toList();

          _lectionsRepository.addLectionsToHive(lectionsList);

          emit(LectionsListLoadedState(lectionsList: filteredLections));

          print('Bloc: Lections data was updated ${event.lectionsList}');
        } else {
          emit(LectionsListLoadingState());
        }
      },
      transformer: sequential(),
    );

    @override
    Future<void> close() {
      _lectionListListener.cancel();
      print('Entrys subscription was cancelled');
      return super.close();
    }
  }
}
