import 'package:flutter/material.dart';

/// 超级应用 - 通用工具 / 系统能力 Demo 聚合
class SuperToolsDemoPage extends StatelessWidget {
  const SuperToolsDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通用工具 / 系统能力'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('系统级能力'),
          _FeatureRow(
            title: 'H5 容器',
            description: '嵌入网页、与原生交互，支持进度条、JS Bridge、Scheme 打开第三方应用（不再跳转旧 WebView Demo 页）。',
          ),
          _FeatureRow(
            title: '扫码系统',
            description: '二维码、条形码、商品码等统一走 ScanService，支持结果解析与路由分发（仅保留能力说明）。',
          ),
          _FeatureRow(
            title: '分享能力',
            description: '统一 ShareService 封装多平台分享与分享卡片定制，此处不再打开旧 Share Demo。',
          ),
          _FeatureRow(
            title: '文件与截图',
            description: '支持文件预览、下载、保存与局部截图，截图能力由 ScreenshotService 提供（不再进入截图 Demo 页）。',
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('地图与位置'),
          _FeatureRow(
            title: '地图服务',
            description: '定位、导航、地点标记，统一通过 MapService 管理地图 SDK 调用（不再单独跳转 Map Demo 页面）。',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String title;
  final String description;
  final Widget? action;

  const _FeatureRow({
    Key? key,
    required this.title,
    required this.description,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
            if (action != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: action!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
