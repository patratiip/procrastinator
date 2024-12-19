import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/model/forgotten_request.dart';
import 'package:uuid/uuid.dart';

part 'forgotten_entry_state.dart';

class ForgottenEntryCubit extends Cubit<ForgottenEntryState> {
  final IEntryAddingRepository _entryAddingRepository;

  ForgottenEntryCubit({
    required IEntryAddingRepository entryAddingRepository,
    required ForgottenEntryState initialState,
  })  : _entryAddingRepository = entryAddingRepository,
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
      _entryAddingRepository.addForgottenEntryRequest(request);

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
