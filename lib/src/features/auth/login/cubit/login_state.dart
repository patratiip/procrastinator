part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  inProgress,
  success,
  failure,
}

final class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final String email;
  final String password;
  final LoginStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [email, password, status, isValid, errorMessage];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
