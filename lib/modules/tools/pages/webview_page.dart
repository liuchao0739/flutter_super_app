import 'package:flutter/material.dart';
import '../../../services/web/webview_service.dart';
import '../../../services/web/webview_widget_wrapper.dart';

/// WebView 页面
class WebViewPage extends StatefulWidget {
  final String? initialUrl;
  final String? htmlContent;

  const WebViewPage({
    Key? key,
    this.initialUrl,
    this.htmlContent,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late dynamic _controller; // WebViewController，通过 Service 封装避免直接导入
  double _progress = 0.0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    if (widget.initialUrl != null) {
      _controller = WebViewService.createUrlController(
        url: widget.initialUrl!,
        onProgress: (progress) {
          setState(() => _progress = progress);
        },
        onJsMessage: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('收到 JS 消息: $message')),
          );
        },
        onOpenThirdApp: (url) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('打开第三方应用'),
              content: Text('Scheme: $url\n\nTODO(prod): 调用系统 API 打开应用'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('确定'),
                ),
              ],
            ),
          );
        },
      );
    } else if (widget.htmlContent != null) {
      _controller = WebViewService.createHtmlController(
        htmlContent: widget.htmlContent!,
        onProgress: (progress) {
          setState(() => _progress = progress);
        },
        onJsMessage: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('收到 JS 消息: $message')),
          );
        },
        onOpenThirdApp: (url) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('打开第三方应用'),
              content: Text('Scheme: $url\n\nTODO(prod): 调用系统 API 打开应用'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('确定'),
                ),
              ],
            ),
          );
        },
      );
    } else {
      _controller = WebViewService.createDemoController(
        onProgress: (progress) {
          setState(() => _progress = progress);
        },
        onJsMessage: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('收到 JS 消息: $message')),
          );
        },
        onOpenThirdApp: (url) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('打开第三方应用'),
              content: Text('Scheme: $url\n\nTODO(prod): 调用系统 API 打开应用'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('确定'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => WebViewService.reload(_controller),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => WebViewService.goBack(_controller),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 使用 Service 层封装的 WebViewWidget，避免 Page 直接导入 SDK
          WebViewWidgetWrapper(controller: _controller),
          // 进度条
          if (_progress < 1.0)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.transparent,
              ),
            ),
          // 错误页
          if (_error != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('加载失败: $_error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _error = null);
                      WebViewService.reload(_controller);
                    },
                    child: const Text('重试'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
