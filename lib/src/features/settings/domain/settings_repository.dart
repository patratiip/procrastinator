import 'package:procrastinator/src/features/settings/data/app_settings_datasource.dart';
import 'package:procrastinator/src/features/settings/domain/app_settings.dart';

/// {@template app_settings_repository}
/// [IAppSettingsRepository] sets and gets app settings.
/// {@endtemplate}
abstract interface class IAppSettingsRepository {
  /// Set app settings
  Future<void> setAppSettings(AppSettings appSettings);

  /// Load [AppSettings] from the source of truth.
  Future<AppSettings?> getAppSettings();
}

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
