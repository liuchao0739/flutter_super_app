import 'package:flutter/material.dart';

/// UI 相关通用方法封装
class UiUtils {
  /// 隐藏键盘
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode scope = FocusScope.of(context);
    if (!scope.hasPrimaryFocus && scope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// 获取屏幕宽度
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 获取屏幕高度
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}


