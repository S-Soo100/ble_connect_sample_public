import 'package:flutter/material.dart';

final class DisplayTapComponent {
  final int length = 3;
  final List<Widget> tabHeads = [
    Expanded(
        child: Container(
      height: 42,
      alignment: Alignment.center,
      child: const Text(
        "Cal Left",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    )),
    Expanded(
        child: Container(
      height: 42,
      alignment: Alignment.center,
      child: const Text(
        "Cal Right",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    )),
    Expanded(
        child: Container(
      height: 42,
      alignment: Alignment.center,
      child: const Text(
        "L/R Inspect",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    )),
  ];
}
