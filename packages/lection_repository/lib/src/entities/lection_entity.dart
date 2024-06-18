import 'package:cloud_firestore/cloud_firestore.dart';

class LectionEntity {
  final String? lectionID;
  final String? theme;
  final String? trainer;
  final DateTime? date;
  final String? dayOfWeek;

  const LectionEntity({
    this.lectionID,
    required this.theme,
    required this.trainer,
    required this.date,
    required this.dayOfWeek,
  });

//Don't needed, but.. nice to have
  Map<String, dynamic> toFirestore() {
    return {
      if (lectionID != null) 'lectionID': lectionID,
      if (date != null) 'date': Timestamp.fromDate(date!),
      if (theme != null) 'teme': theme,
      if (trainer != null) 'trainer': trainer,
      if (dayOfWeek != null) 'day': dayOfWeek
    };
  }

  static LectionEntity fromFirestore(Map<String, dynamic> doc) {
    return LectionEntity(
        lectionID: doc['lectionID'],
        theme: doc['teme'],
        trainer: doc['trainer'],
        date: (doc['date'] as Timestamp).toDate(),
        dayOfWeek: doc['day']);
  }
}
