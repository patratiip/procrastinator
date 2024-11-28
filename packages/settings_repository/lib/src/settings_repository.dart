import 'package:settings_repository/settings_repository.dart';

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
