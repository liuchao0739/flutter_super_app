import 'package:flutter/foundation.dart';

/// CrashService
///
/// 统一的崩溃和错误收集服务，支持接入多种崩溃收集 SDK
class CrashService {
  static bool _initialized = false;
  static String? _userId;

  /// 初始化崩溃收集服务
  /// TODO(prod): 接入真实的崩溃收集服务（如 Firebase Crashlytics、Bugly 等）
  static Future<void> init() async {
    if (_initialized) return;

    if (kDebugMode) {
      debugPrint('CrashService initialized');
    }

    // TODO(prod): 初始化崩溃收集 SDK
    // 示例：Firebase Crashlytics
    // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    _initialized = true;
  }

  /// 记录错误
  /// TODO(prod): 上报到真实的崩溃收集服务
  static void logError(dynamic error, StackTrace? stackTrace) {
    if (kDebugMode) {
      debugPrint('Error: $error');
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }

    // TODO(prod): 上报错误到崩溃收集服务
    // 示例：Firebase Crashlytics
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  /// 记录致命错误
  static void logFatalError(dynamic error, StackTrace? stackTrace) {
    logError(error, stackTrace);
    // TODO(prod): 标记为致命错误
    // FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  }

  /// 设置用户 ID
  /// TODO(prod): 同步到崩溃收集服务
  static void setUserId(String userId) {
    _userId = userId;
    if (kDebugMode) {
      debugPrint('Set user ID: $userId');
    }

    // TODO(prod): 设置用户 ID 到崩溃收集服务
    // FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }

  /// 设置用户属性
  /// TODO(prod): 同步到崩溃收集服务
  static void setUserProperty(String key, String value) {
    if (kDebugMode) {
      debugPrint('Set user property: $key = $value');
    }

    // TODO(prod): 设置用户属性到崩溃收集服务
    // FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

  /// 记录自定义日志
  /// TODO(prod): 同步到崩溃收集服务
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('CrashService Log: $message');
    }

    // TODO(prod): 记录日志到崩溃收集服务
    // FirebaseCrashlytics.instance.log(message);
  }

  /// 手动触发测试崩溃（仅 Debug 模式）
  static void testCrash() {
    if (kDebugMode) {
      // TODO(prod): 触发测试崩溃
      // FirebaseCrashlytics.instance.crash();
      throw Exception('Test crash - 这是测试崩溃');
    }
  }

  /// 记录页面访问（PV）
  /// TODO(prod): 接入数据分析服务
  static void logPageView(String pageName, {Map<String, dynamic>? params}) {
    if (kDebugMode) {
      debugPrint('Page View: $pageName, params: $params');
    }

    // TODO(prod): 上报到数据分析服务
  }

  /// 记录用户行为事件
  /// TODO(prod): 接入数据分析服务
  static void logEvent(String eventName, {Map<String, dynamic>? params}) {
    if (kDebugMode) {
      debugPrint('Event: $eventName, params: $params');
    }

    // TODO(prod): 上报到数据分析服务
  }
}
