import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:statball/app/providers/is_logged_cubit.dart';

import 'routes.dart';

final routemaster = RoutemasterDelegate(
  routesBuilder: (context) => context.watch<IsLoggedCubit>().state
      ? loggedInRouteMap
      : loggedOutRouteMap,
);
