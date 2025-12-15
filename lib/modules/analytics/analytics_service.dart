import 'package:flutter/foundation.dart';

class AnalyticsService {
  static void logPageView(String pageName) {
    if (kDebugMode) {
      debugPrint('Page View: $pageName');
    }
    // 这里可以集成实际的统计服务，如 Firebase Analytics、友盟等
  }

  static void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    if (kDebugMode) {
      debugPrint('Event: $eventName, Parameters: $parameters');
    }
    // 上报事件
  }

  static void setUserProperty(String key, String value) {
    if (kDebugMode) {
      debugPrint('User Property: $key = $value');
    }
    // 设置用户属性
  }
}

