import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview;

/// WebViewWidgetWrapper
///
/// 封装 WebViewWidget，避免 Page 层直接导入 webview_flutter
class WebViewWidgetWrapper extends StatelessWidget {
  final dynamic controller; // WebViewController

  const WebViewWidgetWrapper({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 将 dynamic 类型转换为 WebViewController
    if (controller is! webview.WebViewController) {
      return const Center(
        child: Text('WebView controller 类型错误'),
      );
    }
    return webview.WebViewWidget(
        controller: controller as webview.WebViewController);
  }
}
