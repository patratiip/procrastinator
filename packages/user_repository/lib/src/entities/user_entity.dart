import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/src/models/school_geopos.dart';

class MyUserEntity {
  String userId;
  String email;
  String userType;
  String? name;
  String? photoURL;
  SchoolGeoPosition? schoolGeoPosition;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.userType,
    this.name,
    this.photoURL,
    this.schoolGeoPosition,
  });

  Map<String, Object?> toDocument() {
    return {
      'uid': userId,
      'email': email,
      'userType': userType,
      if (name != null) 'name': name,
      if (photoURL != null) 'photoURL': photoURL,
      if (schoolGeoPosition != null)
        'schoolGeoPosition': SchoolGeoPosition.toFirebase(schoolGeoPosition!),
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['uid'],
      email: doc['email'],
      userType: doc['userType'],
      name: doc['name'],
      photoURL: doc['photoURL'],
      schoolGeoPosition:
          SchoolGeoPosition.fromFirebase(doc['schoolPosition'] as GeoPoint),
    );
  }

  @override
  String toString() {
    return 'MyUserEntity: $userId, $email, $userType, $name, $photoURL, $schoolGeoPosition';
  }
}
