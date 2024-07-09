import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/src/models/school_geopos.dart';

class MyUserEntity {
  String userId;
  String email;
  String? name;
  String? photoURL;
  SchoolGeoPosition? schoolGeoPosition;

  MyUserEntity({
    required this.userId,
    required this.email,
    this.name,
    this.photoURL,
    this.schoolGeoPosition,
  });

  Map<String, Object?> toDocument() {
    return {
      'uid': userId,
      'email': email,
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
      name: doc['name'],
      photoURL: doc['photoURL'],
      schoolGeoPosition:
          SchoolGeoPosition.fromFirebase(doc['schoolPosition'] as GeoPoint),
    );
  }

  String toString() {
    return 'MyUserEntity: $userId, $email, $name, $photoURL, $schoolGeoPosition';
  }
}
