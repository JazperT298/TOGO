// ignore_for_file: avoid_print, unused_field, unnecessary_null_comparison

import 'dart:async';

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibank/utils/constants/app_global.dart';
import 'package:location/location.dart';

/// Map
/// This a map showing nearby agences.

class AgenciesMap extends StatefulWidget {
  final double? height, radius;
  final bool fullScreen;
  final void Function(LatLng)? onTap;

  const AgenciesMap(
      {Key? key, this.height, this.radius, this.onTap, this.fullScreen = false})
      : super(key: key);

  @override
  State<AgenciesMap> createState() => AgenciesMapState();
}

class AgenciesMapState extends State<AgenciesMap> {
  late LocationData currentLocation;

  // late String _mapStyle;

  double radius(BuildContext context) => context.height * .055;
  final Completer<GoogleMapController> _controller = Completer();
  // final FluLocationService locationService = Flu.geoService;

  final Set<Marker> _markers = {};
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  /* void getLocation() async {
    await Flu.geoService.determinePosition().then((Position position) {
      final CameraPosition position1 = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: widget.fullScreen ? 14 : 10);

      _controller.future.then((GoogleMapController controller) {
        controller.animateCamera(CameraUpdate.newCameraPosition(position1));
      });
    }).catchError((error) {
      print(error);
    });
  } */

  void getLocation() async {
    Flu.geoService.determinePosition().then((FluPosition fluPosition) async {
      final Position position = fluPosition.position;

      final CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: widget.fullScreen ? 14 : 10,
      );
      _controller.future.then((GoogleMapController controller) {
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      });
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks != null && placemarks.isNotEmpty) {
        setState(() {
          AppGlobal.currentAddress =
              '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}';
          print('current location ${AppGlobal.currentAddress}');
        });
        setState(() {});
      }
    }).catchError((error) {
    
      print('Erreur lors de la récupération de la position : $error');
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    /* rootBundle.loadString('assets/mapStyles/default.txt').then((string) {
      _mapStyle = string;
    }); */
  }

  @override
  Widget build(BuildContext context) => Container(
        height: widget.height ?? double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: context.colorScheme.background,
            borderRadius:
                BorderRadius.circular(widget.radius ?? radius(context))),
        child: GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          scrollGesturesEnabled: widget.fullScreen,
          zoomGesturesEnabled: widget.fullScreen,
          rotateGesturesEnabled: widget.fullScreen,
          initialCameraPosition: _initialPosition,
          compassEnabled: false,
          onTap: (lat) {
            widget.onTap?.call(lat);
            Flu.triggerSelectionClickHaptic();
          },
          onMapCreated: (GoogleMapController controller) {
            if (!_controller.isCompleted) _controller.complete(controller);
            // controller.setMapStyle(_mapStyle);
          },
        ),
      );
}
