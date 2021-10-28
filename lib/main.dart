import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:maps/providers/driver_provider.dart';
import 'package:maps/providers/route_provider.dart';
import 'package:maps/providers/map_provider.dart';
import 'package:maps/widgets/maps.widget.dart';
import 'package:maps/widgets/route.widget.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: RouteProvider(),
          ),
          ChangeNotifierProvider.value(
            value: DriverProvider(),
          ),
          ChangeNotifierProvider.value(
            value: MapProvider(),
          ),
        ],
        child: MaterialApp(
          routes: {
            '/home': (BuildContext context) => RouteWidget(),
            '/maps': (BuildContext context) => MapsWidget()
          },
          title: 'Demo Passenger',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: RouteWidget(),
        ));
  }
}
