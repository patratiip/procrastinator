import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lection_model.freezed.dart';

@freezed
class LectionModel with _$LectionModel {
  const LectionModel._();

  const factory LectionModel({
    @Default(null) final String? lectionID,
    required final String theme,
    required final String trainer,
    required final DateTime date,
    required final String dayOfWeek,
  }) = _LectionModel;

  /// Converts LectionModel to Json for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      if (lectionID != null) 'lectionID': lectionID,
      'date': Timestamp.fromDate(date),
      'teme': theme,
      'trainer': trainer,
      'day': dayOfWeek
    };
  }

  /// Converts Json from Firestore to [LectionModel]
  static LectionModel fromFirestore(Map<String, dynamic> doc) {
    return LectionModel(
        lectionID: doc['lectionID'],
        theme: doc['teme'],
        trainer: doc['trainer'],
        date: (doc['date'] as Timestamp).toDate(),
        dayOfWeek: doc['day']);
  }
}



// class LectionModel {
//   final String? lectionID;
//   final String theme;
//   final String trainer;
//   final DateTime date;
//   final String dayOfWeek;

//   const LectionModel({
//     this.lectionID,
//     required this.theme,
//     required this.trainer,
//     required this.date,
//     required this.dayOfWeek,
//   });

//   Map<String, dynamic> toFirestore() {
//     return {
//       if (lectionID != null) 'lectionID': lectionID,
//       'date': Timestamp.fromDate(date),
//       'teme': theme,
//       'trainer': trainer,
//       'day': dayOfWeek
//     };
//   }

//   static LectionModel fromFirestore(Map<String, dynamic> doc) {
//     return LectionModel(
//         lectionID: doc['lectionID'],
//         theme: doc['teme'],
//         trainer: doc['trainer'],
//         date: (doc['date'] as Timestamp).toDate(),
//         dayOfWeek: doc['day']);
//   }
// }