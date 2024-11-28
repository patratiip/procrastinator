part of 'app_settings_bloc.dart';

sealed class AppSettingsState extends Equatable {
  const AppSettingsState();
  
  @override
  List<Object> get props => [];
}

final class AppSettingsInitial extends AppSettingsState {}
