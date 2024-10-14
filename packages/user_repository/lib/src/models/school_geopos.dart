import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolGeoPosition {
  final double latitude;
  final double longitude;

  SchoolGeoPosition({required this.latitude, required this.longitude});

  static SchoolGeoPosition fromFirebase(GeoPoint geoPoint) {
    return SchoolGeoPosition(
        latitude: geoPoint.latitude, longitude: geoPoint.longitude);
  }

  static GeoPoint toFirebase(SchoolGeoPosition schoolGeoPosition) {
    return GeoPoint(schoolGeoPosition.latitude, schoolGeoPosition.longitude);
  }

  @override
  String toString() {
    return 'School Geoposition $latitude, $longitude';
  }
}
