import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:procrastinator/src/features/student_app/features/forgotten_entries/model/forgotten_request.dart';
import 'package:procrastinator/src/features/student_app/features/forgotten_entries/model/forgotten_request_model.dart';

/// Interface for [ForgottenEntryFirebaseDataProviderImpl]
///
/// The data provider that handles requests
abstract interface class IForgottenEntryDataProvider {
  /// Getting requests stream
  Stream<List<ForgottenRequestStudentModel>> requestsStream();

  /// Adding request to requests collection
  Future<void> addRequest(ForgottenRequestStudent request);

  /// Deleting request from requests collection
  Future<void> deleteRequest(String visitId);
}

/// {@template forgotten_entry_firebase_data_provider}
/// Implementation of [IForgottenEntryDataProvider].
/// {@endtemplate}ForgottenRequestStudent

final class ForgottenEntryFirebaseDataProviderImpl
    implements IForgottenEntryDataProvider {
  final CollectionReference<Map<String, dynamic>> _collectionRef;
  // TODO: Add method to write [ForgottenRequestStudent.requestId] in user doc
  final CollectionReference<Map<String, dynamic>> _userCollectionRef;
  final String _userId;

  /// {@macro forgotten_entry_firebase_data_provider}
  ForgottenEntryFirebaseDataProviderImpl({
    required CollectionReference<Map<String, dynamic>> collectionRef,
    required CollectionReference<Map<String, dynamic>> userCollectionRef,
    required String userId,
  })  : _collectionRef = collectionRef,
        _userCollectionRef = userCollectionRef,
        _userId = userId;

  @override
  Stream<List<ForgottenRequestStudentModel>> requestsStream() {
    try {
      final requests = _collectionRef
          .where('userId', isEqualTo: _userId)
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((request) =>
                  ForgottenRequestStudentModel.fromFirestore(request.data()))
              .toList());
      return requests;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addRequest(ForgottenRequestStudent request) async {
    // Converting Model to Data for Firebase
    final requestData = request.toModel().toFirestore();

    try {
      await _collectionRef.doc(request.requestId).set(requestData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteRequest(String requestId) async {
    try {
      await _collectionRef.doc(requestId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
