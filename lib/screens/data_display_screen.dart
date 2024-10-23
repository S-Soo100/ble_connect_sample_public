import 'package:ble_connect_sample_public/screens/components/body_model_indicator_widget.dart';
import 'package:ble_connect_sample_public/screens/components/left_arm_indicator.dart';
import 'package:ble_connect_sample_public/screens/components/right_arm_indicator_widget.dart';
import 'package:ble_connect_sample_public/services/arm_band_service_left.dart';
import 'package:ble_connect_sample_public/services/arm_band_service_right.dart';
import 'package:ble_connect_sample_public/services/base_sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataDisplayScreen extends StatefulWidget {
  const DataDisplayScreen({super.key});

  @override
  State<DataDisplayScreen> createState() => _DataDisplayScreenState();
}

class _DataDisplayScreenState extends State<DataDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('데이터 표기 페이지'), backgroundColor: Colors.purple[100]),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 70),
                // ignore: prefer_const_constructors
                child: BodyIndicator(
                  width: 100,
                  height: 150,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  _leftArm(context, context.watch<ArmBandServiceLeft>()),
                  _rightArm(context, context.watch<ArmBandServiceRight>()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leftArm(BuildContext context, BaseSensorService service) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width / 2,

      // height: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Column(
          children: [
            Text(service.notifyValue == ""
                ? "disconnected"
                : "Crnt: ${service.notifyValue}"),
            Text(service.notifyValue == "" ? "-" : "Max : ${service.maxValue}"),
            Text(service.notifyValue == "" ? "-" : "Min : ${service.minValue}"),
            service.notifyValue == ""
                ? const SizedBox()
                : LeftArmIndicator(
                    side: "Left",
                    service: service,
                  )
          ],
        ),
      ),
    );
  }

  Widget _rightArm(BuildContext context, BaseSensorService service) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Column(
          children: [
            Text(service.notifyValue == ""
                ? "disconnected"
                : "Crnt: ${service.notifyValue}"),
            Text(service.notifyValue == "" ? "-" : "Max : ${service.maxValue}"),
            Text(service.notifyValue == "" ? "-" : "Min : ${service.minValue}"),
            service.notifyValue == ""
                ? const SizedBox()
                : RightArmIndicatorWidget(
                    side: "R",
                    service: service,
                  ),
          ],
        ),
      ),
    );
  }
}
