import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  ///emailChanged
  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
      ),
    );
  }

  ///clearEmailField
  void emailClear() {
    emit(
      state.copyWith(
        email: '',
        // isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  ///passChanged
  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
      ),
    );
  }

  ///Login -
  Future<void> logInWithCredentials() async {
    // if (!state.isValid) return;
    emit(state.copyWith(status: LoginStatus.inProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: LoginStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
