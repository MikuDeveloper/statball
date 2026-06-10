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

@TypedGoRoute<HomeRoute>(path: '/home', name: 'home')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@TypedGoRoute<SchoolsRoute>(
  path: '/schools',
  name: 'schools',
  routes: <TypedRelativeGoRoute<RelativeGoRouteData>>[
    TypedRelativeGoRoute<SchoolFormRoute>(path: 'form'),
  ],
)
class SchoolsRoute extends GoRouteData with $SchoolsRoute {
  const SchoolsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SchoolsScreen();
}

class SchoolFormRoute extends RelativeGoRouteData with $SchoolFormRoute {
  const SchoolFormRoute({this.id});
  // Si llega `id` rendereamos modo edición; sin id es creación.
  final int? id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SchoolFormScreen(schoolId: id);
}

@TypedGoRoute<SchoolPrincipalsRoute>(
  path: '/school-principals',
  name: 'school_principals',
  routes: <TypedRelativeGoRoute<RelativeGoRouteData>>[
    TypedRelativeGoRoute<SchoolPrincipalFormRoute>(path: 'form'),
  ],
)
class SchoolPrincipalsRoute extends GoRouteData with $SchoolPrincipalsRoute {
  const SchoolPrincipalsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SchoolPrincipalsScreen();
}

class SchoolPrincipalFormRoute extends RelativeGoRouteData
    with $SchoolPrincipalFormRoute {
  const SchoolPrincipalFormRoute({this.id});
  final int? id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SchoolPrincipalFormScreen(principalId: id);
}

@TypedGoRoute<TeamsRoute>(
  path: '/teams',
  name: 'teams',
  routes: <TypedRelativeGoRoute<RelativeGoRouteData>>[
    TypedRelativeGoRoute<TeamFormRoute>(path: 'form'),
  ],
)
class TeamsRoute extends GoRouteData with $TeamsRoute {
  // schoolFilter opcional: filtra el listado por escuela al abrir.
  const TeamsRoute({this.schoolFilter});

  final int? schoolFilter;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TeamsScreen(schoolFilter: schoolFilter);
}

class TeamFormRoute extends RelativeGoRouteData with $TeamFormRoute {
  // `id` para edición; `schoolId` para pre-seleccionar escuela en creación.
  const TeamFormRoute({this.id, this.schoolId});

  final String? id;
  final int? schoolId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TeamFormScreen(teamId: id, presetSchoolId: schoolId);
}

@TypedGoRoute<PlayersRoute>(
  path: '/players',
  name: 'players',
  routes: <TypedRelativeGoRoute<RelativeGoRouteData>>[
    TypedRelativeGoRoute<PlayerFormRoute>(path: 'form'),
  ],
)
class PlayersRoute extends GoRouteData with $PlayersRoute {
  // teamFilter opcional: filtra el listado por equipo al abrir.
  const PlayersRoute({this.teamFilter});

  final String? teamFilter;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PlayersScreen(teamFilter: teamFilter);
}

class PlayerFormRoute extends RelativeGoRouteData with $PlayerFormRoute {
  // `id` para edición; `teamId` para pre-seleccionar equipo en creación.
  const PlayerFormRoute({this.id, this.teamId});

  final String? id;
  final String? teamId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PlayerFormScreen(playerId: id, presetTeamId: teamId);
}

@TypedGoRoute<ScoutsRoute>(
  path: '/scouts',
  name: 'scouts',
  routes: <TypedRelativeGoRoute<RelativeGoRouteData>>[
    TypedRelativeGoRoute<ScoutFormRoute>(path: 'form'),
  ],
)
class ScoutsRoute extends GoRouteData with $ScoutsRoute {
  const ScoutsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ScoutsScreen();
}

class ScoutFormRoute extends RelativeGoRouteData with $ScoutFormRoute {
  const ScoutFormRoute({this.id});

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ScoutFormScreen(scoutId: id);
}

@TypedGoRoute<MatchesRoute>(
  path: '/matches',
  name: 'matches',
  routes: <TypedRelativeGoRoute<RelativeGoRouteData>>[
    TypedRelativeGoRoute<GameMatchFormRoute>(path: 'form'),
  ],
)
class MatchesRoute extends GoRouteData with $MatchesRoute {
  const MatchesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MatchesScreen();
}

class GameMatchFormRoute extends RelativeGoRouteData with $GameMatchFormRoute {
  const GameMatchFormRoute({this.id});

  final int? id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      GameMatchFormScreen(matchId: id);
}

@TypedGoRoute<MyAssignmentsRoute>(
  path: '/my-assignments',
  name: 'my_assignments',
)
class MyAssignmentsRoute extends GoRouteData with $MyAssignmentsRoute {
  const MyAssignmentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MyAssignmentsScreen();
}

// ════════════════════════════════════════════════════════════════════════════
//  Extensiones push() para routes relativas
//
//  El codegen de go_router_builder solo genera `pushRelative()` para
//  RelativeGoRouteData (que requiere que el contexto sea descendiente del
//  padre). Estas extensiones exponen `push<T>()` resolviendo el path absoluto
//  compuesto (parent + sub + query params), lo cual permite navegar desde
//  cualquier punto de la app sin importar la jerarquía actual de rutas.
// ════════════════════════════════════════════════════════════════════════════

extension SchoolFormRoutePush on SchoolFormRoute {
  Future<T?> push<T>(BuildContext context) => context.push<T>(
    Uri(
      path: '/schools/form',
      queryParameters: {if (id != null) 'id': id!.toString()},
    ).toString(),
  );
}

extension SchoolPrincipalFormRoutePush on SchoolPrincipalFormRoute {
  Future<T?> push<T>(BuildContext context) => context.push<T>(
    Uri(
      path: '/school-principals/form',
      queryParameters: {if (id != null) 'id': id!.toString()},
    ).toString(),
  );
}

extension TeamFormRoutePush on TeamFormRoute {
  Future<T?> push<T>(BuildContext context) => context.push<T>(
    Uri(
      path: '/teams/form',
      queryParameters: {
        if (id != null) 'id': id!,
        if (schoolId != null) 'school-id': schoolId!.toString(),
      },
    ).toString(),
  );
}

extension PlayerFormRoutePush on PlayerFormRoute {
  Future<T?> push<T>(BuildContext context) => context.push<T>(
    Uri(
      path: '/players/form',
      queryParameters: {
        if (id != null) 'id': id!,
        if (teamId != null) 'team-id': teamId!,
      },
    ).toString(),
  );
}

extension ScoutFormRoutePush on ScoutFormRoute {
  Future<T?> push<T>(BuildContext context) => context.push<T>(
    Uri(
      path: '/scouts/form',
      queryParameters: {if (id != null) 'id': id!},
    ).toString(),
  );
}

extension GameMatchFormRoutePush on GameMatchFormRoute {
  Future<T?> push<T>(BuildContext context) => context.push<T>(
    Uri(
      path: '/matches/form',
      queryParameters: {if (id != null) 'id': id!.toString()},
    ).toString(),
  );
}
