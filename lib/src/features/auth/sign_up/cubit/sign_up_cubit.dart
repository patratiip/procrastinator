// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:user_repository/user_repository.dart';

// part 'sign_up_state.dart';

// class SignUpCubit extends Cubit<SignUpState> {
//   final UserRepository _authenticationRepository;
//   SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  

//   void emailChanged(String value) {
//     final email = Email.dirty(value);
//     emit(
//       state.copyWith(
//         email: email,
//         isValid: Formz.validate([
//           email,
//           state.password,
//           state.confirmedPassword,
//         ]),
//       ),
//     );
//   }

//   void passwordChanged(String value) {
//     final password = Password.dirty(value);
//     final confirmedPassword = ConfirmedPassword.dirty(
//       password: password.value,
//       value: state.confirmedPassword.value,
//     );
//     emit(
//       state.copyWith(
//         password: password,
//         confirmedPassword: confirmedPassword,
//         isValid: Formz.validate([
//           state.email,
//           password,
//           confirmedPassword,
//         ]),
//       ),
//     );
//   }

//   void confirmedPasswordChanged(String value) {
//     final confirmedPassword = ConfirmedPassword.dirty(
//       password: state.password.value,
//       value: value,
//     );
//     emit(
//       state.copyWith(
//         confirmedPassword: confirmedPassword,
//         isValid: Formz.validate([
//           state.email,
//           state.password,
//           confirmedPassword,
//         ]),
//       ),
//     );
//   }

//   Future<void> signUpFormSubmitted() async {
//     if (!state.isValid) return;
//     emit(state.copyWith(status: SignUpStatus.inProgress));
//     try {
//       await _authenticationRepository.signUp(
//         email: state.email,
//         password: state.password,
//       );
//       emit(state.copyWith(status: SignUpStatus.success));
//     } on SignUpWithEmailAndPasswordFailure catch (e) {
//       emit(
//         state.copyWith(
//           errorMessage: e.message,
//           status: SignUpStatus.failure,
//         ),
//       );
//     } catch (_) {
//       emit(state.copyWith(status: SignUpStatus.failure));
//     }
//   }
// }