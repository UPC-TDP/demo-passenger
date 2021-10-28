import 'package:flutter/material.dart';

class RouteProvider extends ChangeNotifier {
  List<String> _routes = ['1', '2', '3', '4'];
  String _selectedRoute = '1';

  RouteProvider() {}

  List<String> get routes {
    return _routes;
  }

  String get selectedRoute {
    return _selectedRoute;
  }

  set selectedRoute(String selectedRoute) {
    this._selectedRoute = selectedRoute;
    notifyListeners();
  }
}
