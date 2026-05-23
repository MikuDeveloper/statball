import 'package:flutter/material.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/global/enums.dart'
    show SlideFrom, SlideFromDirection;
import 'package:statball/ui/common/animations/fade_in.dart';
import 'package:statball/ui/common/widgets/sb_chip.dart';

import 'app_banner.dart';
import 'start_button.dart';
import 'version_banner.dart';

class RootContent extends StatelessWidget {
  const RootContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        FadeInAnimation(
          beginOffset: SlideFrom.left.offset,
          duration: const Duration(milliseconds: 500),
          child: const VersionBanner(),
        ),
        const SizedBox(height: 28),
        FadeInAnimation(
          beginOffset: SlideFrom.left.offset,
          duration: const Duration(milliseconds: 600),
          child: const AppBanner(),
        ),
        const Spacer(),
        FadeInAnimation(
          beginOffset: SlideFrom.bottom.offset,
          child: const Row(
            children: [
              SbChip(label: 'jugadas', value: 'Captura'),
              SizedBox(width: 10),
              SbChip(label: 'jugadores', value: 'Clasifica'),
              SizedBox(width: 10),
              SbChip(label: 'desempeño', value: 'Evalua'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        FadeInAnimation(
          beginOffset: SlideFrom.bottom.offset,
          child: StartButton(onTap: () => const LoginRoute().go(context)),
        ),
      ],
    );
  }
}
