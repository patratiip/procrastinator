import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolGeoPosition {
  double longitude;
  double latitude;
  SchoolGeoPosition(this.longitude, this.latitude);

  static SchoolGeoPosition fromFirebase(GeoPoint geoPoint) {
    return SchoolGeoPosition(geoPoint.longitude, geoPoint.latitude);
  }

  static GeoPoint toFirebase(SchoolGeoPosition schoolGeoPosition) {
    return GeoPoint(schoolGeoPosition.latitude, schoolGeoPosition.longitude);
  }

  String toString(){
    return 'School Geoposition $latitude, $longitude';
  }
}
