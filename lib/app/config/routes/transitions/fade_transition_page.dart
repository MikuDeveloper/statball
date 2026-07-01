import 'package:flutter/material.dart';

class FadeTransitionPage<T> extends Page<T> {
  final Widget child;

  const FadeTransitionPage({required this.child});

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, _) => child,
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
