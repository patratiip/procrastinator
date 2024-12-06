import 'package:procrastinator/src/features/settings/data/app_settings_datasource.dart';
import 'package:procrastinator/src/features/settings/data/i_settings_repository.dart';
import 'package:procrastinator/src/features/settings/model/app_settings.dart';

/// {@macro app_settings_repository}
final class AppSettingsRepositoryImpl implements IAppSettingsRepository {
  /// {@macro app_settings_repository}
  const AppSettingsRepositoryImpl({required this.datasource});

  /// The instance of [IAppSettingsDatasource] used to read and write values.
  final IAppSettingsDatasource datasource;

  @override
  Future<AppSettings?> getAppSettings() => datasource.getAppSettings();

  @override
  Future<void> setAppSettings(AppSettings appSettings) =>
      datasource.setAppSettings(appSettings);
}
