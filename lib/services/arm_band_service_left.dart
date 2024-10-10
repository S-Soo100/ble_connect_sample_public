import 'package:ble_connect_sample_public/services/base_sensor_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

final class ArmBandServiceLeft extends BaseSensorService {
  bool isScanning = false;
  late BluetoothService serviceNordic; // 6e400001과 같은 최상위 서비스
  late BluetoothService serviceNordicNotify; // notify = read 서비스
  late BluetoothService serviceNordicWrite; // write = send 서비스
}
