import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry_model.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection_model.dart';
import 'package:procrastinator/src/core/utils/little_helpers.dart';

/// Interface for [LoosedEntriesFirebaseDataProviderImpl]
///
/// The data provider that handles entries and lections to compare and adding entry
abstract interface class ILoosedEntriesFirebaseDataProvider {
  /// Getting lections stream
  Stream<List<LectionModel>> lectionsStream();

  /// Getting entries stream
  Stream<List<EntryModel>> entriesStream();
}

/// {@template loosed_entries_firebase_data_provider}
/// Implementation of [ILoosedEntriesFirebaseDataProvider].
/// {@endtemplate}

final class LoosedEntriesFirebaseDataProviderImpl
    implements ILoosedEntriesFirebaseDataProvider {
  final CollectionReference<Map<String, dynamic>> _lectionsCollectionRef;
  final CollectionReference<Map<String, dynamic>> _entriesCollectionRef;

  /// {@macro loosed_entries_firebase_data_provider}
  LoosedEntriesFirebaseDataProviderImpl({
    required CollectionReference<Map<String, dynamic>> lectionsCollectionRef,
    required CollectionReference<Map<String, dynamic>> entriesCollectionRef,
  })  : _lectionsCollectionRef = lectionsCollectionRef,
        _entriesCollectionRef = entriesCollectionRef;

  @override
  Stream<List<LectionModel>> lectionsStream() {
    final today = Timestamp.fromDate(dateNormalizer(DateTime.now()));

    try {
      final lections = _lectionsCollectionRef
          .where('date', isLessThanOrEqualTo: today)
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
}
