import 'package:flutter/material.dart';
import '../../../services/device/device_info_service.dart';

/// 关于设置部分组件
class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info),
      title: const Text('关于'),
      subtitle: const Text('点击查看设备与应用信息'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final app = await DeviceInfoService.getAppInfo();
        final device = await DeviceInfoService.getDeviceInfo();
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('关于本机与应用'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '应用信息',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    ...app.entries.map(
                      (e) => Text('${e.key}: ${e.value}',
                          style: const TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '设备信息',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    ...device.entries.map(
                      (e) => Text('${e.key}: ${e.value}',
                          style: const TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('关闭'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

