import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poltry_farm/screens/auth/login_screen.dart';
import 'package:poltry_farm/screens/home/home_screen.dart';
import 'package:poltry_farm/screens/home/home_sell_screen.dart';
import 'package:poltry_farm/screens/home/home_today_rate_screen.dart';
import 'package:poltry_farm/screens/settings/personal_info_screen.dart';
import 'package:poltry_farm/screens/settings/setting_screen.dart';
import 'package:poltry_farm/screens/settings/view_ad_screen.dart';
import 'package:poltry_farm/widgets/scaffold.dart';

class PfRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    observers: [NavigatorObserver()],
    debugLogDiagnostics: kDebugMode,
    initialLocation: PfPaths.login.path,
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithBottomNav(child: child),
        routes: [
          GoRoute(
            name: PfPaths.home.name,
            path: PfPaths.home.path,
            builder: (context, state) => const PfHomeScreen(),
          ),
          GoRoute(
            name: PfPaths.setting.name,
            path: PfPaths.setting.path,
            builder: (context, state) => const PfSettingScreen(),
          ),
        ],
      ),
      GoRoute(
        name: PfPaths.login.name,
        path: PfPaths.login.path,
        builder: (context, state) => const PfLoginScreen(),
      ),
      GoRoute(
        name: PfPaths.homeSell.name,
        path: PfPaths.homeSell.path,
        builder: (context, state) => const PfHomeSellScreen(),
      ),
      GoRoute(
        name: PfPaths.homeTodayRate.name,
        path: PfPaths.homeTodayRate.path,
        builder: (context, state) => const PfHomeTodayRateScreen(),
      ),
      GoRoute(
        name: PfPaths.viewAds.name,
        path: PfPaths.viewAds.path,
        builder: (context, state) => const PfMyAdsScreen(),
      ),
      GoRoute(
        name: PfPaths.personalInfo.name,
        path: PfPaths.personalInfo.path,
        builder: (context, state) => const PfPersonalInfoScreen(),
      ),
    ],
  );
}

enum PfPaths {
  home(
    name: 'home',
    path: '/home',
  ),
  login(
    name: 'login',
    path: '/login',
  ),
  setting(
    name: 'setting',
    path: '/setting',
  ),
  homeSell(
    name: 'homeSell',
    path: '/homeSell',
  ),
  homeTodayRate(
    name: 'homeTodayRate',
    path: '/homeTodayRate',
  ),
  viewAds(
    name: 'viewAds',
    path: '/viewAds',
  ),
  personalInfo(
    name: 'personalInfo',
    path: '/personalInfo',
  );

  const PfPaths({
    required this.name,
    required this.path,
  });

  /// Represents the route name
  ///
  /// Example: `AppRoutes.splash.name`
  /// Returns: 'splash'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.splash.path`
  /// Returns: '/splash'
  final String path;

  @override
  String toString() => name;
}
