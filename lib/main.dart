// main.dart
import 'package:ble_connect_sample_public/services/arm_band_service_left.dart';
import 'package:ble_connect_sample_public/services/arm_band_service_right.dart';
import 'package:ble_connect_sample_public/services/base_sensor_service.dart';
import 'package:ble_connect_sample_public/services/wheely_hub_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<BaseSensorService>(
        create: (_) => ArmBandServiceLeft()),
    ChangeNotifierProvider(create: (_) => ArmBandServiceRight()),
    ChangeNotifierProvider<BaseSensorService>(
        create: (_) => WheelyHubService()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE Device Connector',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
