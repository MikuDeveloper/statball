import 'package:routemaster/routemaster.dart';

import 'routes.dart';

final routemaster = RoutemasterDelegate(
  routesBuilder: (context) => loggedOutRouteMap,
);
