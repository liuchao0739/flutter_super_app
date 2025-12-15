import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('分享 Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () => _shareText(context, '微信'),
              icon: const Icon(Icons.chat),
              label: const Text('分享到微信（Mock）'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _shareText(context, 'QQ'),
              icon: const Icon(Icons.message),
              label: const Text('分享到QQ（Mock）'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _shareText(context, '微博'),
              icon: const Icon(Icons.article),
              label: const Text('分享到微博（Mock）'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _shareText(context, '系统分享'),
              icon: const Icon(Icons.share),
              label: const Text('系统分享'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              '分享内容示例：',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Flutter Universal Demo',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('这是一个功能完整的 Flutter Demo 应用'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => Share.share('Flutter Universal Demo\n这是一个功能完整的 Flutter Demo 应用'),
                      child: const Text('分享这段文字'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareText(BuildContext context, String platform) {
    if (platform == '系统分享') {
      Share.share('Flutter Universal Demo - 分享内容');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mock: 分享到 $platform')),
      );
    }
  }
}

