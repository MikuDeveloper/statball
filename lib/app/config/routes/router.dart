import 'package:go_router/go_router.dart';
import 'package:statball/app/providers/app_provider.dart';
import 'package:statball/app/providers/repositories/sb_user_use_case_provider.dart';

import 'routes.dart';

final routerConfig = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: $appRoutes,
  redirect: (context, state) {
    final urlPath = state.uri.path;
    final loginPath = const LoginRoute().location;
    final rootPath = const RootRoute().location;
    final resetPassPath = const ForgotPasswordRoute().relativeLocation;
    final homePath = const HomeRoute().location;

    final isLoggedIn = AppProvider.container
        .read(sbUserUseCaseProvider)
        .isLoggedIn();

    if (!isLoggedIn) {
      // Solo permitir root, login y reset-pass
      if (urlPath == rootPath ||
          urlPath == loginPath ||
          urlPath == resetPassPath) {
        return null; // se queda en esas rutas
      }
      return loginPath; // cualquier otra ruta lo manda a login
    }

    if (isLoggedIn) {
      // Si está logueado y entra a root, login o reset-pass → redirigir a home
      if (urlPath == rootPath ||
          urlPath == loginPath ||
          urlPath == resetPassPath) {
        return homePath;
      }
      return null; // cualquier otra ruta la puede navegar
    }

    return null;
  },
);
