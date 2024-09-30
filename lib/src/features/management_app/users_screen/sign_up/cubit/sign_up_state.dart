part of 'sign_up_cubit.dart';

enum SignUpStatus {
  initial,
  inProgress,
  success,
  failure,
}

final class SignUpState extends Equatable {
  final String email;
  final String password;
  final String userName;

  final bool? emailIsValid;
  final bool? passwordIsValid;

  final bool containsUpperCase;
  final bool containsLowerCase;
  final bool containsNumber;
  final bool containsSpecialChar;
  final bool contains8Length;

  final String? errorMessage;
  final SignUpStatus status;

  const SignUpState({
    this.email = '',
    this.password = '',
    this.userName = '',
    this.emailIsValid,
    this.passwordIsValid,
    this.errorMessage,
    this.containsUpperCase = false,
    this.containsLowerCase = false,
    this.containsNumber = false,
    this.containsSpecialChar = false,
    this.contains8Length = false,
    this.status = SignUpStatus.initial,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        userName,
        emailIsValid,
        passwordIsValid,
        containsUpperCase,
        containsLowerCase,
        containsNumber,
        containsSpecialChar,
        contains8Length,
        errorMessage,
        status,
      ];

  SignUpState copyWith({
    String? email,
    String? password,
    String? userName,
    bool? emailIsValid,
    bool? passwordIsValid,
    bool? containsUpperCase,
    bool? containsLowerCase,
    bool? containsNumber,
    bool? containsSpecialChar,
    bool? contains8Length,
    String? errorMessage,
    SignUpStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      userName: userName ?? this.userName,
      emailIsValid: emailIsValid ?? this.emailIsValid,
      passwordIsValid: passwordIsValid ?? this.passwordIsValid,
      containsUpperCase: containsUpperCase ?? this.containsUpperCase,
      containsLowerCase: containsLowerCase ?? this.containsLowerCase,
      containsNumber: containsNumber ?? this.containsNumber,
      containsSpecialChar: containsSpecialChar ?? this.containsSpecialChar,
      contains8Length: contains8Length ?? this.contains8Length,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
