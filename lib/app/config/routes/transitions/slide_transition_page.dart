import 'package:flutter/material.dart';
import 'package:statball/app/global/enums.dart';

class SlideTransitionPage<T> extends Page<T> {
  final SlideFrom? slideFrom;
  final Widget child;

  const SlideTransitionPage({required this.child, this.slideFrom});

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, _) => child,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, _, child) {
        final begin = slideFrom == null
            ? SlideFrom.right.getOffset()
            : slideFrom?.getOffset();
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
