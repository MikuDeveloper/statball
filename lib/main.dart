import 'package:flutter/foundation.dart'
    show kIsWeb, LicenseRegistry, LicenseEntryWithLineBreaks;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statball/app/providers/is_logged_cubit.dart';
import 'package:statball/app/providers/theme_mode_cubit.dart';

import 'app/app.dart';
import 'app/global/assets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    final String license = await rootBundle.loadString(
      '${Assets.interFontFolder}/OFL.txt',
    );
    yield LicenseEntryWithLineBreaks(<String>['google_fonts'], license);
  });
  final storage = kIsWeb
      ? HydratedStorageDirectory.web
      : HydratedStorageDirectory((await getApplicationSupportDirectory()).path);
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: storage);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeModeCubit()),
        BlocProvider(create: (context) => IsLoggedCubit()),
      ],
      child: const StatballApp(),
    ),
  );
}
