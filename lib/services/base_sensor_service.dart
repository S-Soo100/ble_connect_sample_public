import 'dart:async';
import 'dart:convert';
import 'package:ble_connect_sample_public/core/consts.dart';
import 'package:ble_connect_sample_public/core/utility.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';

class BaseSensorService with ChangeNotifier, Utility {
  BluetoothDevice? connectedDevice;
  late List<String> deviceNames;
  BluetoothCharacteristic? writeCharacteristic;
  DeviceIdentifier? writeDeviceIdentifier;
  BluetoothCharacteristic? notifyCharacteristic;
  DeviceIdentifier? notifyDeviceIdentifier;

  bool isScanning = false;
  bool isReading = false;

  // notify 데이터를 저장할 맵 (특성 UUID를 키로 사용)
  Map<String, List<int>> notifyDatas = {};

  String notifyValue = "";
  int minValueNum = 800;
  String get minValue => minValueNum.toString();
  int maxValueNum = 0;
  String get maxValue => maxValueNum.toString();

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
            print("ARMBAND device ${result.device.advName}");
            connectDevice(result.device);
            break;
          }
        }
      });
      notifyListeners();
    } else {
      stopScan();
      print(" SCANNING OR DEVICE NAME IS EMPTY");
    }
  }

  // 장치와 연결하는 메서드
  void connectDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      connectedDevice = device;
      discoverServices(device);
      print("Device connection : ${device.advName}");
    } catch (e) {
      print("Device connection error: $e");
    }
    stopScan();
    notifyListeners();
  }

  // 서비스 탐색 메서드
  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Consts.readUuid) {
          notifyCharacteristic = characteristic;
          listenToNotifications(characteristic);
        } else if (characteristic.uuid.toString() == Consts.writeUuid) {
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
      // Notify 데이터를 저장
      notifyDatas[characteristic.uuid.toString()] = value;
      // notifyListeners()를 통해 UI 업데이트
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
}
