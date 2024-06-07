import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

// part 'lection_model.g.dart';

// @HiveType(typeId: 3)
class Lection extends Equatable {
  // @HiveField(0)
  final String? theme;
  // final String? trainerImg;
  // @HiveField(1)
  final String? trainer;
  // @HiveField(2)
  final DateTime? date;
  // @HiveField(3)
  final String? dayOfWeek;
  // @HiveField(4)
  final String? lectionID;

  const Lection(
      {
      // this.trainerImg,
      this.theme,
      this.trainer,
      this.date,
      this.dayOfWeek,
      this.lectionID});

  @override
  List<Object?> get props => [theme, trainer, date, dayOfWeek, lectionID];
}
