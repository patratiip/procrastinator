import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry_model.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection_model.dart';

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
}

/// {@template entry_adding_firebase_data_provider}
/// Implementation of [IEntryAddingFirebaseDataProvider].
/// {@endtemplate}

final class EntryAddingFirebaseDataProviderImpl
    implements IEntryAddingFirebaseDataProvider {
  final CollectionReference<Map<String, dynamic>> _lectionsCollectionRef;
  final CollectionReference<Map<String, dynamic>> _entriesCollectionRef;

  /// {@macro entry_adding_firebase_data_provider}
  EntryAddingFirebaseDataProviderImpl({
    required CollectionReference<Map<String, dynamic>> lectionsCollectionRef,
    required CollectionReference<Map<String, dynamic>> entriesCollectionRef,
  })  : _lectionsCollectionRef = lectionsCollectionRef,
        _entriesCollectionRef = entriesCollectionRef;

  @override
  Stream<List<LectionModel>> lectionsStream() {
    try {
      final lections = _lectionsCollectionRef
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
}
