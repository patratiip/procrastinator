import 'package:procrastinator/src/features/student_app/features/lection_plan/data/lection_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';

/// Interface for [LectionRepositoryImpl]
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
final class LectionRepositoryImpl implements ILectionRepository {
  final ILectionDataProvider _lectionDataProvider;

  ///{@macro i_lection_data_provider}
  LectionRepositoryImpl({
    required ILectionDataProvider lectionDataProvider,
  }) : _lectionDataProvider = lectionDataProvider;

  @override
  Stream<List<Lection>> lectionsStream() {
    return _lectionDataProvider
        .lectionsStream()
        .map((entities) =>
            entities.map((entity) => Lection.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Future<Lection?> getTodayLection() async {
    final result = await _lectionDataProvider.getTodayLection();
    if (result == null) return null;
    return Lection.fromModel(result);
  }
}
