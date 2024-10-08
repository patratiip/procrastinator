import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_repository/group_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final IUserRepository _userRepository;
  final IGroupRepository _groupRepository;
  UserProfileBloc({required userRepository, required groupRepository})
      : _userRepository = userRepository,
        _groupRepository = groupRepository,
        super(UserProfileInitial()) {
    on<UserProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
