import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../../services/share/share_service.dart';
import '../../../services/screenshot/screenshot_service.dart';

/// 分享和截图演示页
class ShareDemoPage extends StatefulWidget {
  const ShareDemoPage({Key? key}) : super(key: key);

  @override
  State<ShareDemoPage> createState() => _ShareDemoPageState();
}

class _ShareDemoPageState extends State<ShareDemoPage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final GlobalKey _cardKey = GlobalKey();

  Future<void> _shareText() async {
    await ShareService.shareText('这是一段分享的文本内容');
  }

  Future<void> _shareProductCard() async {
    // TODO(prod): 分享商品卡片（需要生成图片）
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('TODO(prod): 生成商品卡片图片并分享')),
    );
  }

  Future<void> _captureAndShare() async {
    try {
      final imagePath = await ScreenshotService.captureAndSave(_screenshotController);
      if (imagePath != null) {
        // TODO(prod): 使用 share_plus 分享图片
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('截图已保存: $imagePath')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('截图失败')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('截图失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分享与截图'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '分享功能',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _shareText,
              icon: const Icon(Icons.share),
              label: const Text('分享文本'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _shareProductCard,
              icon: const Icon(Icons.shopping_bag),
              label: const Text('分享商品卡片'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '截图功能',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Screenshot(
              controller: _screenshotController,
              child: Card(
                key: _cardKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '订单详情',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _InfoRow(label: '订单号', value: '1234567890'),
                      _InfoRow(label: '商品', value: 'iPhone 15 Pro Max'),
                      _InfoRow(label: '数量', value: '1'),
                      _InfoRow(label: '金额', value: '¥9999.00'),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.qr_code, size: 48),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '核销码',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '1234 5678',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _captureAndShare,
              icon: const Icon(Icons.camera_alt),
              label: const Text('截图并保存'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

