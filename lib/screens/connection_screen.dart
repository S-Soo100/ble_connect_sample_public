import 'package:flutter/material.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('연결 페이지'), backgroundColor: Colors.purple[100]),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(child: newMethod()),
              Expanded(child: newMethod()),
              Expanded(child: newMethod()),
            ],
          ),
        ),
      ),
    );
  }

  Widget newMethod() {
    return GestureDetector(
      onTap: () => print("hey"),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.green[50]),
        child: Text("hey"),
      ),
    );
  }
}
