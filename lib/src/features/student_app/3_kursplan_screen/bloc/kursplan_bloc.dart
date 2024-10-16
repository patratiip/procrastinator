import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';

part 'kursplan_event.dart';
part 'kursplan_state.dart';

class KursplanBloc extends Bloc<KursplanEvent, KursplanState> {
  final ILectionRepository _lectionsRepository;
  late final StreamSubscription<List<Lection>?> _lectionListListener;
  KursplanBloc({required ILectionRepository lectionsRepository})
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

          // final filteredLections = lectionsList
          //     .where((x) => x.date!.isAfter(DateTime.now()))
          //     .toList();

          // _lectionsRepository.addLectionsToHive(lectionsList);

          emit(LectionsListLoadedState(lectionsList: lectionsList));
        } else {
          emit(LectionsListLoadingState());
        }
      },
      transformer: sequential(),
    );
  }
  @override
  Future<void> close() {
    _lectionListListener.cancel();
    log('Lections subscription was cancelled');
    return super.close();
  }
}
