import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry_model.dart';

/// Interface for [EntryFirebaseDataProviderImpl]
///
/// The data provider that handles entries
abstract interface class IEntryDataProvider {
  /// Getting entries stream
  Stream<List<EntryModel>> entriesStream();

  /// Adding entry to entries collection
  Future<void> addEntry(Entry entry);

  /// Deleting entry from entries collection
  Future<void> deleteEntry(String visitId);
}

/// {@template entry_firebase_data_provider}
/// Implementation of [IEntryDataProvider].
/// {@endtemplate}

final class EntryFirebaseDataProviderImpl implements IEntryDataProvider {
  final CollectionReference<Map<String, dynamic>> _collectionRef;

  /// {@macro entry_firebase_data_provider}
  EntryFirebaseDataProviderImpl({
    required CollectionReference<Map<String, dynamic>> collectionRef,
  }) : _collectionRef = collectionRef;

  @override
  Stream<List<EntryModel>> entriesStream() {
    try {
      final entries = _collectionRef
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((entry) => EntryModel.fromFirestore(entry.data()))
              .toList());
      return entries;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addEntry(Entry entry) async {
    // Converting Model to Data for Firebase
    final entryData = entry.toModel().toFirestore();

    try {
      await _collectionRef.doc(entry.visitID).set(entryData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteEntry(String entryId) async {
    try {
      await _collectionRef.doc(entryId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
