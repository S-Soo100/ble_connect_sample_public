import 'dart:async';
import 'dart:convert';
import 'package:ble_connect_sample_public/core/consts.dart';
import 'package:ble_connect_sample_public/core/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BaseSensorService with ChangeNotifier, Utility {
  BluetoothDevice? connectedDevice;
  late List<String> deviceNames;
  BluetoothCharacteristic? writeCharacteristic;
  DeviceIdentifier? writeDeviceIdentifier;
  BluetoothCharacteristic? notifyCharacteristic;
  DeviceIdentifier? notifyDeviceIdentifier;

  bool isScanning = false;
  bool isReading = false;
  bool isCalibrating = false;
  bool isCalibrated = false;

  String notifyValue = "";
  int minValueNum = 1500;
  String get minValue => minValueNum.toString();
  int maxValueNum = 0;
  String get maxValue => maxValueNum.toString();

  int count = 0;
  bool isCounting = false;

  // 장치 스캔을 시작하는 메서드
  Future<void> startScan() async {
    if (isScanning) {
      stopScan();
    }
    if (!isScanning && deviceNames.isNotEmpty) {
      isScanning = true;
      await FlutterBluePlus.startScan(withNames: deviceNames);
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (deviceNames.contains(result.device.advName)) {
            connectDevice(result.device);
            break;
          }
        }
      });
      notifyListeners();
    } else {
      stopScan();
    }
  }

  // 장치와 연결하는 메서드
  void connectDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      connectedDevice = device;
      discoverServices(device);
      if (kDebugMode) {
        print("Device connection : ${device.advName}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Device connection error: $e");
      }
    }
    stopScan();
    notifyListeners();
  }

  // 서비스 탐색 메서드
  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Consts.armBandReadUUID) {
          notifyCharacteristic = characteristic;
          listenToNotifications(characteristic);
        } else if (characteristic.uuid.toString() == Consts.armBandWriteUUID) {
          // write
          print("write characteristic connect");
          writeCharacteristic = characteristic;
        }
      }
    }
    notifyListeners();
  }

  // notify 데이터를 처리하는 메서드
  void listenToNotifications(BluetoothCharacteristic characteristic) {
    characteristic.setNotifyValue(true);
    characteristic.lastValueStream.listen((value) {
      handleNotifyData(value); // 하위 클래스에서 처리
      notifyListeners();
    });
  }

  // 데이터 전송 메서드
  void sendData(String data) {
    if (writeCharacteristic != null) {
      writeCharacteristic!.write(utf8.encode(data));
      isReading = true;
    }
  }

  // 스캔을 중지하는 메서드
  void stopScan() {
    FlutterBluePlus.stopScan();
    isScanning = false;
    notifyListeners();
  }

  // 하위 클래스에서 처리할 notify 데이터
  void handleNotifyData(List<int> value) {
    // 하위 클래스에서 구현
  }

  void startCalibrating() {
    minValueNum = 9999;
    maxValueNum = 0;
    isCalibrating = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      isCalibrating = false;
      notifyListeners();
      isCalibrated = true;
    });
  }

  resetCalibrating() {
    if (isCalibrating) return;
    minValueNum = 9999;
    maxValueNum = 0;
    isCalibrating = false;
    isCalibrated = false;
    notifyListeners();
  }

  bool debounce = false;

  void countNumber(int value) {
    if (isCalibrated && isCounting) {
      if (value > maxValueNum * 0.7) {
        if (debounce == false) return;
        count++;
        debounce = true;
        Future.delayed(const Duration(seconds: 1), () {
          debounce = false;
        });
        notifyListeners();
      }
    }
  }

  void setCounting(bool value) {
    isCounting = value;
    notifyListeners();
  }
}
