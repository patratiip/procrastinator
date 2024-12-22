import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/data/forgotten_entry_repository.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/model/forgotten_request.dart';

part 'forgotten_entries_event.dart';
part 'forgotten_entries_state.dart';

class ForgottenEntriesBloc
    extends Bloc<ForgottenEntriesEvent, ForgottenEntriesState> {
  final IForgottenEntryRepository _forgottenEntriesRepository;
  late final StreamSubscription<List<ForgottenRequestStudent>>
      _forgottenEntriesListListener;

  ForgottenEntriesBloc(
      {required IForgottenEntryRepository forgottenEntriesRepository})
      : _forgottenEntriesRepository = forgottenEntriesRepository,
        super(const _IdleForgottenEntriesListState(requestsList: [])) {
    on<ForgottenEntriesEvent>(
      (event, emit) => switch (event) {
        final _ForgottenEntriesListEventChanged e =>
          _forgottenEntriesListEventChanged(e, emit),
        final _ForgottenEntriesEventDelete e =>
          _forgottenEntriesEventDelete(e, emit)
      },
      transformer: sequential(),
    );

    // User entries collection subscription
    _forgottenEntriesListListener =
        _forgottenEntriesRepository.requestsStream().listen(
      (requestsList) {
        // if (requestsList.isNotEmpty) {

        add(_ForgottenEntriesListEventChanged(
            forgottenEntriesList: requestsList));
        // }
      },
      cancelOnError: false,
    );
  }

  /// User forgotten entry request list changed
  Future<void> _forgottenEntriesListEventChanged(
      _ForgottenEntriesListEventChanged event,
      Emitter<ForgottenEntriesState> emit) async {
    try {
      emit(_LoadingForgottenEntriesListState(requestsList: state.requestsList));
      emit(_LoadedForgottenEntriesListState(
          requestsList: event.forgottenEntriesList));
    } on Object catch (e, st) {
      onError(e, st);
      emit(_ErrorForgottenEntriesListState(
          requestsList: event.forgottenEntriesList, error: e));
    } finally {
      emit(_IdleForgottenEntriesListState(requestsList: state.requestsList));
    }
  }

  /// Deleting forgotten entry request
  Future<void> _forgottenEntriesEventDelete(_ForgottenEntriesEventDelete event,
      Emitter<ForgottenEntriesState> emit) async {
    try {
      emit(_LoadingForgottenEntriesListState(requestsList: state.requestsList));
      _forgottenEntriesRepository.deleteRequest(event.requestRef);
    } on Object catch (e, st) {
      onError(e, st);
      emit(_ErrorForgottenEntriesListState(
          requestRef: event.requestRef,
          requestsList: state.requestsList,
          error: e));
    }
  }

  @override
  Future<void> close() {
    _forgottenEntriesListListener.cancel();
    log('Forgotten entries requests collection subscription was cancelled');
    return super.close();
  }
}
