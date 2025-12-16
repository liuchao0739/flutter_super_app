import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../modules/common/splash_page.dart';
import '../../modules/common/login_page.dart';
import '../../modules/superapp/super_home_page.dart';
import '../../modules/common/settings_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: SuperHomePage, path: '/super-home'),
    AutoRoute(page: SettingsPage),
  ],
)
class AppRouter extends _$AppRouter {}
