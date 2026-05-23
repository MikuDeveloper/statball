import 'package:flutter/material.dart';

import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/ui/common/animations/rotating.dart';
import 'package:statball/ui/common/figures/glow_circle.dart';
import 'package:statball/ui/common/painters/geometric.dart';
import 'package:statball/ui/common/painters/hex.dart';

import 'widgets/root_content.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final diameter = orientation == .landscape ? size.width : size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -size.width * 0.25,
            left: -size.height * 0.18,
            child: GlowCircle(
              diameter: diameter * 0.9,
              color: AppColors.accentAlt,
            ),
          ),
          Positioned(
            bottom: -size.height * 0.12,
            right: -size.width * 0.2,
            child: GlowCircle(
              diameter: diameter * 0.9,
              color: AppColors.accent,
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: GeometricPainter(animation: _bgController),
            ),
          ),
          Center(
            child: RotatingAnimation(
              child: CustomPaint(
                size: Size(diameter * 0.5, diameter * 0.5),
                painter: HexPainter(),
              ),
            ),
          ),
          //HexFigure(controller: _bgController),
          SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: defaultPadding * 4,
                vertical: defaultPadding * 6,
              ),
              child: const RootContent(),
            ),
          ),
        ],
      ),
    );
  }
}
