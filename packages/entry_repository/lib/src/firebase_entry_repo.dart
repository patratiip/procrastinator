import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:entry_repository/entry_repository.dart';

final currentUser = FirebaseAuth.instance.currentUser!.uid;

class FirebaseEntryRepository implements EntryRepositoty {
  final userVisitsCollection = FirebaseFirestore.instance
      .collection('users_flutter')
      .doc(currentUser)
      .collection('userVisits');

  @override
  Stream<List<Entry>?> getVisits() {
    try {
      return userVisitsCollection
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((e) => Entry.fromEntity(EntryEntity.fromFirestore(e.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addEntry(Entry entry) async {
    try {
      await userVisitsCollection
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
      await userVisitsCollection.doc(visitId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
