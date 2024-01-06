// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/view/settings_view.dart'
    as _i10;
import 'package:sorun_bildirim_uygulamasi/app/views/authentication/bloc/view/authentication_view.dart'
    as _i3;
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/home_view.dart'
    as _i5;
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/widgets/add_problem.dart'
    as _i2;
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/widgets/add_problem_location.dart'
    as _i1;
import 'package:sorun_bildirim_uygulamasi/app/views/login/view/login_view.dart'
    as _i6;
import 'package:sorun_bildirim_uygulamasi/app/views/main_screen.dart' as _i7;
import 'package:sorun_bildirim_uygulamasi/app/views/profile/view/profile_view.dart'
    as _i8;
import 'package:sorun_bildirim_uygulamasi/app/views/profile/view/widgets/update_current_loc.dart'
    as _i11;
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/register_view.dart'
    as _i9;
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/widgets/get_current_location.dart'
    as _i4;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    AddProblemLocationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddProblemLocationView(),
      );
    },
    AddProblemRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AddProblemView(),
      );
    },
    AuthenticationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AuthenticationView(),
      );
    },
    GetCurrentLocationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.GetCurrentLocationView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginView(),
      );
    },
    MainRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MainView(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ProfileView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.RegisterView(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SettingsView(),
      );
    },
    UpdateCurrentLocationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.UpdateCurrentLocationView(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddProblemLocationView]
class AddProblemLocationRoute extends _i12.PageRouteInfo<void> {
  const AddProblemLocationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AddProblemLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddProblemLocationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddProblemView]
class AddProblemRoute extends _i12.PageRouteInfo<void> {
  const AddProblemRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AddProblemRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddProblemRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AuthenticationView]
class AuthenticationRoute extends _i12.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.GetCurrentLocationView]
class GetCurrentLocationRoute extends _i12.PageRouteInfo<void> {
  const GetCurrentLocationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          GetCurrentLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetCurrentLocationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeView]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginView]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MainView]
class MainRoute extends _i12.PageRouteInfo<void> {
  const MainRoute({List<_i12.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ProfileView]
class ProfileRoute extends _i12.PageRouteInfo<void> {
  const ProfileRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.RegisterView]
class RegisterRoute extends _i12.PageRouteInfo<void> {
  const RegisterRoute({List<_i12.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SettingsView]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.UpdateCurrentLocationView]
class UpdateCurrentLocationRoute extends _i12.PageRouteInfo<void> {
  const UpdateCurrentLocationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          UpdateCurrentLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateCurrentLocationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}
