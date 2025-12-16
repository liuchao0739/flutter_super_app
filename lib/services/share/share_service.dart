import 'package:share_plus/share_plus.dart';

/// ShareService
/// 
/// 统一封装分享相关能力，页面只调用这里的语义化方法，不直接依赖三方 SDK。
class ShareService {
  /// 系统原生分享文本
  static Future<void> shareText(String text) async {
    await Share.share(text);
  }
}


