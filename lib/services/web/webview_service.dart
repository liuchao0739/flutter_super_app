import 'package:webview_flutter/webview_flutter.dart';

/// WebViewService
///
/// 封装 WebView 相关配置与交互，确保页面层不直接操作 SDK 细节。
class WebViewService {
  static const String demoHtml = _html;

  /// 创建用于 Demo 的 [WebViewController]，并通过回调把事件抛给页面。
  static WebViewController createDemoController({
    required void Function(double progress) onProgress,
    required void Function(String message) onJsMessage,
    required void Function(String url) onOpenThirdApp,
  }) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => onProgress(p / 100),
          onNavigationRequest: (request) {
            if (request.url.startsWith('myapp://')) {
              onOpenThirdApp(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'App',
        onMessageReceived: (message) => onJsMessage(message.message),
      )
      ..loadHtmlString(demoHtml);
  }

  /// 创建用于加载 URL 的控制器
  static WebViewController createUrlController({
    required String url,
    required void Function(double progress) onProgress,
    required void Function(String message) onJsMessage,
    required void Function(String url) onOpenThirdApp,
  }) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => onProgress(p / 100),
          onNavigationRequest: (request) {
            if (request.url.startsWith('myapp://')) {
              onOpenThirdApp(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'App',
        onMessageReceived: (message) => onJsMessage(message.message),
      )
      ..loadRequest(Uri.parse(url));
  }

  /// 创建用于加载 HTML 内容的控制器
  static WebViewController createHtmlController({
    required String htmlContent,
    required void Function(double progress) onProgress,
    required void Function(String message) onJsMessage,
    required void Function(String url) onOpenThirdApp,
  }) {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => onProgress(p / 100),
          onNavigationRequest: (request) {
            if (request.url.startsWith('myapp://')) {
              onOpenThirdApp(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'App',
        onMessageReceived: (message) => onJsMessage(message.message),
      )
      ..loadHtmlString(htmlContent);
  }

  /// 检查是否可以返回
  static Future<bool> canGoBack(WebViewController controller) async {
    return await controller.canGoBack();
  }

  /// 返回上一页
  static Future<void> goBack(WebViewController controller) async {
    if (await canGoBack(controller)) {
      await controller.goBack();
    }
  }

  /// 重新加载
  static Future<void> reload(WebViewController controller) async {
    await controller.reload();
  }
}

// 内嵌 H5 内容
const String _html = '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>WebView Demo</title>
    <style>
      body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; padding: 16px; }
      button { padding: 8px 16px; margin: 8px 0; }
      a { color: #1976d2; }
    </style>
  </head>
  <body>
    <h2>Flutter WebView Demo</h2>
    <p>这是一个内嵌的 H5 页面，用于演示和 Flutter 的交互。</p>
    <button onclick="App.postMessage('来自 H5 的问候 👋')">发送消息给 Flutter</button><br/>
    <a href="myapp://open/otherApp">打开第三方应用（Mock Scheme）</a>
  </body>
</html>
''';
