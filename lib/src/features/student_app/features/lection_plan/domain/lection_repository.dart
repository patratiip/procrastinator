import 'package:procrastinator/src/features/student_app/features/lection_plan/data/lection_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/domain/lection.dart';

/// Interface for [LectionRepository]
///
/// The repository that handles lections
abstract class ILectionRepository {
  /// Getting lections stream
  Stream<List<Lection>> lectionsStream();

  /// Fetching lection for today or null
  Future<Lection?> getTodayLection();
}

/// {@template i_lection_data_provider.class}
/// Implementation of [ILectionRepository].
/// {@endtemplate}
class LectionRepository implements ILectionRepository {
  final ILectionDataProvider _lectionDataProvider;

  ///{@macro i_lection_data_provider}
  LectionRepository({
    required ILectionDataProvider lectionDataProvider,
  }) : _lectionDataProvider = lectionDataProvider;

  @override
  Stream<List<Lection>> lectionsStream() {
    return _lectionDataProvider
        .lectionsStream()
        .map((entities) =>
            entities.map((entity) => Lection.fromEntity(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Future<Lection?> getTodayLection() async {
    final result = await _lectionDataProvider.getTodayLection();
    if (result == null) return null;
    return Lection.fromEntity(result);
  }
}
