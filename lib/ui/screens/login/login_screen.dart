import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';

import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/app/global/enums.dart';
import 'package:statball/ui/common/animations/fade_in.dart';
import 'package:statball/ui/common/figures/glow_circle.dart';
import 'package:statball/ui/common/painters/geometric_alt.dart';

import 'widgets/header.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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
      //extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   leading: SbBackIconButton(onTap: () => const RootRoute().go(context)),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   scrolledUnderElevation: 0,
      // ),
      body: Stack(
        children: [
          Positioned(
            top: -size.width * 0.25,
            right: -size.height * 0.18,
            child: GlowCircle(
              diameter: diameter * 0.9,
              color: AppColors.accent,
            ),
          ),

          Positioned(
            bottom: -size.height * 0.12,
            left: -size.width * 0.2,
            child: GlowCircle(
              diameter: diameter * 0.9,
              color: AppColors.accentAlt,
            ),
          ),

          Positioned.fill(
            child: CustomPaint(painter: GeometricAlt(animation: _bgController)),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  vertical: defaultPadding * 5,
                  horizontal: defaultPadding * 4,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      FadeInAnimation(
                        beginOffset: SlideFrom.left.offset,
                        child: const Header(),
                      ),
                      const SizedBox(height: 36),
                      FadeInAnimation(
                        beginOffset: SlideFrom.bottom.offset,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 700),
                          child: const LoginForm(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
