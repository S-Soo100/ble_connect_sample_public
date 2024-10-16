import 'dart:async';
import 'dart:convert';
import 'package:ble_connect_sample_public/core/consts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';
import 'base_sensor_service.dart';

// ArmBandServiceLeft: TracME_UL (왼쪽) 관리
class ArmBandServiceLeft extends BaseSensorService {
  ArmBandServiceLeft() {
    deviceNames = [Consts.leftArmBandName];
  }

  @override
  void handleNotifyData(List<int> value) {
    // TracME_UL에 대한 notify 데이터 처리 로직
    print("Left signal is  " + value.toString());
    String c = '';
    for (int i = 0; i < value.length && value[i] != 0; i++) {
      c += String.fromCharCode(value[i]);
    }
    print('ARMBAND Left device notify data: $c');

    notifyValue = c;
    notifyListeners();
  }
}
