import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'package:statball/ui/index.dart';

import 'transitions/fade_transition_page.dart';
import 'transitions/slide_transition_page.dart';

final String rootPath = '/';
final String loginPath = '/login';
final String appPath = '/app';

final loggedOutRouteMap = RouteMap(
  routes: {
    rootPath: (route) => const MaterialPage<RootScreen>(child: RootScreen()),
    loginPath: (route) =>
        const FadeTransitionPage<LoginScreen>(child: LoginScreen()),
  },
);

final loggedInRouteMap = RouteMap(routes: {});
