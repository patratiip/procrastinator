import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_repository/group_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpCubitState> {
  final IUserRepository _authenticationRepository;
  final IManagementGroupRepository _groupRepository;

  SignUpCubit(this._authenticationRepository, this._groupRepository)
      : super(const SignUpCubitState());

  ///emailChanged
  void emailChanged(String value) {
    emit(state.copyWith(
        errorMessage: null, emailIsValid: null, status: SignUpStatus.initial));

    emit(state.copyWith(email: value));
  }

  //TODO add Validation event on changed field focus

  ///clearEmailField
  void emailClear() {
    emit(state.copyWith(
        email: '',
        errorMessage: null,
        emailIsValid: null,
        status: SignUpStatus.initial));
  }

  ///userNameChanged
  void userNameChanged(String value) {
    emit(state.copyWith(errorMessage: null, status: SignUpStatus.initial));

    emit(state.copyWith(userName: value));
  }

  //TODO add Validation event on changed field focus

  ///userNameField
  void userNameClear() {
    emit(state.copyWith(
        userName: '', errorMessage: null, status: SignUpStatus.initial));
  }

  ///passChanged
  void passwordChanged(String value) {
    emit(state.copyWith(errorMessage: null, status: SignUpStatus.initial));
    _validatePassCharacters(value);
    emit(state.copyWith(password: value));
  }

  ///groupChanged
  void groupChanged(Group group) {
    emit(state.copyWith(errorMessage: null, status: SignUpStatus.initial));

    emit(state.copyWith(groupRef: group.groupID));
  }

  ///userTypeChanged
  void userTypeChanged(UserType userType) {
    emit(state.copyWith(errorMessage: null, status: SignUpStatus.initial));

    emit(state.copyWith(userType: userType));
  }

  ///geopositionChanged
  void geopositionChanged(SchoolGeoPosition schoolGeoPosition) {
    emit(state.copyWith(errorMessage: null, status: SignUpStatus.initial));

    emit(state.copyWith(schoolGeoPosition: schoolGeoPosition));
  }

  Future<void> signUpAndCreateUserCollection() async {
    //Email Validation
    final mailIsValid = _validateEmail(state.email);
    //Pass Validation
    final passIsValid = _validatePassword(state.password);

    if (!mailIsValid) {
      emit(state.copyWith(
          errorMessage: 'Please enter a valid email',
          emailIsValid: false,
          status: SignUpStatus.failure));
    } else if (!passIsValid) {
      emit(state.copyWith(
          errorMessage: 'Please enter a valid password',
          passwordIsValid: false,
          status: SignUpStatus.failure));
    } else if (state.userName.isEmpty) {
      emit(state.copyWith(
          errorMessage: 'Please enter a user name',
          status: SignUpStatus.failure));
    } else if (state.userType == UserType.undefined) {
      emit(state.copyWith(
          errorMessage: 'Please enter a user type',
          status: SignUpStatus.failure));
    } else if (state.userType == UserType.student && state.groupRef == null) {
      emit(state.copyWith(
          errorMessage: 'Please enter a user group',
          status: SignUpStatus.failure));
    } else if (state.userType == UserType.student &&
        state.schoolGeoPosition == null) {
      emit(state.copyWith(
          errorMessage: 'Please enter a user school geoposition',
          status: SignUpStatus.failure));
    } else {
      emit(state.copyWith(status: SignUpStatus.inProgress));

      //Creating local user from state
      MyUser userFromForm = MyUser.empty;
      userFromForm = userFromForm.copyWith(email: state.email);
      userFromForm = userFromForm.copyWith(name: state.userName);
      try {
        MyUser myUser = await _authenticationRepository.signUp(
            userFromForm, state.password);

        //Creating user collection
        if (state.userType == UserType.student) {
          await _authenticationRepository.setUserData(myUser.copyWith(
            userType: state.userType,
            group: state.groupRef,
            schoolGeoPosition: state.schoolGeoPosition,
          ));
          await _groupRepository.addStudentToGroup(
              state.groupRef!, myUser.userId);
        } else {
          await _authenticationRepository
              .setUserData(myUser.copyWith(userType: state.userType));
        }

        // emit(state.copyWith(status: SignUpStatus.success));
      } on SignUpWithEmailAndPasswordFailure catch (e) {
        emit(
          state.copyWith(
            errorMessage: e.message,
            status: SignUpStatus.failure,
          ),
        );
      } catch (e) {
        //TODO exception
        log(e.toString());
        // emit(state.copyWith(
        //     errorMessage: e.toString(), status: SignUpStatus.failure));
      }
    }
  }

  //Email validator
  bool _validateEmail(String value) {
    if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  //Password validator
  bool _validatePassword(String value) {
    if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
        .hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  //Password Character Validator
  void _validatePassCharacters(String value) {
    if (value.contains(RegExp(r'[A-Z]'))) {
      emit(state.copyWith(containsUpperCase: true));
    } else {
      emit(state.copyWith(containsUpperCase: false));
    }
    if (value.contains(RegExp(r'[a-z]'))) {
      emit(state.copyWith(containsLowerCase: true));
    } else {
      emit(state.copyWith(containsLowerCase: false));
    }
    if (value.contains(RegExp(r'[0-9]'))) {
      emit(state.copyWith(containsNumber: true));
    } else {
      emit(state.copyWith(containsNumber: false));
    }
    if (value
        .contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
      emit(state.copyWith(containsSpecialChar: true));
    } else {
      emit(state.copyWith(containsSpecialChar: false));
    }
    if (value.length >= 8) {
      emit(state.copyWith(contains8Length: true));
    } else {
      emit(state.copyWith(contains8Length: false));
    }
  }
}
