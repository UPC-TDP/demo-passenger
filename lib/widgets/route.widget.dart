import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps/providers/driver_provider.dart';
import 'package:maps/providers/map_provider.dart';
import 'package:maps/providers/route_provider.dart';
import 'package:provider/provider.dart';

class RouteWidget extends StatelessWidget {
  RouteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccione Ruta'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RouteSelectedWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.map_rounded),
        backgroundColor: Colors.green,
        onPressed: () async {
          _loadRoute(context);
          _loadDrivers(context);
          await Navigator.pushNamed(context, '/maps');
        },
      ),
    );
  }

  void _loadRoute(BuildContext context) {
    Provider.of<MapProvider>(context, listen: false).loadRoute();
  }

  void _loadDrivers(BuildContext context) {
    Provider.of<DriverProvider>(context, listen: false).loadDrivers(context);
  }
}

class RouteSelectedWidget extends StatelessWidget {
  RouteSelectedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton<String>(
          isExpanded: true,
          value:
              Provider.of<RouteProvider>(context, listen: true).selectedRoute,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String? selectedRoute) {
            _selectedRoute(context, selectedRoute!);
          },
          items: Provider.of<RouteProvider>(context, listen: false)
              .routes
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  void _selectedRoute(BuildContext context, String selectedRoute) {
    Provider.of<RouteProvider>(context, listen: false).selectedRoute =
        selectedRoute;
  }
}
