// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection_model.dart';

//TODO: drop Equtable
class Lection extends Equatable {
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
      date: _normalizeDate(model.date),
      dayOfWeek: model.dayOfWeek,
    );
  }

  @override
  List<Object?> get props => [theme, trainer, date, dayOfWeek, lectionID];

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

  /// Returns normalized date
  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
