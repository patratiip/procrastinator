import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
  String userId;
  String email;
  String? name;
  String? photoURL;

  MyUser({
    required this.userId,
    required this.email,
    this.name,
    this.photoURL,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    final MyUserEntity entity = MyUserEntity(userId: userId, email: email);
    if (name != null) {
      entity.name = name;
    } else if (photoURL != null) {
      entity.photoURL = photoURL;
    }

    return entity;
  }

  static MyUser fromEntity(MyUserEntity entity) {
    final MyUser user = MyUser(userId: entity.userId, email: entity.email);
    if (entity.name != null) {
      user.name = entity.name;
    } else if (entity.photoURL != null) {
      user.photoURL = entity.photoURL;
    }
    return user;
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $photoURL';
  }

  @override
  List<Object?> get props => [userId, email, name, photoURL];
}
