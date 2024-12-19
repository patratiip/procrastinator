part of 'login_cubit.dart';

enum LoginStatus {
  idle,
  inProgress,
  success,
  error,
}

final class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final bool? emailIsValid;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.idle,
    this.emailIsValid,
    this.errorMessage,
  });

  @override
  List<Object?> get props =>
      [email, password, status, emailIsValid, errorMessage];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    bool? emailIsValid,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      emailIsValid: emailIsValid ?? this.emailIsValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
