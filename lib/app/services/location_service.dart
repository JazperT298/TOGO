// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison, avoid_print, prefer_is_empty, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:flukit/flukit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:location/location.dart';

class LocationService extends GetxService {
  RxList<Placemark> placemarks = <Placemark>[].obs;

  RxString fullAddress = ''.obs;

  RxString city = ''.obs;

  Rx<LatLng> latlng = const LatLng(0.0, 0.0).obs;

  Rx<Position> position = Position(
          altitude: 0.0,
          heading: 0.0,
          timestamp: DateTime.now(),
          latitude: 0.0,
          longitude: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          accuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0)
      .obs;

  //Init location service
  Future<LocationService> init() async {
    await _checkPermission();
    return this;
  }

  //Check location permission
  Future<void> _checkPermission() async {
    print("_checkPermission initialize");
    // late LocationPermission permission;
    late PermissionStatus permissionStatus;
    late bool serviceEnabled;

    serviceEnabled = await Flu.geoService.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permissionStatus = await location.Location.instance.hasPermission();
    permissionStatus = PermissionStatus.grantedLimited;
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.Location.instance.requestPermission();
      permissionStatus = PermissionStatus.granted;
      if (permissionStatus == LocationPermission.denied) {
        permissionStatus = PermissionStatus.granted;
        // Get.off(() => CurrentLocationView());
        return Future.error('Location permissions are denied');
      }
    }

    if (permissionStatus == LocationPermission.deniedForever) {
      // Get.off(() => CurrentLocationView());
      permissionStatus = PermissionStatus.grantedLimited;

      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    print('serviceEnabled $serviceEnabled');
    await getLocation();
    // await translateCoordinates();
  }

  Future<void> getLocation() async {
    // FluPosition fluPositions = await Flu.geoService.determinePosition();
    Flu.geoService.determinePosition().then((FluPosition fluPosition) async {
      position.value = fluPosition.position;

      // final CameraPosition cameraPosition = CameraPosition(
      //   target: LatLng(position.latitude, position.longitude),
      //   zoom: widget.fullScreen ? 14 : 10,
      // );
      // _controller.future.then((GoogleMapController controller) {
      //   controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      // });
      latlng.value = LatLng(fluPosition.position.latitude, fluPosition.position.longitude);

      placemarks.value = await placemarkFromCoordinates(
        fluPosition.position.latitude,
        fluPosition.position.longitude,
      );
      print('serviceEnabled LATLONG ${LatLng(fluPosition.position.latitude, fluPosition.position.longitude)}');

      // if (placemarks != null && placemarks.isNotEmpty) {
      //   AppGlobal.currentAddress = '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}';
      //   print('current location ${AppGlobal.currentAddress}');
      // }
      if (placemarks.length > 0) {
        fullAddress.value = '${placemarks[0].street}' +
            " "
                '${placemarks[0].locality}' +
            " " +
            '${placemarks[0].subAdministrativeArea}';

        city.value = placemarks[0].locality!;

        print("full address : $fullAddress");
      }
    }).catchError((error) {
      print('Erreur lors de la récupération de la position : $error');
    });
  }

  //Translate lat lng to an list of address
  // Future<void> translateCoordinates() async {
  //   print('2');
  //   try {
  //     placemarks.value = await placemarkFromCoordinates(
  //       latlng.value.latitude,
  //       latlng.value.longitude,
  //     );
  //   } catch (err) {
  //     print('error');
  //     print('_translateCoordinates $err');
  //   }
  //   if (placemarks.length > 0) {
  //     fullAddress.value = '${placemarks[0].street}' +
  //         " "
  //             '${placemarks[0].locality}' +
  //         " " +
  //         '${placemarks[0].subAdministrativeArea}';

  //     city.value = placemarks[0].locality!;

  //     print("full address : $fullAddress");
  //   }
  // }
}
