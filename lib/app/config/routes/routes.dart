import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:statball/ui/screens/index.dart';

part 'routes.g.dart';

@TypedGoRoute<RootRoute>(path: '/', name: 'root')
class RootRoute extends GoRouteData with $RootRoute {
  const RootRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const RootScreen();
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
  name: 'login',
  routes: <TypedRelativeGoRoute<RelativeGoRouteData>>[
    TypedRelativeGoRoute<ForgotPasswordRoute>(path: 'forgot-password'),
  ],
)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

@TypedRelativeGoRoute<ForgotPasswordRoute>(path: 'forgot-password')
class ForgotPasswordRoute extends RelativeGoRouteData
    with $ForgotPasswordRoute {
  const ForgotPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgotPasswordScreen();
}
