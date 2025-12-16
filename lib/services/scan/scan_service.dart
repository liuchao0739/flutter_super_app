/// ScanService
///
/// 承担扫码后的业务含义解析，避免在页面中写复杂判断。
class ScanService {
  /// 是否为 URL
  static bool isUrl(String code) {
    return code.startsWith('http://') || code.startsWith('https://');
  }
}


