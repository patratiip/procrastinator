import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

part 'kursplan_event.dart';
part 'kursplan_state.dart';

class KursplanBloc extends Bloc<KursplanEvent, KursplanState> {
  final LectionFirestoreRepository _lectionsRepository;
  KursplanBloc(this._lectionsRepository) : super(KursplanInitial()) {
    on<LoadLections>((event, emit) async {
      emit(LectionsListLoading());
      try {
        final lections = await _lectionsRepository.getLections().first;
        final filteredLections =
            lections.where((x) => x.date!.isAfter(DateTime.now())).toList();
        emit(LectionsListLoaded(lectionsList: filteredLections));
      } catch (e) {
        emit(LectionsListFailure(exception: 'Failure'));
      }
    });
  }
}
