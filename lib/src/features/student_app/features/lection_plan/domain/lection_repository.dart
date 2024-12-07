import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/core/constant/firebase_collections_constants.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/domain/lection.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/data/lection_entity.dart';

abstract class ILectionRepository {
  Stream<List<Lection>?> getLections();
  Future<Lection?> getTodayLection();
}

class FirebaseLectionRepository implements ILectionRepository {
  final _lectionsCollectionRef = FirebaseFirestore.instance
      .collection(FirebaseCollectionsConstants.lections);

  final _now = DateTime.now();

  @override
  Stream<List<Lection>?> getLections() {
    try {
      return _lectionsCollectionRef
          .orderBy('date', descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((e) =>
                  Lection.fromEntity(LectionEntity.fromFirestore(e.data())))
              .toList())
          .asBroadcastStream();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Lection?> getTodayLection() async {
    final Timestamp today =
        Timestamp.fromDate(DateTime(_now.year, _now.month, _now.day));
    try {
      final todayQuery =
          await _lectionsCollectionRef.where('date', isEqualTo: today).get();

      // Return null if there is no lecture for today
      if (todayQuery.docs.isEmpty) return null;

      return Lection.fromEntity(
          LectionEntity.fromFirestore(todayQuery.docs.first.data()));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
