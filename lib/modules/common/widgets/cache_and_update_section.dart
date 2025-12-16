import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../../core/storage/hive_service.dart';

/// 存储与版本设置部分组件
class CacheAndUpdateSection extends StatelessWidget {
  const CacheAndUpdateSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('存储与版本'),
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('清除缓存'),
          subtitle: const Text('清理图片缓存与本地 Hive 数据（非关键数据）'),
          onTap: () async {
            await _clearCache();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('缓存已清理')),
              );
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.system_update),
          title: const Text('检查更新'),
          subtitle: const Text('当前为 Demo，展示强更/弱更交互'),
          onTap: () async {
            final type = await showDialog<String>(
              context: context,
              builder: (ctx) => SimpleDialog(
                title: const Text('发现新版本 1.1.0'),
                children: [
                  SimpleDialogOption(
                    onPressed: () => Navigator.pop(ctx, 'force'),
                    child: const Text('强制更新（模拟）'),
                  ),
                  SimpleDialogOption(
                    onPressed: () => Navigator.pop(ctx, 'soft'),
                    child: const Text('下次再说（弱更）'),
                  ),
                ],
              ),
            );
            if (type == 'force') {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('跳转到应用商店（Mock）')),
                );
              }
            }
          },
        ),
      ],
    );
  }

  Future<void> _clearCache() async {
    // 清理 Flutter 图片缓存
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    // 清理 Hive 中的非关键 Box（这里只演示清理一个 demoBox，可按需扩展）
    final box = HiveService.getBox('demo');
    await box?.clear();
  }
}

