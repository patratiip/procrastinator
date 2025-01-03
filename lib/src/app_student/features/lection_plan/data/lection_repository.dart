import 'package:procrastinator/src/app_student/features/lection_plan/data/firebase_lection_data_provider.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';

/// Interface for [LectionRepositoryImpl]
///
/// The repository that handles lections
abstract class ILectionRepository {
  /// Getting lections stream
  Stream<List<Lection>> lectionsStream();

  /// Fetching lection for today or null
  Future<Lection?> getTodayLection();
}

/// {@template lection_repository_impl}
/// Implementation of [ILectionRepository].
/// {@endtemplate}
final class LectionRepositoryImpl implements ILectionRepository {
  final ILectionDataProvider _lectionDataProvider;

  /// {@macro lection_repository_impl}
  LectionRepositoryImpl({
    required ILectionDataProvider lectionDataProvider,
  }) : _lectionDataProvider = lectionDataProvider;

  @override
  Stream<List<Lection>> lectionsStream() {
    /// Convert [LectionModel]'s stream to an [Lection] stream
    return _lectionDataProvider
        .lectionsStream()
        .map((entities) =>
            entities.map((entity) => Lection.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Future<Lection?> getTodayLection() async {
    /// Convert [LectionModel] to a [Lection] entity
    final result = await _lectionDataProvider.getTodayLection();
    if (result == null) return null;
    return Lection.fromModel(result);
  }
}
