import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry_model.dart';

/// Interface for [EntryRepositoryImpl]
///
/// The repository that handles entries
abstract interface class IEntryRepositoty {
  /// Getting entries stream
  Stream<List<Entry>> entriesStream();

  /// Adding entry to entries collection
  Future<void> addEntry(Entry entry);

  /// Deleting entry from entries collection
  Future<void> deleteEntry(String visitId);
}

/// {@template entry_repository_impl}
/// Implementation of [IEntryRepositoty].
/// {@endtemplate}

final class EntryRepositoryImpl implements IEntryRepositoty {
  final String currentUser;

  /// {@macro entry_repository_impl}
  EntryRepositoryImpl({required this.currentUser});

  late final _userVisitsCollection = FirebaseFirestore.instance
      .collection('users_flutter')
      .doc(currentUser)
      .collection('userVisits');

  @override
  Stream<List<Entry>> entriesStream() {
    try {
      return _userVisitsCollection
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((entry) =>
                  Entry.fromModel(EntryModel.fromFirestore(entry.data())))
              .toList())
          .asBroadcastStream();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addEntry(Entry entry) async {
    try {
      await _userVisitsCollection
          .doc(entry.visitID)
          .set(entry.toModel().toFirestore());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteEntry(String visitId) async {
    try {
      await _userVisitsCollection.doc(visitId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
