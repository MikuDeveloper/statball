// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $rootRoute,
  $loginRoute,
  $forgotPasswordRoute,
  $homeRoute,
  $schoolsRoute,
  $schoolPrincipalsRoute,
  $teamsRoute,
];

RouteBase get $rootRoute =>
    GoRouteData.$route(path: '/', name: 'root', factory: $RootRoute._fromState);

mixin $RootRoute on GoRouteData {
  static RootRoute _fromState(GoRouterState state) => const RootRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/login',
  name: 'login',
  factory: $LoginRoute._fromState,
  routes: [
    RelativeGoRouteData.$route(
      path: 'forgot-password',
      factory: $ForgotPasswordRoute._fromState,
    ),
  ],
);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ForgotPasswordRoute on RelativeGoRouteData {
  static ForgotPasswordRoute _fromState(GoRouterState state) =>
      const ForgotPasswordRoute();

  @override
  String get subLocation => RelativeGoRouteData.$location('forgot-password');

  @override
  String get relativeLocation => './$subLocation';

  @override
  void goRelative(BuildContext context) => context.go(relativeLocation);

  @override
  Future<T?> pushRelative<T>(BuildContext context) =>
      context.push<T>(relativeLocation);

  @override
  void pushReplacementRelative(BuildContext context) =>
      context.pushReplacement(relativeLocation);

  @override
  void replaceRelative(BuildContext context) =>
      context.replace(relativeLocation);
}

RouteBase get $forgotPasswordRoute => RelativeGoRouteData.$route(
  path: 'forgot-password',
  factory: $ForgotPasswordRoute._fromState,
);

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/home',
  name: 'home',
  factory: $HomeRoute._fromState,
);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $schoolsRoute => GoRouteData.$route(
  path: '/schools',
  name: 'schools',
  factory: $SchoolsRoute._fromState,
  routes: [
    RelativeGoRouteData.$route(
      path: 'form',
      factory: $SchoolFormRoute._fromState,
    ),
  ],
);

mixin $SchoolsRoute on GoRouteData {
  static SchoolsRoute _fromState(GoRouterState state) => const SchoolsRoute();

  @override
  String get location => GoRouteData.$location('/schools');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SchoolFormRoute on RelativeGoRouteData {
  static SchoolFormRoute _fromState(GoRouterState state) => SchoolFormRoute(
    id: _$convertMapValue('id', state.uri.queryParameters, int.tryParse),
  );

  SchoolFormRoute get _self => this as SchoolFormRoute;

  @override
  String get subLocation => RelativeGoRouteData.$location(
    'form',
    queryParams: {if (_self.id != null) 'id': _self.id!.toString()},
  );

  @override
  String get relativeLocation => './$subLocation';

  @override
  void goRelative(BuildContext context) => context.go(relativeLocation);

  @override
  Future<T?> pushRelative<T>(BuildContext context) =>
      context.push<T>(relativeLocation);

  @override
  void pushReplacementRelative(BuildContext context) =>
      context.pushReplacement(relativeLocation);

  @override
  void replaceRelative(BuildContext context) =>
      context.replace(relativeLocation);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

RouteBase get $schoolPrincipalsRoute => GoRouteData.$route(
  path: '/school-principals',
  name: 'school_principals',
  factory: $SchoolPrincipalsRoute._fromState,
  routes: [
    RelativeGoRouteData.$route(
      path: 'form',
      factory: $SchoolPrincipalFormRoute._fromState,
    ),
  ],
);

mixin $SchoolPrincipalsRoute on GoRouteData {
  static SchoolPrincipalsRoute _fromState(GoRouterState state) =>
      const SchoolPrincipalsRoute();

  @override
  String get location => GoRouteData.$location('/school-principals');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SchoolPrincipalFormRoute on RelativeGoRouteData {
  static SchoolPrincipalFormRoute _fromState(GoRouterState state) =>
      SchoolPrincipalFormRoute(
        id: _$convertMapValue('id', state.uri.queryParameters, int.tryParse),
      );

  SchoolPrincipalFormRoute get _self => this as SchoolPrincipalFormRoute;

  @override
  String get subLocation => RelativeGoRouteData.$location(
    'form',
    queryParams: {if (_self.id != null) 'id': _self.id!.toString()},
  );

  @override
  String get relativeLocation => './$subLocation';

  @override
  void goRelative(BuildContext context) => context.go(relativeLocation);

  @override
  Future<T?> pushRelative<T>(BuildContext context) =>
      context.push<T>(relativeLocation);

  @override
  void pushReplacementRelative(BuildContext context) =>
      context.pushReplacement(relativeLocation);

  @override
  void replaceRelative(BuildContext context) =>
      context.replace(relativeLocation);
}

RouteBase get $teamsRoute => GoRouteData.$route(
  path: '/teams',
  name: 'teams',
  factory: $TeamsRoute._fromState,
  routes: [
    RelativeGoRouteData.$route(
      path: 'form',
      factory: $TeamFormRoute._fromState,
    ),
  ],
);

mixin $TeamsRoute on GoRouteData {
  static TeamsRoute _fromState(GoRouterState state) => TeamsRoute(
    schoolFilter: _$convertMapValue(
      'school-filter',
      state.uri.queryParameters,
      int.tryParse,
    ),
  );

  TeamsRoute get _self => this as TeamsRoute;

  @override
  String get location => GoRouteData.$location(
    '/teams',
    queryParams: {
      if (_self.schoolFilter != null)
        'school-filter': _self.schoolFilter!.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TeamFormRoute on RelativeGoRouteData {
  static TeamFormRoute _fromState(GoRouterState state) => TeamFormRoute(
    id: state.uri.queryParameters['id'],
    schoolId: _$convertMapValue(
      'school-id',
      state.uri.queryParameters,
      int.tryParse,
    ),
  );

  TeamFormRoute get _self => this as TeamFormRoute;

  @override
  String get subLocation => RelativeGoRouteData.$location(
    'form',
    queryParams: {
      if (_self.id != null) 'id': _self.id,
      if (_self.schoolId != null) 'school-id': _self.schoolId!.toString(),
    },
  );

  @override
  String get relativeLocation => './$subLocation';

  @override
  void goRelative(BuildContext context) => context.go(relativeLocation);

  @override
  Future<T?> pushRelative<T>(BuildContext context) =>
      context.push<T>(relativeLocation);

  @override
  void pushReplacementRelative(BuildContext context) =>
      context.pushReplacement(relativeLocation);

  @override
  void replaceRelative(BuildContext context) =>
      context.replace(relativeLocation);
}
