import 'package:ble_connect_sample_public/screens/components/body_model_indicator_widget.dart';
import 'package:ble_connect_sample_public/screens/components/display_tab_component.dart';
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

class _DataDisplayScreenState extends State<DataDisplayScreen>
    with TickerProviderStateMixin {
  int leftCalibrateState = 0;
  int rightCalibrateState = 0;
  int inspectState = 0;
  bool leftCalibration = false;
  bool rightCalibration = false;
  bool leftCalibrating = false;
  bool rightCalibrating = false;

  DisplayTapComponent tabs = DisplayTapComponent();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextTab() {
    if (_tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  void _startCounting(BuildContext context) {
    Provider.of<ArmBandServiceLeft>(context, listen: false).setCounting(true);
    Provider.of<ArmBandServiceRight>(context, listen: false).setCounting(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터 검증 페이지'),
        backgroundColor: Colors.purple[200],
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.tabHeads,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _firstTabPage(context), // min max 측정
          _secondPage(context), // 좌/우 판정
          _thirdPage(context), // 좌/우 판정
        ],
      ),
    );
  }

  Widget _firstTabPage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.watch<ArmBandServiceLeft>().isCalibrated
              ? SizedBox(
                  width: 200,
                  height: 240,
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green[600],
                        size: 160,
                      ),
                      GestureDetector(
                        onTap: () {
                          _nextTab();
                        },
                        child: Container(
                          width: 180,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: const Text(
                            "다음으로 >",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          context.watch<ArmBandServiceLeft>().isCalibrating
              ? const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(),
                )
              : const SizedBox(),
          context.watch<ArmBandServiceLeft>().isCalibrated
              ? const SizedBox(
                  child: Text("Left Calibration Completed"),
                )
              : SizedBox(
                  child: Text(
                    context.watch<ArmBandServiceLeft>().isCalibrating
                        ? "Calibrating..."
                        : "아래 버튼을 눌러서\n가동범위 측정을 시작해주세요.",
                    style: const TextStyle(color: Colors.red, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
          ElevatedButton(
            onPressed: () {
              Provider.of<ArmBandServiceLeft>(context, listen: false)
                  .startCalibrating();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  context.watch<ArmBandServiceLeft>().isCalibrated
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  color: context.watch<ArmBandServiceLeft>().isCalibrated
                      ? Colors.green
                      : Colors.red,
                ),
                Text(!context.watch<ArmBandServiceLeft>().isCalibrated
                    ? "측정 시작"
                    : "측정 완료"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _secondPage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.watch<ArmBandServiceRight>().isCalibrated
              ? SizedBox(
                  width: 200,
                  height: 240,
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green[600],
                        size: 160,
                      ),
                      GestureDetector(
                        onTap: () {
                          _nextTab();
                          _startCounting(context);
                        },
                        child: Container(
                          width: 180,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: const Text(
                            "다음으로 >",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          context.watch<ArmBandServiceRight>().isCalibrating
              ? const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(),
                )
              : const SizedBox(),
          context.watch<ArmBandServiceRight>().isCalibrated
              ? const SizedBox(
                  child: Text("Right Calibration Completed"),
                )
              : SizedBox(
                  child: Text(
                    context.watch<ArmBandServiceRight>().isCalibrating
                        ? "Calibrating..."
                        : "아래 버튼을 눌러서\n가동범위 측정을 시작해주세요.",
                    style: const TextStyle(color: Colors.red, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
          ElevatedButton(
            onPressed: () {
              Provider.of<ArmBandServiceRight>(context, listen: false)
                  .startCalibrating();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  context.watch<ArmBandServiceRight>().isCalibrated
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  color: context.watch<ArmBandServiceRight>().isCalibrated
                      ? Colors.green
                      : Colors.red,
                ),
                Text(!context.watch<ArmBandServiceRight>().isCalibrated
                    ? "측정 시작"
                    : "측정 완료"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _thirdPage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 80),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     width: 100,
          //     height: 100,
          //     color: Colors.green.withOpacity(0.7),
          //     child: Column(
          //       children: [
          //         Text(context
          //             .watch<ArmBandServiceLeft>()
          //             .countNotices
          //             .toString()),
          //         Text(context
          //             .watch<ArmBandServiceRight>()
          //             .countNotices
          //             .toString()),
          //         Text(context
          //             .watch<ArmBandServiceLeft>()
          //             .isCalibrated
          //             .toString()),
          //         Text(context
          //             .watch<ArmBandServiceRight>()
          //             .isCalibrated
          //             .toString()),
          //       ],
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              // ignore: prefer_const_constructors
              child: BodyIndicator(
                width: 100,
                height: 150,
                color: Colors.grey[300]!,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Center(
              child: SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _leftArm(context, context.watch<ArmBandServiceLeft>()),
                    _rightArm(context, context.watch<ArmBandServiceRight>()),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 160,
                      height: 240,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.watch<ArmBandServiceLeft>().countNotices
                                  ? "GOOD!"
                                  : "",
                              style: TextStyle(
                                  color: Colors.green[700]!,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.check_circle_sharp,
                              color: context
                                      .watch<ArmBandServiceLeft>()
                                      .countNotices
                                  ? Colors.green
                                  : Colors.transparent,
                              size: 100,
                            ),
                            Text(
                              "L: ${context.watch<ArmBandServiceLeft>().count}",
                              style: TextStyle(
                                  color: Colors.green[700]!,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Text("LEFT"),
                    Text(context.watch<ArmBandServiceLeft>().notifyValue == ""
                        ? "disconnected"
                        : "Crnt: ${context.watch<ArmBandServiceLeft>().notifyValue}"),
                    Text(context.watch<ArmBandServiceLeft>().notifyValue == ""
                        ? "-"
                        : "Max : ${context.watch<ArmBandServiceLeft>().maxValue}"),
                    Text(context.watch<ArmBandServiceLeft>().notifyValue == ""
                        ? "-"
                        : "Min : ${context.watch<ArmBandServiceLeft>().minValue}"),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 160,
                      height: 240,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.watch<ArmBandServiceRight>().countNotices
                                  ? "GOOD!"
                                  : "",
                              style: TextStyle(
                                  color: Colors.green[700]!,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.check_circle_sharp,
                              color: context
                                      .watch<ArmBandServiceRight>()
                                      .countNotices
                                  ? Colors.green
                                  : Colors.transparent,
                              size: 100,
                            ),
                            Text(
                              "R: ${context.watch<ArmBandServiceRight>().count}",
                              style: TextStyle(
                                  color: Colors.green[700]!,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Text("RIGHT"),
                    Text(context.watch<ArmBandServiceRight>().notifyValue == ""
                        ? "disconnected"
                        : "Crnt: ${context.watch<ArmBandServiceRight>().notifyValue}"),
                    Text(context.watch<ArmBandServiceRight>().notifyValue == ""
                        ? "-"
                        : "Max : ${context.watch<ArmBandServiceRight>().maxValue}"),
                    Text(context.watch<ArmBandServiceRight>().notifyValue == ""
                        ? "-"
                        : "Min : ${context.watch<ArmBandServiceRight>().minValue}"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _leftArm(BuildContext context, BaseSensorService service) {
    return Container(
      alignment: Alignment.topCenter,
      // width: MediaQuery.of(context).size.width / 2,
      width: 200,

      // height: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Column(
          children: [
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
      // width: MediaQuery.of(context).size.width / 2,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Column(
          children: [
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
