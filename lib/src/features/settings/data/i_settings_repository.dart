import 'package:procrastinator/src/features/settings/model/app_settings.dart';

/// {@template app_settings_repository}
/// [IAppSettingsRepository] sets and gets app settings.
/// {@endtemplate}
abstract interface class IAppSettingsRepository {
  /// Set app settings
  Future<void> setAppSettings(AppSettings appSettings);

  /// Load [AppSettings] from the source of truth.
  Future<AppSettings?> getAppSettings();
}
