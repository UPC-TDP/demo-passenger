import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  set markers(Set<Marker> markers) {
    this._markers = markers;
  }

  DriverProvider() {
    _loadDriverIcon();
  }

  void loadDrivers() {
    Stream<QuerySnapshot> driverStream =
        _firestore.collection('routes/1/drivers').snapshots();
    driverStream.listen((event) {
      _removeDriverMarker();
      event.docs.forEach((driver) {
        if (driver['latitude'] != null &&
            driver['longitude'] != null &&
            driver['rotation'] != null) {
          _addDriverMarker(MARKER_ID_DRIVER + driver.id, driver['latitude'],
              driver['longitude'], driver['rotation']);
        }
      });

      notifyListeners();
    });
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
    _removeDriverMarker();
    _addDriverMarker(MARKER_ID_DRIVER, location.latitude!, location.longitude!,
        location.heading!);
  }

  void _removeDriverMarker() {
    _markers.removeWhere(
        (marker) => marker.markerId.value.contains(MARKER_ID_DRIVER));
  }

  void _addDriverMarker(id, latitude, longitude, rotation) {
    LatLng latlng = LatLng(latitude, longitude);

    Marker driverMarker = Marker(
        markerId: MarkerId(id),
        position: latlng,
        rotation: rotation,
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
