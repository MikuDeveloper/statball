import 'package:flutter/material.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/global/constants.dart' show defaultPadding;
import 'package:statball/ui/common/animations/rotating.dart';
import 'package:statball/ui/common/figures/glow_circle.dart';
import 'package:statball/ui/common/painters/hex.dart';

import 'widgets/header_section.dart';
import 'widgets/reset_view.dart';
import 'widgets/success_view.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _emailSent = false;
  String _sentToEmail = '';

  void _onEmailSent(String email) {
    setState(() {
      _emailSent = true;
      _sentToEmail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final diameter = orientation == .landscape ? size.width : size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            top: -size.height * 0.14,
            left: -size.width * 0.20,
            child: GlowCircle(
              diameter: diameter * 0.9,
              color: AppColors.accentAlt.withValues(alpha: 0.30),
            ),
          ),

          Positioned(
            bottom: -size.height * 0.14,
            right: -size.width * 0.20,
            child: GlowCircle(
              diameter: diameter * 0.9,
              color: AppColors.accent.withValues(alpha: 0.30),
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
                    spacing: defaultPadding,
                    crossAxisAlignment: .start,
                    children: [
                      HeaderSection(email: _sentToEmail, emailSent: _emailSent),
                      const SizedBox(height: 32),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          transitionBuilder: (child, anim) =>
                              FadeTransition(opacity: anim, child: child),
                          child: _emailSent
                              ? const SuccessView(
                                  key: ValueKey('success'),
                                  email: 'correo@example.com',
                                )
                              : ResetView(
                                  key: const ValueKey('form'),
                                  onEmailSent: _onEmailSent,
                                ),
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
