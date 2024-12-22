import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/data/forgotten_entry_repository.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/model/forgotten_request.dart';
import 'package:uuid/uuid.dart';

part 'forgotten_entry_state.dart';

class ForgottenEntryCubit extends Cubit<ForgottenEntryState> {
  final IForgottenEntryRepository _forgottenEntryRepository;

  ForgottenEntryCubit({
    required IForgottenEntryRepository forgottenEntryRepository,
    required ForgottenEntryState initialState,
  })  : _forgottenEntryRepository = forgottenEntryRepository,
        super(initialState);

  /// Reason changed
  void reasonChanged(String value) {
    emit(state.copyWith(
        errorMessage: null,
        reasonIsValid: null,
        status: ForgottenEntryStateStatus.idle));
    emit(state.copyWith(reason: value));
  }

  /// User want to send request
  Future<void> sendForgottenEntryRequest() async {
    emit(state.copyWith(status: ForgottenEntryStateStatus.inProgress));

    // TODO: Add a full state verification
    if (state.reason.isEmpty) {
      emit(state.copyWith(
          errorMessage: 'Reason text field must be filled',
          reasonIsValid: false,
          status: ForgottenEntryStateStatus.error));
      return;
    }

    // Creating request entity
    final request = ForgottenRequestStudent(
      requestId: const Uuid().v4(),
      createdAt: DateTime.now(),
      date: state.date,
      userId: state.userId,
      reason: state.reason,
      approved: false,
    );

    try {
      _forgottenEntryRepository.addRequest(request);

      emit(state.copyWith(status: ForgottenEntryStateStatus.success));
    } on Object catch (error, stackTrace) {
      emit(state.copyWith(status: ForgottenEntryStateStatus.error));
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  @override
  Future<void> close() {
    log('Forgotten entry cubit closed');
    return super.close();
  }
}
