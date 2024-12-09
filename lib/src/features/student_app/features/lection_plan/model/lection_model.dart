import 'package:cloud_firestore/cloud_firestore.dart';

class LectionModel {
  final String? lectionID;
  final String theme;
  final String trainer;
  final DateTime date;
  final String dayOfWeek;

  const LectionModel({
    this.lectionID,
    required this.theme,
    required this.trainer,
    required this.date,
    required this.dayOfWeek,
  });

  Map<String, dynamic> toFirestore() {
    return {
      if (lectionID != null) 'lectionID': lectionID,
      'date': Timestamp.fromDate(date),
      'teme': theme,
      'trainer': trainer,
      'day': dayOfWeek
    };
  }

  static LectionModel fromFirestore(Map<String, dynamic> doc) {
    return LectionModel(
        lectionID: doc['lectionID'],
        theme: doc['teme'],
        trainer: doc['trainer'],
        date: (doc['date'] as Timestamp).toDate(),
        dayOfWeek: doc['day']);
  }
}
