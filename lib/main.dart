import 'package:flutter/material.dart';
import 'package:flutter_map_application/live_location_tracking/home.dart';
 import 'package:flutter_map_application/route_tracking/views/google_map_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const
       //GoogleMapView()
       Home( ),
    );
  }
}

