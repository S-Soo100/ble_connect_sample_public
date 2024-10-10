import 'package:flutter/material.dart';

base class BaseSensorService extends ChangeNotifier {
  static String armbandReadUuid =
      '6e400003-b5a3-f393-e0a9-e50e24dcca9e'; // MCU notify uuid
  static String armbandWriteUuid =
      '6e400002-b5a3-f393-e0a9-e50e24dcca9e'; // MCU write uuid

  void startScan() {}
  void connectionReset() {}
  void stopScan() {}
}
