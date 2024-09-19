import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/school_geopos.dart';
import 'package:user_repository/user_repository.dart';

enum UserType { initial, undefined, student, management, trainer }

class MyUser extends Equatable {
  String userId;
  String email;
  UserType userType;
  String? name;
  String? photoURL;
  SchoolGeoPosition? schoolGeoPosition;

  MyUser({
    required this.userId,
    required this.email,
    required this.userType,
    this.name,
    this.photoURL,
    this.schoolGeoPosition,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    userType: UserType.initial,
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    String _userType = '';

    switch (userType) {
      case UserType.student:
        _userType = 'student';
        break;
      case UserType.management:
        _userType = 'management';
        break;
      case UserType.trainer:
        _userType = 'trainer';
        break;
      default:
        null;
    }
    MyUserEntity entity =
        MyUserEntity(userId: userId, email: email, userType: _userType);

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
    UserType _userType = UserType.undefined;

    switch (entity.userType) {
      case 'student':
        _userType = UserType.student;
        break;
      case 'management':
        _userType = UserType.management;
        break;
      case 'trainer':
        _userType = UserType.trainer;
        break;
      default:
        UserType.undefined;
    }

    MyUser user =
        MyUser(userId: entity.userId, email: entity.email, userType: _userType);

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
    return 'MyUser: $userId, $email, $userType, $name, $photoURL, $schoolGeoPosition';
  }

  @override
  List<Object?> get props =>
      [userId, email, userType, name, photoURL, schoolGeoPosition];
}
