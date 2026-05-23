import 'package:go_router/go_router.dart';

import 'routes.dart';

final routerConfig = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: $appRoutes,
  redirect: (context, state) {
    return null;
  },
);
