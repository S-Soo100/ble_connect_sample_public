import 'package:ble_connect_sample_public/services/arm_band_service_left.dart';
import 'package:ble_connect_sample_public/services/arm_band_service_right.dart';
import 'package:ble_connect_sample_public/services/base_sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArmBand Connection'),
      ),
      body: Column(
        children: [
          // 왼쪽 ArmBand 연결 버튼
          _buildConnectionButton(
            context: context,
            title: 'Connect Left ArmBand',
            service: context.watch<ArmBandServiceLeft>(),
          ),
          Divider(),
          // 오른쪽 ArmBand 연결 버튼
          _buildConnectionButton(
            context: context,
            title: 'Connect Right ArmBand',
            service: context.watch<ArmBandServiceRight>(),
          ),
        ],
      ),
    );
  }

  // 버튼을 공통 메서드로 구성
  Widget _buildConnectionButton({
    required BuildContext context,
    required String title,
    required BaseSensorService service,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            if (!service.isScanning) {
              service.startScan(); // ArmBand 장치 스캔 시작
            }
          },
          child: Text(service.isScanning ? 'Scanning...' : 'Start Scan'),
        ),
        SizedBox(height: 10),
        // 연결 상태 표시
        Text(
          service.connectedDevice != null
              ? 'Connected to ${service.connectedDevice!.name}'
              : 'Not connected',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        // 들어오는 read 값 표시
        Text(
          service.notifyCharacteristic != null
              ? 'Read Value: ${_getNotifyValue(service)}'
              : 'No Data',
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ],
    );
  }

  // notify 데이터를 가져오는 메서드
  String _getNotifyValue(BaseSensorService service) {
    if (service.notifyCharacteristic == null ||
        service.notifyDatas[service.notifyCharacteristic!.uuid.toString()] ==
            null) {
      return 'No Data';
    }
    List<int> value =
        service.notifyDatas[service.notifyCharacteristic!.uuid.toString()]!;
    return value.isNotEmpty
        ? value.map((e) => e.toString()).join(", ")
        : 'No Data';
  }
}
