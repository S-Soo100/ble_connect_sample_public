import 'package:flutter/material.dart';

// 뒤집어진 사다리꼴을 그리는 커스텀 페인터
class BodyModelPaintor extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;

  BodyModelPaintor({
    this.fillColor = Colors.blue,
    this.borderColor = Colors.grey,
    this.borderWidth = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final path = Path();

    // 사다리꼴의 각 점 정의
    // 위쪽 긴 변
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    // 오른쪽 빗변
    path.lineTo(size.width * 0.8, size.height);

    // 아래쪽 짧은 변
    path.lineTo(size.width * 0.2, size.height);

    // 왼쪽 빗변 및 닫기
    path.close();

    canvas.drawPath(path, paint);

    // 테두리 그리기
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// 사용 예시를 위한 위젯
class BodyIndicator extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const BodyIndicator({
    super.key,
    this.width = 200,
    this.height = 100,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BodyModelPaintor(fillColor: color),
      size: Size(width, height),
    );
  }
}
