// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection_model.dart';
import 'package:procrastinator/src/core/utils/little_helpers.dart';

/// Interface for [LectionFirebaseDataProviderImpl]
///
/// The data provider that handles lections
abstract interface class ILectionDataProvider {
  Stream<List<LectionModel>> lectionsStream();
  Future<LectionModel?> getTodayLection();
}

/// {@template lection_data_provider}
/// Implementation of [ILectionDataProvider].
/// {@endtemplate}
final class LectionFirebaseDataProviderImpl implements ILectionDataProvider {
  final CollectionReference<Map<String, dynamic>> _collectionRef;

  /// {@macro lection_data_provider}
  const LectionFirebaseDataProviderImpl({
    required CollectionReference<Map<String, dynamic>> collectionRef,
  }) : _collectionRef = collectionRef;

  @override
  Stream<List<LectionModel>> lectionsStream() {
final today = Timestamp.fromDate(dateNormalizer(DateTime.now()));
    try {
      final lections = _collectionRef
          .where('date', isGreaterThan: today)
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
  Future<LectionModel?> getTodayLection() async {
    /// Actual date
    final now = DateTime.now();

    final Timestamp today =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    try {
      final todayQueryResult =
          await _collectionRef.where('date', isEqualTo: today).get();

      // Return null if there is no lections for today
      if (todayQueryResult.docs.isEmpty) return null;

      return LectionModel.fromFirestore(todayQueryResult.docs.first.data());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
