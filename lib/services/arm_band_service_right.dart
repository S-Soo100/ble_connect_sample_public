import 'dart:async';
import 'dart:convert';
import 'package:ble_connect_sample_public/core/consts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';

import 'base_sensor_service.dart';

// ArmBandServiceRight: TracME_UR (오른쪽) 관리
class ArmBandServiceRight extends BaseSensorService {
  ArmBandServiceRight() {
    deviceNames = [Consts.rightArmBandName];
  }

  @override
  void handleNotifyData(List<int> value) {
    // TracME_UR에 대한 notify 데이터 처리 로직
    String c = '';
    for (int i = 0; i < value.length && value[i] != 0; i++) {
      c += String.fromCharCode(value[i]);
    }
    print('Right device notify data: $c');
    notifyValue = c;
    notifyListeners();
  }
}
