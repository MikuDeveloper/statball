import 'package:flutter/material.dart';

import 'package:statball/app/global/constants.dart' show defaultPadding;

import 'widgets/features_section.dart';
import 'widgets/start_button.dart';
import 'widgets/statball_banner.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(defaultPadding * 1.5),
            child: Stack(
              alignment: .center,
              children: [
                Align(alignment: .topLeft, child: StatballBanner()),
                Align(
                  alignment: .bottomCenter,
                  child: Column(
                    spacing: defaultPadding * 2,
                    mainAxisSize: .min,
                    children: [FeaturesSection(), StartButton()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
