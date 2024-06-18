import 'package:lection_repository/src/models/lection.dart';

abstract class LectionRepository {
  Stream<List<Lection>?> getLections();
  Future<Lection>? getTodayLection();
}
