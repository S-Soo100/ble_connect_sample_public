import 'package:ble_connect_sample_public/core/consts.dart';
import 'package:flutter/foundation.dart';
import 'base_sensor_service.dart';

// ArmBandServiceLeft: TracME_UL (왼쪽) 관리
class ArmBandServiceLeft extends BaseSensorService {
  ArmBandServiceLeft() {
    deviceNames = [Consts.leftArmBandName];
  }

  @override
  void handleNotifyData(List<int> value) {
    if (kDebugMode) {
      print("Left signal is  $value");
    }
    String c = '';
    for (int i = 0; i < value.length && value[i] != 0; i++) {
      c += String.fromCharCode(value[i]);
    }
    try {
      notifyValue = cleanString(c);

      int intValue = int.parse(notifyValue);

      if (isCalibrating) {
        if (intValue > maxValueNum) {
          maxValueNum = intValue;
        }
        if (intValue < minValueNum) {
          minValueNum = intValue;
        }
      }

      if (isCounting) {
        countNumber(intValue);
      }
    } catch (e) {
      notifyValue = "";
    }
    notifyListeners();
  }
}
