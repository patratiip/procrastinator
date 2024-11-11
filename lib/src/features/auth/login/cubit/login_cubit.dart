import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final IUserRepository _authenticationRepository;
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  ///emailChanged
  void emailChanged(String value) {
    emit(state.copyWith(
        errorMessage: null, emailIsValid: null, status: LoginStatus.initial));

    emit(state.copyWith(email: value));
  }

  //TODO add Validation event on changed field focus

  ///clearEmailField
  void emailClear() {
    emit(state.copyWith(
        email: '',
        errorMessage: null,
        emailIsValid: null,
        status: LoginStatus.initial));
  }

  ///passChanged
  void passwordChanged(String value) {
    emit(state.copyWith(errorMessage: null, status: LoginStatus.initial));
    emit(state.copyWith(password: value));
  }

  ///clearEmailField
  void resetPassword() async {
    //Validation
    final emailIsValid = validateEmail(state.email);
    if (!emailIsValid) {
      emit(state.copyWith(
          errorMessage: 'Please enter a valid email',
          emailIsValid: false,
          status: LoginStatus.failure));
    } else {
      await _authenticationRepository.onPasswordReseting(email: state.email);
      emit(state.copyWith(password: '', status: LoginStatus.initial));
    }
  }

  /// Login -
  Future<void> logInWithCredentials() async {
    emit(state.copyWith(status: LoginStatus.inProgress));

    // Validation
    if (!validateEmail(state.email)) {
      emit(state.copyWith(
          errorMessage: 'Please enter a valid email',
          emailIsValid: false,
          status: LoginStatus.failure));
      return;
    }

    try {
      await _authenticationRepository.signIn(
        state.email,
        state.password,
      );
      // await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: LoginStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.failure,
        ),
      );
      // } catch (_) {
      //   emit(state.copyWith(status: LoginStatus.failure));
    }
  }

  // Email validator
  bool validateEmail(String value) {
    if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}
