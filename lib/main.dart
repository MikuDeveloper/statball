import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statball/app/providers/app_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'app/config/logger/logger.dart';

Future<void> main() async {
  setupLogging();
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
  );

  runApp(
    UncontrolledProviderScope(
      container: AppProvider.container,
      child: const StatballApp(),
    ),
  );
}
