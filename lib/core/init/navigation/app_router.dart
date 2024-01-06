import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        //AutoRoute(page: AuthenticationRoute.page),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(page: GetCurrentLocationRoute.page),
        AutoRoute(page: AddProblemRoute.page),
        AutoRoute(page: UpdateCurrentLocationRoute.page),
        AutoRoute(page: AddProblemLocationRoute.page),
        AutoRoute(page: MainRoute.page, initial: true, children: [
          AutoRoute(
            page: HomeRoute.page,
          ),
          AutoRoute(page: ProfileRoute.page),
          AutoRoute(page: SettingsRoute.page),
        ]),
      ];
}
