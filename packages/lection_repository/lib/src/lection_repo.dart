import 'package:lection_repository/src/models/lection.dart';

abstract class ILectionRepository {
  Stream<List<Lection>?> getLections();
  Future<Lection?> getTodayLection();
}
