import 'dart:math';
import 'package:ble_connect_sample_public/services/arm_band_service_left.dart';
import 'package:ble_connect_sample_public/services/base_sensor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeftArmIndicator extends StatelessWidget {
  const LeftArmIndicator({
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
        _upperArm(),
        _lowerArm(context),
      ],
    );
  }

  SizedBox _lowerArm(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 100,
      child: Transform.rotate(
        angle: calculateLeftAngleInRadians(
            int.parse(service.notifyValue), context),
        // angle: 0,
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

  SizedBox _upperArm() {
    return SizedBox(
      width: 20,
      height: 100,
      child: Transform.rotate(
        angle: 0.1 * pi,
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

double calculateLeftAngle(int x, BuildContext context) {
  if (context.watch<ArmBandServiceLeft>().maxValueNum <= 0) return 0;
  double angle =
      (-0.1 * (x - context.watch<ArmBandServiceLeft>().maxValueNum) + 20) * 1.1;

  if (angle > 180) return 180;
  return angle;
}

double calculateLeftAngleInRadians(int x, BuildContext context) {
  double degrees = calculateLeftAngle(x, context);
  return degrees * (3.14159265359 / 180); // 각도를 radian으로 변환
}
