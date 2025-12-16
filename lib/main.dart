import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/storage/hive_service.dart';
import 'core/crash/crash_service.dart';
import 'config/theme.dart';
import 'core/state/theme_state.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化核心服务
  await HiveService.init();
  await CrashService.init();

  // 启动应用
  runApp(const ProviderScope(child: SuperApp()));
}

/// 超级应用主入口
class SuperApp extends ConsumerStatefulWidget {
  const SuperApp({Key? key}) : super(key: key);

  @override
  ConsumerState<SuperApp> createState() => _SuperAppState();
}

class _SuperAppState extends ConsumerState<SuperApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'SuperApp - 超级应用平台',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
