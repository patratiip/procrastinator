part of 'user_profile_bloc.dart';

sealed class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

final class UserProfileDataChanged extends UserProfileEvent {
  final MyUser? user;
  final Group? group;

  const UserProfileDataChanged({this.user, this.group});
}
