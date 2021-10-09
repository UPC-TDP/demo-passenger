import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/dtos/marks_response_dto.dart';
import 'package:maps/models/mark_model.dart';
import 'package:maps/services/marks_service.dart';

class MapProvider extends ChangeNotifier {
  List<LatLng> _polylines = [];
  Set<Marker> _markers = {};
  String _mapStyle = "";

  late BitmapDescriptor _startPointIcon;
  late BitmapDescriptor _finishPointIcon;
  late BitmapDescriptor _busStopIcon;

  MapProvider() {
    _loadIcons();
    ;
  }

  List<LatLng> get polylines {
    return this._polylines;
  }

  Set<Marker> get markers {
    return this._markers;
  }

  String get mapStyle {
    return this._mapStyle;
  }

  void loadRoute() async {
    MarksService marksService = MarksService.create();
    MarksResponseDto marksResponseDto =
        MarksResponseDto.fromJson((await marksService.getMarks()).body);

    List<MarkModel> marks = marksResponseDto.data!
        .map((mark) => MarkModel(
            mark.id!,
            mark.name!,
            double.parse(mark.latitude!),
            double.parse(mark.longitude!),
            mark.isBusStop!,
            mark.isStartPoint!,
            mark.isEndPoint!))
        .toList();

    _loadPolylines(marks);
    _loadMarkers(marks);

    notifyListeners();
  }

  void _loadMarkers(List<MarkModel> marks) {
    Set<Marker> markers = {};

    markers = marks
        .where(
            (mark) => mark.isBusStop || mark.isFinishPoint || mark.isStartPoint)
        .map((mark) => Marker(
            markerId: MarkerId(mark.id.toString()),
            infoWindow: InfoWindow(
                title: mark.name,
                snippet:
                    'Latitud: ${mark.latitude}, Longitud: ${mark.longitude}'),
            position: LatLng(mark.latitude, mark.longitude),
            icon: mark.isStartPoint
                ? _startPointIcon
                : mark.isFinishPoint
                    ? _finishPointIcon
                    : _busStopIcon))
        .toSet();

    if (markers.length > 0) {
      this._markers = markers;
    }
  }

  void _loadPolylines(List<MarkModel> marks) {
    List<LatLng> polylines = [];

    polylines = marks
        .where((mark) =>
            !mark.isStartPoint && !mark.isFinishPoint && !mark.isBusStop)
        .map((mark) => LatLng(mark.latitude, mark.longitude))
        .toList();

    if (polylines.length > 0) {
      this._polylines = polylines;
    }
  }

  void _loadIcons() async {
    _startPointIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/start-point.png');

    _finishPointIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/finish-point.png');

    _busStopIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/bus-stop.png');
  }
}
