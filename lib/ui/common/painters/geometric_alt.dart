// ─── Painter: fondo con líneas y arco ────────────────────────────────────
import 'dart:math' as math;

import 'package:flutter/material.dart';

class GeometricAlt extends CustomPainter {
  final Animation<double> animation;
  GeometricAlt({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;

    // Líneas diagonales sutiles
    final linePaint = Paint()
      ..color = const Color(0xFF7B2FFF).withValues(alpha: 0.1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 4; i++) {
      final offset =
          (t * size.width * 0.25 + i * size.width * 0.28) % (size.width * 1.1);
      canvas.drawLine(
        Offset(offset - size.width * 0.25, 0),
        Offset(offset + size.height * 0.5, size.height),
        linePaint,
      );
    }

    // Arco decorativo inferior
    final arcPaint = Paint()
      ..color = const Color(0xFF00E5A0).withValues(alpha: 0.1)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.9),
        width: size.width * 0.7,
        height: size.width * 0.7,
      ),
      math.pi * (1.1 + t * 0.08),
      math.pi * 1.5,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(GeometricAlt old) => true;
}
