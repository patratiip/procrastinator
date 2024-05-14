import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../data/last_entry_model.dart';
import '../domain/entry_repository.dart';

part 'last_entrys_list_event.dart';
part 'last_entrys_list_state.dart';

class LastEntrysListBloc
    extends Bloc<LastEntrysListEvent, LastEntrysListState> {
  final EntryFirestoreRepository _firestoreService;
  LastEntrysListBloc(this._firestoreService) : super(LastEntrysListInitial()) {
    on<LoadLastEntrys>((event, emit) async {
      emit(LastEntrysListLoading());
      try {
        final visits = await _firestoreService.getVisits().first;
        emit(LastEntrysListLoaded(userVisits: visits));
      } catch (e) {
        emit(LastEntrysListFailure(exception: 'Failure'));
      }
    });

    on<DeleteEntry>(
      (event, emit) async {
        emit(LastEntrysListLoading());
        await _firestoreService.deleteVisit(event.entryRef);

        // Future.delayed(const Duration(seconds: 15));
        try {
          final visits = await _firestoreService.getVisits().first;
          emit(LastEntrysListLoaded(userVisits: visits));
        } catch (e) {
          emit(LastEntrysListFailure(exception: 'Failure'));
        }
      },
    );
  }
  // final currentUser = FirebaseAuth.instance.currentUser;
  // final db = FirebaseFirestore.instance;
}
