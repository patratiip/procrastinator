import 'package:settings_repository/settings_repository.dart';

/// {@template app_settings_repository}
/// [IAppSettingsRepository] sets and gets app settings.
/// {@endtemplate}
abstract interface class IAppSettingsRepository {
  /// Set app settings
  Future<void> setAppSettings(AppSettings appSettings);

  /// Load [AppSettings] from the source of truth.
  Future<AppSettings?> getAppSettings();
}
