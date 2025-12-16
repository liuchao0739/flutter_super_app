import 'package:flutter/material.dart';

import '../../modules/common/settings_page.dart';
import '../../modules/mall/super_commerce_demo_page.dart';
import '../../modules/im/super_im_demo_page.dart';
import '../../modules/video/super_video_demo_page.dart';
import '../../modules/tools/super_tools_demo_page.dart';
import '../../modules/industry/super_industry_demo_page.dart';

/// NavigationService
///
/// 把所有 Demo 跳转集中到一个地方，页面层只调用语义化方法，便于后续统一改造为 Router。
class NavigationService {
  static Future<void> toSettings(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
  }

  // 超级应用平台 - 五大模块
  static Future<void> toSuperCommerce(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SuperCommerceDemoPage()),
    );
  }

  static Future<void> toSuperIm(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SuperImDemoPage()),
    );
  }

  static Future<void> toSuperVideo(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SuperVideoDemoPage()),
    );
  }

  static Future<void> toSuperTools(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SuperToolsDemoPage()),
    );
  }

  static Future<void> toSuperIndustry(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SuperIndustryDemoPage()),
    );
  }
}
