import 'package:flutter/material.dart';

class GlowCircle extends StatelessWidget {
  final double diameter;
  final Color color;
  const GlowCircle({super.key, required this.diameter, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.5), color.withValues(alpha: 0.0)],
        ),
      ),
    );
  }
}
