part of 'user_profile_bloc.dart';

final class UserProfileState extends Equatable {
  final MyUser? user;
  final Group? group;
  const UserProfileState({this.user, this.group});

  UserProfileState copyWith({
    MyUser? user,
    Group? group,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      group: group ?? this.group,
    );
  }

  @override
  List<Object?> get props => [user, group];

  @override
  String toString() {
    return 'UserProfileState: ${this.user}, ${this.group}';
  }
}
