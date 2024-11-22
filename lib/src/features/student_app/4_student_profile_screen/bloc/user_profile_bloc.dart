import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_repository/group_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final IUserRepository _userRepository;
  late final StreamSubscription<MyUser> _userSubscription;
  final IStudentGroupRepository _groupRepository;
  late final StreamSubscription<Group> _groupSubscription;
  UserProfileBloc(
      {required IUserRepository userRepository,
      required IStudentGroupRepository groupRepository})
      : _userRepository = userRepository,
        _groupRepository = groupRepository,
        super(const UserProfileState()) {
    _initializeListeners();

    on<UserProfileEvent>(
      (event, emit) => switch (event) {
        final UserProfileDataChanged e => _userProfileDataChanged(e, emit)
      },
      transformer: sequential(),
    );
  }

  /// Initialize User's document and his Group collection subscriptions
  void _initializeListeners() {
    // Subscription User
    _userSubscription = _userRepository.user.listen((user) {
      add(UserProfileDataChanged(user: user));
    }, cancelOnError: false);

    // Subscription Group
    _groupSubscription = _groupRepository.myGroupStream().listen((group) {
      add(UserProfileDataChanged(group: group));
    }, cancelOnError: false);
  }

  ///
  Future<void> _userProfileDataChanged(
      UserProfileDataChanged event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
      user: event.user ?? state.user,
      group: event.group ?? state.group,
    ));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _groupSubscription.cancel();
    log('User subscription was cancelled');
    log('Group subscription was cancelled');
    return super.close();
  }
}
