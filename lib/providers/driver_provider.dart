import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DriverProvider extends ChangeNotifier {
  Location location = Location();
  StreamSubscription? _locationSubscription;

  Set<Marker> _markers = {};

  late BitmapDescriptor _driverIcon;

  final String MARKER_ID_DRIVER = "driver";

  set markers(Set<Marker> markers) {
    this._markers = markers;
  }

  DriverProvider() {
    _loadDriverIcon();
  }

  void drive(GoogleMapController googleMapController) async {
    try {
      LocationData locationData = await this.location.getLocation();
      _updateDriverMarker(locationData);

      if (_locationSubscription != null) {
        _locationSubscription!.cancel();
      }

      _locationSubscription =
          this.location.onLocationChanged.listen((locationData) {
        if (googleMapController != null) {
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target:
                      LatLng(locationData.latitude!, locationData.longitude!),
                  tilt: 0,
                  zoom: 18.00)));
          _updateDriverMarker(locationData);
          notifyListeners();
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print("Permission Denied");
      }
    }

    notifyListeners();
  }

  void _updateDriverMarker(LocationData location) {
    LatLng latlng = LatLng(location.latitude!, location.longitude!);

    try {
      Marker driverMarker = _markers
          .firstWhere((marker) => marker.markerId.value == MARKER_ID_DRIVER);
      _markers.remove(driverMarker);
    } catch (e) {}

    Marker driverMarker = Marker(
        markerId: MarkerId(MARKER_ID_DRIVER),
        position: latlng,
        rotation: location.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: _driverIcon);

    _markers.add(driverMarker);
  }

  void _loadDriverIcon() async {
    _driverIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driver.png');
  }
}
