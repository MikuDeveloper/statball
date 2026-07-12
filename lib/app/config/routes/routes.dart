import 'package:routemaster/routemaster.dart';

import 'package:statball/ui/index.dart';

import 'transitions/fade_transition_page.dart';
import 'transitions/slide_transition_page.dart';

final String rootPath = '/';
final String loginPath = '/login';
final String appPath = '/app';
final String settingsPath = '/app/settings';

final loggedOutRouteMap = RouteMap(
  onUnknownRoute: (_) => Redirect(rootPath),
  routes: {
    rootPath: (route) =>
        const FadeTransitionPage<RootScreen>(child: RootScreen()),
    loginPath: (route) =>
        const FadeTransitionPage<LoginScreen>(child: LoginScreen()),
  },
);

final loggedInRouteMap = RouteMap(
  onUnknownRoute: (_) => Redirect(appPath),
  routes: {
    appPath: (route) =>
        const SlideTransitionPage<AppScreen>(child: AppScreen()),
    settingsPath: (route) =>
        const SlideTransitionPage<SettingsScreen>(child: SettingsScreen()),
  },
);
