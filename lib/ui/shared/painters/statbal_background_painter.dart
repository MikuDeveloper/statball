import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:statball/app/config/theme/theme_colors.dart';

// Asegúrate de tener importada tu clase de colores
// import 'path/to/theme_colors.dart';

class StatBallBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ThemeColors
          .borderLight // Usamos el color de borde suave
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final accentPaint = Paint()
      ..color = ThemeColors
          .accent // El verde vibrante para resaltar
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final filledPaint = Paint()
      ..color = ThemeColors.borderLight.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height * 0.4);
    final radius = math.min(size.width, size.height) * 0.4;

    // --- Dibujar la estructura del balón ---
    canvas.drawCircle(center, radius, paint);
    _drawBallPanels(canvas, center, radius, paint);

    // --- Dibujar elementos de gráfica integrados ---

    // 1. Gráfica de barras central
    _drawBarChart(canvas, center, radius, filledPaint);

    // 2. Gráficas de líneas laterales
    _drawLineChart(
      canvas,
      Offset(center.dx - radius * 0.6, center.dy + radius * 0.3),
      radius * 0.4,
      paint,
    );
    _drawLineChart(
      canvas,
      Offset(center.dx + radius * 0.6, center.dy + radius * 0.3),
      radius * 0.4,
      paint,
    );

    // 3. Línea de tendencia resaltada (Accent)
    _drawTrendLine(canvas, center, radius, accentPaint);
  }

  void _drawBallPanels(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    // Implementación simplificada de los paneles del balón
    // Se dibujan líneas curvas que simulan la costura
    final path = Path();
    for (int i = 0; i < 5; i++) {
      double angle = i * (2 * math.pi / 5);
      path.moveTo(center.dx, center.dy);
      path.quadraticBezierTo(
        center.dx + radius * math.cos(angle + math.pi / 5) * 0.5,
        center.dy + radius * math.sin(angle + math.pi / 5) * 0.5,
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
    }
    canvas.drawPath(path, paint);
  }

  void _drawBarChart(Canvas canvas, Offset center, double radius, Paint paint) {
    // Dibujar barras grises en el centro
    final barWidth = radius * 0.1;
    final maxBarHeight = radius * 0.5;
    final bars = [0.4, 0.7, 0.5, 0.9, 0.6];

    for (int i = 0; i < bars.length; i++) {
      final barHeight = maxBarHeight * bars[i];
      final rect = Rect.fromLTWH(
        center.dx - (bars.length * barWidth / 2) + (i * barWidth),
        center.dy + radius * 0.1 - barHeight,
        barWidth * 0.8,
        barHeight,
      );
      canvas.drawRect(rect, paint);
    }
  }

  void _drawLineChart(Canvas canvas, Offset origin, double size, Paint paint) {
    // Dibujar pequeñas gráficas de líneas en los paneles laterales
    final path = Path();
    path.moveTo(origin.dx, origin.dy);
    path.lineTo(origin.dx + size * 0.2, origin.dy - size * 0.3);
    path.lineTo(origin.dx + size * 0.4, origin.dy - size * 0.1);
    path.lineTo(origin.dx + size * 0.6, origin.dy - size * 0.5);
    path.lineTo(origin.dx + size * 0.8, origin.dy - size * 0.2);
    canvas.drawPath(path, paint);
  }

  void _drawTrendLine(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    // Dibujar la línea verde prominente que sube
    final path = Path();
    path.moveTo(center.dx - radius * 0.8, center.dy + radius * 0.2);
    path.quadraticBezierTo(
      center.dx,
      center.dy - radius * 0.2,
      center.dx + radius * 0.8,
      center.dy - radius * 0.8,
    );
    canvas.drawPath(path, paint);

    // Dibujar la flecha al final
    canvas.drawCircle(
      Offset(center.dx + radius * 0.8, center.dy - radius * 0.8),
      4,
      paint..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
