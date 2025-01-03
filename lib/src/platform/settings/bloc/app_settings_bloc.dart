import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/platform/settings/data/settings_repository.dart';
import 'package:procrastinator/src/platform/settings/model/app_settings.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

/// {@template app_settings_bloc}
/// A [Bloc] that handles [AppSettings].
/// {@endtemplate}
final class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final IAppSettingsRepository _appSettingsRepository;

  /// {@macro app_settings_bloc}
  AppSettingsBloc({
    required IAppSettingsRepository appSettingsRepository,
    required AppSettingsState initialState,
  })  : _appSettingsRepository = appSettingsRepository,
        super(initialState) {
    on<AppSettingsEvent>(
      (event, emit) => switch (event) {
        final _UpdateAppSettingsEvent e => _updateAppSettings(e, emit),
      },
    );
  }

  Future<void> _updateAppSettings(
    _UpdateAppSettingsEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    try {
      emit(_LoadingAppSettingsState(appSettings: state.appSettings));
      await _appSettingsRepository.setAppSettings(event.appSettings);
      emit(_IdleAppSettingsState(appSettings: event.appSettings));
    } catch (error) {
      emit(
          _ErrorAppSettingsState(appSettings: event.appSettings, error: error));
    }
  }
}
