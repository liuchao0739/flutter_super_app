import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../modules/splash/splash_page.dart';
import '../modules/auth/login_page.dart';
import '../modules/home/home_page.dart';
import '../modules/settings/settings_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: HomePage),
    AutoRoute(page: SettingsPage),
  ],
)
class AppRouter extends _$AppRouter {}
