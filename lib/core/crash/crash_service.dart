import 'package:flutter/foundation.dart';

class CrashService {
  static Future<void> init() async {
    if (kDebugMode) {
      debugPrint('CrashService initialized');
    }
    // 这里可以集成实际的崩溃收集服务，如 Bugly、Firebase Crashlytics 等
  }

  static void logError(dynamic error, StackTrace? stackTrace) {
    if (kDebugMode) {
      debugPrint('Error: $error');
      debugPrint('StackTrace: $stackTrace');
    }
    // 上报错误到崩溃收集服务
  }

  static void setUserId(String userId) {
    if (kDebugMode) {
      debugPrint('Set user ID: $userId');
    }
    // 设置用户 ID
  }
}

