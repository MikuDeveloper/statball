import 'dart:math' as math;

import 'package:flutter/material.dart';

// ─── Painter: líneas geométricas diagonales ───────────────────────────────
class GeometricPainter extends CustomPainter {
  final Animation<double> animation;
  GeometricPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00E5A0).withValues(alpha: 0.06)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final t = animation.value;

    // Líneas diagonales animadas
    for (int i = 0; i < 5; i++) {
      final offset =
          (t * size.width * 0.3 + i * size.width * 0.22) % (size.width * 1.2);
      canvas.drawLine(
        Offset(offset - size.width * 0.3, 0),
        Offset(offset + size.height * 0.6, size.height),
        paint,
      );
    }

    // Arco superior decorativo
    final arcPaint = Paint()
      ..color = const Color(0xFF7B2FFF).withValues(alpha: 0.15)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.42),
        width: size.width * 0.65,
        height: size.width * 0.65,
      ),
      math.pi * (0.8 + t * 0.1),
      math.pi * 1.4,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(GeometricPainter old) => true;
}
