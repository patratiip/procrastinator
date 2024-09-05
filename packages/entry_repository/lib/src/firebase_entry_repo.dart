import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:entry_repository/entry_repository.dart';

class FirebaseEntryRepository implements EntryRepositoty {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
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
                  Entry.fromEntity(EntryEntity.fromFirestore(entry.data())))
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
          .set(entry.toEntity().toFirestore());
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
