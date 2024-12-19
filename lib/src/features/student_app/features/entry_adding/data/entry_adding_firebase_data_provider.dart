import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry_model.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/model/forgotten_request.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection_model.dart';

/// Interface for [EntryAddingFirebaseDataProviderImpl]
///
/// The data provider that handles entries and lections to compare and adding entry
abstract interface class IEntryAddingFirebaseDataProvider {
  /// Getting lections stream
  Stream<List<LectionModel>> lectionsStream();

  /// Getting entries stream
  Stream<List<EntryModel>> entriesStream();

  /// Adding entry to entries collection
  Future<void> addEntry(Entry entry);

  /// Adding entry to entries collection
  Future<void> addForgottenEntryRequest(ForgottenRequestStudent request);
}

/// {@template entry_adding_firebase_data_provider}
/// Implementation of [IEntryAddingFirebaseDataProvider].
/// {@endtemplate}

final class EntryAddingFirebaseDataProviderImpl
    implements IEntryAddingFirebaseDataProvider {
  final CollectionReference<Map<String, dynamic>> _lectionsCollectionRef;
  final CollectionReference<Map<String, dynamic>> _entriesCollectionRef;
  final CollectionReference<Map<String, dynamic>>
      _forgottenEntriesCollectionRef;

  // TODO: Add method to write [ForgottenRequestStudent.requestId] in user doc
  final CollectionReference<Map<String, dynamic>> _userCollectionRef;

  /// {@macro entry_adding_firebase_data_provider}
  EntryAddingFirebaseDataProviderImpl({
    required CollectionReference<Map<String, dynamic>> lectionsCollectionRef,
    required CollectionReference<Map<String, dynamic>> entriesCollectionRef,
    required CollectionReference<Map<String, dynamic>>
        forgottenEntriesCollectionRef,
    required CollectionReference<Map<String, dynamic>> userCollectionRef,
  })  : _lectionsCollectionRef = lectionsCollectionRef,
        _entriesCollectionRef = entriesCollectionRef,
        _forgottenEntriesCollectionRef = forgottenEntriesCollectionRef,
        _userCollectionRef = userCollectionRef;

  @override
  Stream<List<LectionModel>> lectionsStream() {
    //TODO: When the feature wold be separated
    //FROM OTHER FEATURES (foe example Calendar,
    // because this repo handles there lections list)
    //, uncommet things below
    // final now = DateTime.now();
    // final Timestamp today =
    //     Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    try {
      final lections = _lectionsCollectionRef
          // .where('date', isGreaterThan: today)
          .orderBy('date', descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => LectionModel.fromFirestore(doc.data()))
              .toList());

      return lections;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<EntryModel>> entriesStream() {
    try {
      final entries = _entriesCollectionRef
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((entry) => EntryModel.fromFirestore(entry.data()))
              .toList());
      return entries;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addEntry(Entry entry) async {
    // Converting Model to Data for Firebase
    final entryData = entry.toModel().toFirestore();

    try {
      await _entriesCollectionRef.doc(entry.visitID).set(entryData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addForgottenEntryRequest(ForgottenRequestStudent request) async {
    // Converting Model to Data for Firebase
    final requestData = request.toModel().toFirestore();

    try {
      await _forgottenEntriesCollectionRef
          .doc(request.requestId)
          .set(requestData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
