import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/school_geopos.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
  String userId;
  String email;
  String? name;
  String? photoURL;
  SchoolGeoPosition? schoolGeoPosition;

  MyUser({
    required this.userId,
    required this.email,
    this.name,
    this.photoURL,
    this.schoolGeoPosition,
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
    }
    if (photoURL != null) {
      entity.photoURL = photoURL;
    }
    if (schoolGeoPosition != null) {
      entity.schoolGeoPosition = schoolGeoPosition;
    }

    return entity;
  }

  static MyUser fromEntity(MyUserEntity entity) {
    final MyUser user = MyUser(userId: entity.userId, email: entity.email);
    if (entity.name != null) {
      user.name = entity.name;
    }
    if (entity.photoURL != null) {
      user.photoURL = entity.photoURL;
    }
    if (entity.schoolGeoPosition != null) {
      user.schoolGeoPosition = entity.schoolGeoPosition;
    }

    return user;
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $photoURL, $schoolGeoPosition';
  }

  @override
  List<Object?> get props => [userId, email, name, photoURL, schoolGeoPosition];
}
