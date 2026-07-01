import 'package:flutter/animation.dart' show Offset;

enum SlideFrom { top, right, bottom, left }

extension SlideFromOffset on SlideFrom {
  Offset getOffset() => switch (this) {
    .top => const Offset(0, -1),
    .right => const Offset(1, 0),
    .bottom => const Offset(0, 1),
    .left => const Offset(-1, 0),
  };
}
