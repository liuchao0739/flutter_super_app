import 'package:flutter/material.dart';
import 'pages/webview_page.dart';
import 'pages/scan_page.dart';
import 'pages/share_demo_page.dart';

/// 超级应用 - 通用工具 / 系统能力
class SuperToolsDemoPage extends StatelessWidget {
  const SuperToolsDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工具'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ToolCard(
            icon: Icons.web,
            title: 'WebView',
            description: 'H5 容器，支持进度条、JS Bridge、错误处理',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebViewPage(),
                ),
              );
            },
          ),
          _ToolCard(
            icon: Icons.qr_code_scanner,
            title: '扫码',
            description: '二维码扫描，支持结果解析和路由分发',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScanPage(),
                ),
              );
            },
          ),
          _ToolCard(
            icon: Icons.share,
            title: '分享与截图',
            description: '系统分享、截图保存、商品卡片分享',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShareDemoPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ToolCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
