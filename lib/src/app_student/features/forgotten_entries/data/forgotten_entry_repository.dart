import 'package:procrastinator/src/app_student/features/forgotten_entries/data/firebase_forgotten_entry_data_provider.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/model/forgotten_request.dart';

/// Interface for [ForgottenEntryRepositoryImpl]
///
/// The repository that working with request
abstract interface class IForgottenEntryRepository {
  /// Getting requests stream
  Stream<List<ForgottenRequestStudent>> requestsStream();

  /// Adding request to requests collection
  Future<void> addRequest(ForgottenRequestStudent request);

  /// Deleting request from requests collection
  Future<void> deleteRequest(String requestId);
}

/// {@template forgotten_entry_repository_impl}
/// Implementation of [IForgottenEntryRepository].
/// {@endtemplate}

final class ForgottenEntryRepositoryImpl implements IForgottenEntryRepository {
  final IForgottenEntryDataProvider _requestDataProvider;

  /// {@macro forgotten_entry_repository_impl}
  ForgottenEntryRepositoryImpl({
    required IForgottenEntryDataProvider requestDataProvider,
  }) : _requestDataProvider = requestDataProvider;

  @override
  Stream<List<ForgottenRequestStudent>> requestsStream() {
    /// Convert [ForgottenRequestStudentModel]'s stream to an [ForgottenRequestStudent]'s stream
    return _requestDataProvider
        .requestsStream()
        .map((entities) => entities
            .map((entity) => ForgottenRequestStudent.fromModel(entity))
            .toList())
        .asBroadcastStream();
  }

  @override
  Future<void> addRequest(ForgottenRequestStudent request) async {
    await _requestDataProvider.addRequest(request);
  }

  @override
  Future<void> deleteRequest(String requestId) async {
    await _requestDataProvider.deleteRequest(requestId);
  }
}
