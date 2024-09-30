import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';

class DeviceGeolocationRepository implements GeolocationRepository {
  //
  @override
  Future<bool> isGeolocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  //
  @override
  Future<LocationPermission> checkGeoPositionPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission;
  }

  //
  @override
  Future<LocationPermission> requestGeoPositionPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission;
  }

  //Get current position
  @override
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Position geoposition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // print(geoposition);
    // return geoposition;
  }

  @override
  double distanceToSchool(
      {required Position userGeoposition,
      required double schoolLatitude,
      required double schoolLongtitude}) {
    double distanceToSchool = Geolocator.distanceBetween(
        userGeoposition.latitude,
        userGeoposition.longitude,
        schoolLatitude,
        schoolLongtitude);

    return distanceToSchool;
  }
}
