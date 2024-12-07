// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/data/lection_entity.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/domain/lection.dart';

/// Interface for [LectionFirebaseDataProviderImpl]
///
/// The repository that handles lections
abstract interface class ILectionDataProvider {
  Stream<List<Lection>> lectionsStream();
  Future<Lection?> getTodayLection();
}

/// {@template i_lection_data_provider.class}
/// Implementation of [ILectionDataProvider].
/// {@endtemplate}
final class LectionFirebaseDataProviderImpl implements ILectionDataProvider {
  final CollectionReference<Map<String, dynamic>> _collectionRef;

  ///{@macro i_lection_data_provider}
  LectionFirebaseDataProviderImpl({
    required CollectionReference<Map<String, dynamic>> collectionRef,
  }) : _collectionRef = collectionRef;

  @override
  Stream<List<Lection>> lectionsStream() {
    try {
      final lections = _collectionRef
          .orderBy('date', descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((e) =>
                  Lection.fromEntity(LectionEntity.fromFirestore(e.data())))
              .toList())
          .asBroadcastStream();

      return lections;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Lection?> getTodayLection() async {
    final now = DateTime.now();
    final Timestamp today =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    try {
      final todayQueryResult =
          await _collectionRef.where('date', isEqualTo: today).get();

      // Return null if there is no lections for today
      if (todayQueryResult.docs.isEmpty) return null;

      return Lection.fromEntity(
          LectionEntity.fromFirestore(todayQueryResult.docs.first.data()));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
