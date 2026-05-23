import 'package:flutter/material.dart' show Offset;

enum SlideFrom { top, right, bottom, left }

extension SlideFromDirection on SlideFrom {
  Offset get offset {
    switch (this) {
      case .top:
        return const Offset(0, -1);
      case .right:
        return const Offset(1, 0);
      case .bottom:
        return const Offset(0, 1);
      case .left:
        return const Offset(-1, 0);
    }
  }
}

enum DataStatus { initial, loading, success, error }
