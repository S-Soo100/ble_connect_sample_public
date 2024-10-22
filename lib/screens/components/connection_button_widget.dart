import 'package:flutter/material.dart';
import 'package:ble_connect_sample_public/services/base_sensor_service.dart';

class ConnectionButtonWidget extends StatelessWidget {
  const ConnectionButtonWidget({
    super.key,
    required this.context,
    required this.title,
    required this.service,
  });

  final BuildContext context;
  final String title;
  final BaseSensorService service;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          // color: Colors.amberAccent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[700]!, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          service.connectedDevice != null
              ? SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (!service.isReading) {
                              service.sendData("6");
                            }
                          },
                          child: Text(!service.isReading
                              ? "Start Read"
                              : "Reading...")),
                      // ElevatedButton(
                      //     onPressed: () {}, child: Text("Connection End")),
                      Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.green[50]),
                          child: Column(
                            children: [
                              Text("Current : " + service.notifyValue),
                              Text("Max : " + service.maxValue),
                              Text("Min : " + service.minValue),
                            ],
                          )),
                    ],
                  ),
                )
              : _unConnected()
        ],
      ),
    );
  }

  SizedBox _unConnected() {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
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
            'Read Value: ${service.notifyValue}',
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

extension on BaseSensorService {
  void startRead() {}
}
