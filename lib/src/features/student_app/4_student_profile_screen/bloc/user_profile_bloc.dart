import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_repository/group_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final IUserRepository _userRepository;
  late final StreamSubscription<MyUser> _userSubscription;
  final IGroupRepository _groupRepository;
  late final StreamSubscription<Group> _groupSubscription;
  UserProfileBloc(
      {required IUserRepository userRepository,
      required IGroupRepository groupRepository})
      : _userRepository = userRepository,
        _groupRepository = groupRepository,
        super(const UserProfileState()) {
    //Subscription User
    _userSubscription = userRepository.user.listen((user) {
      add(UserProfileDataChanged(user: user));
    }, cancelOnError: false);

    /// Subscription Group
    _groupSubscription = groupRepository.myGroupStream().listen((group) {
      add(UserProfileDataChanged(group: group));
    }, cancelOnError: false);

    on<UserProfileDataChanged>(
      (event, emit) {
        final newState = state.copyWith(
          user: event.user ?? state.user,
          group: event.group ?? state.group,
        );

        emit(newState);
        // log('New state emitted: $newState');
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    log('User subscription was cancelled');
    return super.close();
  }
}
