import 'package:ble_connect_sample_public/screens/components/connection_button_widget.dart';
import 'package:ble_connect_sample_public/screens/data_display_screen.dart';
import 'package:ble_connect_sample_public/services/arm_band_service_left.dart';
import 'package:ble_connect_sample_public/services/arm_band_service_right.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: const Text('ArmBand Connection'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          ConnectionButtonWidget(
              context: context,
              title: '👈  Connect Left ArmBand',
              service: context.watch<ArmBandServiceLeft>()),
          ConnectionButtonWidget(
              context: context,
              title: 'Connect Right ArmBand 👉',
              service: context.watch<ArmBandServiceRight>()),
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DataDisplayScreen()));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  width: 180,
                  height: 60,
                  alignment: AlignmentDirectional.center,
                  child: const Text(
                    "판정 시작하기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
