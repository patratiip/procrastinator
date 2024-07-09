import 'package:geolocator/geolocator.dart';

abstract class GeolocationRepository {
  Future<bool> isGeolocationServiceEnabled();
  Future<LocationPermission> checkGeoPositionPermission();
  Future<LocationPermission> requestGeoPositionPermission();
  Future<Position> determinePosition();
  double distanceToSchool(
      {required Position userGeoposition,
      required double schoolLatitude,
      required double schoolLongtitude});
}
