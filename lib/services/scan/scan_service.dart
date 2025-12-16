import 'package:url_launcher/url_launcher.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

/// ScanService
///
/// 承担扫码后的业务含义解析和 SDK 调用封装，避免在页面中直接调用 SDK。
class ScanService {
  /// 是否为 URL
  static bool isUrl(String code) {
    return code.startsWith('http://') || code.startsWith('https://');
  }

  /// 是否为商品链接
  static bool isProduct(String code) {
    return code.startsWith('product://');
  }

  /// 是否为活动链接
  static bool isActivity(String code) {
    return code.startsWith('activity://');
  }

  /// 在浏览器中打开 URL
  /// TODO(prod): 添加错误处理和日志
  static Future<bool> launchUrlInBrowser(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// 创建二维码扫描控制器
  /// TODO(prod): 添加权限检查
  static QRViewController createQRViewController({
    required Function(QRViewController) onCreated,
  }) {
    // 注意：QRViewController 需要通过 QRView 创建，这里返回配置
    // 实际使用中，Page 需要通过 QRView widget 来创建控制器
    throw UnimplementedError(
      'QRViewController 需要通过 QRView widget 创建，请使用 ScanService.createQRViewWidget',
    );
  }

  /// 切换手电筒
  static Future<void> toggleFlash(QRViewController? controller) async {
    if (controller != null) {
      await controller.toggleFlash();
    }
  }

  /// 获取手电筒状态
  static Future<bool?> getFlashStatus(QRViewController? controller) async {
    if (controller != null) {
      return await controller.getFlashStatus();
    }
    return false;
  }

  /// 暂停相机
  static Future<void> pauseCamera(QRViewController? controller) async {
    if (controller != null) {
      await controller.pauseCamera();
    }
  }

  /// 恢复相机
  static Future<void> resumeCamera(QRViewController? controller) async {
    if (controller != null) {
      await controller.resumeCamera();
    }
  }

  /// 处理平台相关的相机恢复逻辑
  static Future<void> handlePlatformResume(QRViewController? controller) async {
    if (Platform.isAndroid && controller != null) {
      await controller.pauseCamera();
    }
    await resumeCamera(controller);
  }
}
