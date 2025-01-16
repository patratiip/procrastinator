// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection_model.dart';
import 'package:procrastinator/src/core/utils/little_helpers.dart';

class Lection {
  final String? lectionID;
  final String theme;
  final String trainer;
  final DateTime date;
  final String dayOfWeek;

  const Lection({
    this.lectionID,
    required this.theme,
    required this.trainer,
    required this.date,
    required this.dayOfWeek,
  });

  LectionModel toModel() {
    return LectionModel(
      lectionID: lectionID,
      theme: theme,
      trainer: trainer,
      date: date,
      dayOfWeek: dayOfWeek,
    );
  }

  static Lection fromModel(LectionModel model) {
    return Lection(
      lectionID: model.lectionID,
      theme: model.theme,
      trainer: model.trainer,
      date: dateNormalizer(model.date),
      dayOfWeek: model.dayOfWeek,
    );
  }

  Lection copyWith({
    String? lectionID,
    String? theme,
    String? trainer,
    DateTime? date,
    String? dayOfWeek,
  }) {
    return Lection(
      lectionID: lectionID ?? this.lectionID,
      theme: theme ?? this.theme,
      trainer: trainer ?? this.trainer,
      date: date ?? this.date,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    );
  }

  @override
  bool operator ==(covariant Lection other) {
    if (identical(this, other)) return true;

    return other.lectionID == lectionID &&
        other.theme == theme &&
        other.trainer == trainer &&
        other.date == date &&
        other.dayOfWeek == dayOfWeek;
  }

  @override
  int get hashCode {
    return lectionID.hashCode ^
        theme.hashCode ^
        trainer.hashCode ^
        date.hashCode ^
        dayOfWeek.hashCode;
  }

  @override
  String toString() {
    return 'Lection(lectionID: $lectionID, theme: $theme, trainer: $trainer, date: $date, dayOfWeek: $dayOfWeek)';
  }
}
