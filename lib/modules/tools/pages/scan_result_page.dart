import 'package:flutter/material.dart';
import '../../../services/scan/scan_service.dart';
import 'webview_page.dart';

/// 扫码结果页
class ScanResultPage extends StatelessWidget {
  final String result;

  const ScanResultPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('扫码结果'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '扫描结果:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                result,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 24),
            // 根据结果类型显示不同操作
            if (ScanService.isUrl(result)) ...[
              _ActionButton(
                icon: Icons.open_in_browser,
                label: '在浏览器中打开',
                onTap: () async {
                  await ScanService.launchUrlInBrowser(result);
                },
              ),
              const SizedBox(height: 12),
              _ActionButton(
                icon: Icons.web,
                label: '在应用内打开',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(initialUrl: result),
                    ),
                  );
                },
              ),
            ] else if (ScanService.isProduct(result)) ...[
              _ActionButton(
                icon: Icons.shopping_bag,
                label: '查看商品',
                onTap: () {
                  // TODO: 跳转到商品详情
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('TODO: 跳转到商品详情')),
                  );
                },
              ),
            ] else if (ScanService.isActivity(result)) ...[
              _ActionButton(
                icon: Icons.event,
                label: '查看活动',
                onTap: () {
                  // TODO: 跳转到活动详情
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('TODO: 跳转到活动详情')),
                  );
                },
              ),
            ],
            const SizedBox(height: 12),
            _ActionButton(
              icon: Icons.copy,
              label: '复制',
              onTap: () {
                // TODO: 复制到剪贴板
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('已复制到剪贴板')),
                );
              },
            ),
            const SizedBox(height: 12),
            _ActionButton(
              icon: Icons.share,
              label: '分享',
              onTap: () {
                // TODO: 分享
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('TODO: 调用分享服务')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

