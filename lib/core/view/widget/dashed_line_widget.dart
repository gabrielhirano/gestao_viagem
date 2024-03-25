import 'package:flutter/material.dart';

class DashedLineWidget extends StatelessWidget {
  final double height;
  final Color color;
  final double strokeWidth;
  final double gap;

  const DashedLineWidget({
    super.key,
    required this.height,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromHeight(height),
      painter: _DashedLinePainter(color, strokeWidth, gap),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedLinePainter(this.color, this.strokeWidth, this.gap);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    final double dashSpace = gap;
    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
