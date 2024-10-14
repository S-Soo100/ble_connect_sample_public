import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';

class BaseSensorService with ChangeNotifier {
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? writeCharacteristic;
  BluetoothCharacteristic? notifyCharacteristic;

  bool isScanning = false;

  // notify 데이터를 저장할 맵 (특성 UUID를 키로 사용)
  Map<String, List<int>> notifyDatas = {};

  // 장치 이름 목록을 저장하는 내부 변수
  late List<String> deviceNames;

  // 장치 스캔을 시작하는 메서드
  Future<void> startScan() async {
    if (!isScanning && deviceNames.isNotEmpty) {
      isScanning = true;
      await FlutterBluePlus.startScan(withNames: deviceNames);
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (deviceNames.contains(result.device.name)) {
            connectDevice(result.device);
            break;
          }
        }
      });
      notifyListeners();
    }
  }

  // 장치와 연결하는 메서드
  void connectDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      connectedDevice = device;
      discoverServices(device);
    } catch (e) {
      print("Device connection error: $e");
    }
    notifyListeners();
  }

  // 서비스 탐색 메서드
  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.uuid.toString() ==
            "6e400003-b5a3-f393-e0a9-e50e24dcca9e") {
          notifyCharacteristic = characteristic;
          listenToNotifications(characteristic);
        } else if (characteristic.uuid.toString() ==
            "6e400002-b5a3-f393-e0a9-e50e24dcca9e") {
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
      // Notify 데이터를 저장
      notifyDatas[characteristic.uuid.toString()] = value;

      // notifyListeners()를 통해 UI 업데이트
      notifyListeners();
    });
  }

  // 데이터 전송 메서드
  void sendData(String data) {
    if (writeCharacteristic != null) {
      writeCharacteristic!.write(utf8.encode(data));
    }
  }

  // 스캔을 중지하는 메서드
  void stopScan() {
    FlutterBluePlus.stopScan();
    isScanning = false;
    notifyListeners();
  }
}
