import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/'),
    AutoRoute(page: DashboardRoute.page, path: '/dashboard'),
    AutoRoute(page: EventRoute.page, path: '/event'),
    AutoRoute(page: ActionChooserRoute.page, path: '/action-chooser'),
    AutoRoute(page: JobChooserRoute.page, path: '/job-chooser'),
    AutoRoute(page: ResultsRoute.page, path: '/results'),
    AutoRoute(page: RecordsRoute.page, path: '/records'),
  ];
}