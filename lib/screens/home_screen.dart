import 'package:flutter/material.dart';
import 'connection_screen.dart';
import 'data_display_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('연결 판정 앱'), backgroundColor: Colors.purple[100]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('기기 연결'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ConnectionScreen())),
            ),
            ElevatedButton(
              child: const Text('데이터 표시'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const DataDisplayScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
