part of 'app_settings_bloc.dart';

/// Events for the [AppSettingsBloc].
sealed class AppSettingsEvent {
  const AppSettingsEvent();

  /// Update the app settings.
  const factory AppSettingsEvent.updateAppSettings({
    required AppSettings appSettings,
  }) = _UpdateAppSettingsEvent;
}

final class _UpdateAppSettingsEvent extends AppSettingsEvent {
  const _UpdateAppSettingsEvent({required this.appSettings});

  /// The theme to update.
  final AppSettings appSettings;

  @override
  String toString() => 'SettingsEvent.updateAppSettings(appSettings: $appSettings)';
}