import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'modules/crash/crash_service.dart';
import 'services/storage/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await CrashService.init();
  runApp(ProviderScope(child: MyApp()));
}
