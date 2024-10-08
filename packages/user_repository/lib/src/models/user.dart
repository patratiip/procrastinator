// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/school_geopos.dart';
import 'package:user_repository/user_repository.dart';

enum UserType { initial, undefined, student, management, trainer }

class MyUser extends Equatable {
  final String userId;
  final String email;
  final UserType userType;
  final String? name;
  final String? photoURL;
  final SchoolGeoPosition? schoolGeoPosition;
  final String? group;

  const MyUser({
    required this.userId,
    required this.email,
    required this.userType,
    this.name,
    this.photoURL,
    this.schoolGeoPosition,
    this.group,
  });

  static const empty = MyUser(
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
    if (group != null) {
      entity.group = group;
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
      user = user.copyWith(name: entity.name);
    }
    if (entity.photoURL != null) {
      user = user.copyWith(photoURL: entity.photoURL);
    }
    if (entity.schoolGeoPosition != null) {
      user = user.copyWith(schoolGeoPosition: entity.schoolGeoPosition);
    }
    if (entity.group != null) {
      user = user.copyWith(group: entity.group);
    }

    return user;
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $userType, $name, $photoURL, $schoolGeoPosition, $group';
  }

  @override
  List<Object?> get props {
    return [
      userId,
      email,
      userType,
      name,
      photoURL,
      schoolGeoPosition,
      group,
    ];
  }

  MyUser copyWith({
    String? userId,
    String? email,
    UserType? userType,
    String? name,
    String? photoURL,
    SchoolGeoPosition? schoolGeoPosition,
    String? group,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      schoolGeoPosition: schoolGeoPosition ?? this.schoolGeoPosition,
      group: group ?? this.group,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'userId': userId,
  //     'email': email,
  //     'userType': userType.toMap(),
  //     'name': name,
  //     'photoURL': photoURL,
  //     'schoolGeoPosition': schoolGeoPosition?.toMap(),
  //     'group': group,
  //   };
  // }

  // factory MyUser.fromMap(Map<String, dynamic> map) {
  //   return MyUser(
  //     userId: map['userId'] as String,
  //     email: map['email'] as String,
  //     userType: UserType.fromMap(map['userType'] as Map<String, dynamic>),
  //     name: map['name'] != null ? map['name'] as String : null,
  //     photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
  //     schoolGeoPosition: map['schoolGeoPosition'] != null
  //         ? SchoolGeoPosition.fromMap(
  //             map['schoolGeoPosition'] as Map<String, dynamic>)
  //         : null,
  //     group: map['group'] != null ? map['group'] as String : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory MyUser.fromJson(String source) =>
  //     MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
