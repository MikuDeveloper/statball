import 'dart:math' as math;

import 'package:flutter/material.dart';

// ─── Painter: hexágono tenue de fondo ─────────────────────────────────────
class HexPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - math.pi / 6;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);

    // Hexágono interior
    final paint2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.015)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final path2 = Path();
    final r2 = r * 0.65;
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - math.pi / 6;
      final x = cx + r2 * math.cos(angle);
      final y = cy + r2 * math.sin(angle);
      i == 0 ? path2.moveTo(x, y) : path2.lineTo(x, y);
    }
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(HexPainter old) => false;
}
