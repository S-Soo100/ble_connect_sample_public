import 'package:ble_connect_sample_public/screens/components/connection_button_widget.dart';
import 'package:ble_connect_sample_public/services/arm_band_service_left.dart';
import 'package:ble_connect_sample_public/services/arm_band_service_right.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArmBand Connection'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConnectionButtonWidget(
              context: context,
              title: 'Connect Left ArmBand',
              service: context.watch<ArmBandServiceLeft>()),
          ConnectionButtonWidget(
              context: context,
              title: 'Connect Right ArmBand',
              service: context.watch<ArmBandServiceRight>()),
        ],
      ),
    );
  }

  // 버튼을 공통 메서드로 구성
}
