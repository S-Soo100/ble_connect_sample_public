import 'dart:math';
import 'package:ble_connect_sample_public/services/arm_band_service_right.dart';
import 'package:ble_connect_sample_public/services/base_sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RightArmIndicatorWidget extends StatelessWidget {
  const RightArmIndicatorWidget({
    super.key,
    required this.service,
    required this.side,
  });
  final String side;
  final BaseSensorService service;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _upperArmR(),
        _lowerArmR(context),
      ],
    );
  }

  SizedBox _lowerArmR(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 100,
      child: Transform.rotate(
        angle: calculateRightAngleInRadians(
            int.parse(service.notifyValue), context),
        alignment: Alignment.topCenter,
        child: Container(
          width: 20,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey)),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _upperArmR() {
    return SizedBox(
      width: 20,
      height: 100,
      child: Transform.rotate(
        angle: -0.1 * pi,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 20,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey)),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double calculateRightAngle(int x, BuildContext context) {
  if (context.watch<ArmBandServiceRight>().maxValueNum <= 0) return 0;
  double angle =
      (0.1 * (x - context.watch<ArmBandServiceRight>().maxValueNum) - 20) * 1.1;

  // if (angle - 180 < 0) return 180;
  return angle;
}

double calculateRightAngleInRadians(int x, BuildContext context) {
  double degrees = calculateRightAngle(x, context);
  return degrees * (3.14159265359 / 180); // 각도를 radian으로 변환
}
