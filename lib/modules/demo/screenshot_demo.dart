import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ScreenshotDemoPage extends StatefulWidget {
  @override
  _ScreenshotDemoPageState createState() => _ScreenshotDemoPageState();
}

class _ScreenshotDemoPageState extends State<ScreenshotDemoPage> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _takeScreenshot() async {
    try {
      final image = await _screenshotController.capture();
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(image);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('截图已保存: $imagePath')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('截图失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('截图 Demo')),
      body: Column(
        children: [
          Screenshot(
            controller: _screenshotController,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.blue[50],
              child: Column(
                children: [
                  Icon(Icons.camera_alt, size: 80, color: Colors.blue),
                  const SizedBox(height: 20),
                  const Text(
                    '这是要截图的内容区域',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('点击下方按钮可以截取这个区域'),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('卡片内容示例'),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoItem('项目', '10'),
                              _buildInfoItem('任务', '25'),
                              _buildInfoItem('完成', '15'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _takeScreenshot,
              icon: const Icon(Icons.camera_alt),
              label: const Text('截图'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}

