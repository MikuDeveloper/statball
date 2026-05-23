import 'dart:math' as math;
import 'package:flutter/material.dart';

class RotatingAnimation extends StatefulWidget {
  const RotatingAnimation({
    super.key,
    this.duration = const Duration(seconds: 30),
    required this.child,
  });

  final Duration duration;
  final Widget child;

  @override
  State<RotatingAnimation> createState() => _RotatingAnimationState();
}

class _RotatingAnimationState extends State<RotatingAnimation> {
  double _start = 0;
  double _end = 2 * math.pi;
  bool _forward = true;

  void _restart() {
    setState(() {
      if (_forward) {
        _start = _end;
        _end = 0; // vuelve hacia atrás
      } else {
        _start = _end;
        _end = 2 * math.pi; // vuelve hacia adelante
      }
      _forward = !_forward; // alterna dirección
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: _start, end: _end),
      duration: widget.duration,
      curve: Curves.easeInCirc,
      onEnd: _restart,
      builder: (context, angle, child) {
        return Transform.rotate(angle: angle, child: child);
      },
      child: widget.child,
    );
  }
}
