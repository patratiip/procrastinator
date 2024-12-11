import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry_model.dart';

abstract interface class IEntryRepositoty {
  Stream<List<Entry>?> getVisits();
  Future<void> addEntry(Entry entry);
  Future<void> deleteEntry(String visitId);
}

class FirebaseEntryRepository implements IEntryRepositoty {
  final String currentUser;

  FirebaseEntryRepository({required this.currentUser});

  late final _userVisitsCollection = FirebaseFirestore.instance
      .collection('users_flutter')
      .doc(currentUser)
      .collection('userVisits');

  @override
  Stream<List<Entry>?> getVisits() {
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
