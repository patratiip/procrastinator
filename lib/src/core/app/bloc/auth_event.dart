part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

final class _AuthUserChanged extends AuthEvent {
  const _AuthUserChanged(this.user);

  final User user;
}
