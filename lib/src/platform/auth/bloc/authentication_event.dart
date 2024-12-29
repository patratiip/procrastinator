part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

final class AuthenticationUserChanged extends AuthenticationEvent {
  final MyUser? user;

  const AuthenticationUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

final class AuthenticationLogOut extends AuthenticationEvent {
  const AuthenticationLogOut();
}
