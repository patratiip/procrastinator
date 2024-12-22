part of 'app_settings_bloc.dart';

/// States for the [AppSettingsBloc].
sealed class AppSettingsState {
  const AppSettingsState({this.appSettings});

  /// Application locale.
  final AppSettings? appSettings;

  /// The app settings are idle.
  const factory AppSettingsState.idle({AppSettings? appSettings}) = _IdleAppSettingsState;

  /// The app settings are loading.
  const factory AppSettingsState.loading({AppSettings? appSettings}) = _LoadingAppSettingsState;

  /// The app settings have an error.
  const factory AppSettingsState.error({
    required Object error,
    AppSettings? appSettings,
  }) = _ErrorAppSettingsState;
}

final class _IdleAppSettingsState extends AppSettingsState {
  const _IdleAppSettingsState({super.appSettings});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _IdleAppSettingsState && other.appSettings == appSettings;
  }

  @override
  int get hashCode => appSettings.hashCode;

  @override
  String toString() => 'SettingsState.idle(appSettings: $appSettings)';
}

final class _LoadingAppSettingsState extends AppSettingsState {
  const _LoadingAppSettingsState({super.appSettings});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _LoadingAppSettingsState && other.appSettings == appSettings;
  }

  @override
  int get hashCode => appSettings.hashCode;

  @override
  String toString() => 'SettingsState.loading(appSettings: $appSettings)';
}

final class _ErrorAppSettingsState extends AppSettingsState {
  const _ErrorAppSettingsState({required this.error, super.appSettings});

  /// The error.
  final Object error;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ErrorAppSettingsState &&
        other.appSettings == appSettings &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(appSettings, error);

  @override
  String toString() => 'SettingsState.error(appSettings: $appSettings, error: $error)';
}