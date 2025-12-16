import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 设备 & 应用信息 Service，统一封装获取逻辑，方便在设置页等位置展示。
class DeviceInfoService {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<Map<String, String>> getAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    return {
      '应用名称': info.appName,
      '包名': info.packageName,
      '版本': info.version,
      '构建号': info.buildNumber,
    };
  }

  static Future<Map<String, String>> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final android = await _deviceInfoPlugin.androidInfo;
      return {
        '系统': 'Android ${android.version.release}',
        '设备': android.model ?? '',
        '品牌': android.brand ?? '',
        'Android ID': android.id ?? '',
      };
    } else if (Platform.isIOS) {
      final ios = await _deviceInfoPlugin.iosInfo;
      return {
        '系统': '${ios.systemName} ${ios.systemVersion}',
        '设备': ios.utsname.machine ?? '',
        '名称': ios.name ?? '',
        'UUID': ios.identifierForVendor ?? '',
      };
    } else {
      final base = await _deviceInfoPlugin.deviceInfo;
      return {
        '系统': base.data['systemName']?.toString() ?? 'Unknown',
        '设备': base.data['model']?.toString() ?? '',
      };
    }
  }
}


