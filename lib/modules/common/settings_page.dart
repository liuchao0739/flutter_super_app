import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/painting.dart';
import '../../core/state/auth_state.dart';
import '../../core/state/theme_state.dart';
import '../../core/storage/hive_service.dart';
import '../../services/device/device_info_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);
    final themeMode = ref.watch(themeModeProvider);
    final language = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          _buildAccountSection(context, ref, auth),
          const Divider(),
          _buildAppearanceSection(ref, themeMode, language),
          const Divider(),
          _buildCacheAndUpdateSection(context),
          const Divider(),
          _buildAboutSection(context),
        ],
      ),
    );
  }

  Widget _buildAccountSection(
      BuildContext context, WidgetRef ref, AuthState auth) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(auth.isLoggedIn ? (auth.username ?? '已登录用户') : '未登录'),
          subtitle: Text(auth.isLoggedIn ? '点击可退出登录' : '点击去登录'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () async {
            if (auth.isLoggedIn) {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('退出登录'),
                  content: const Text('确定要退出当前账号吗？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('取消'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('退出'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await ref.read(authStateProvider.notifier).logout();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已退出登录')),
                  );
                }
              }
            } else {
              // 建议从 Home 入口进入登录页，这里仅提示
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('请在首页使用登录入口进行登录')),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildAppearanceSection(
    WidgetRef ref,
    ThemeMode themeMode,
    String language,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('外观与语言'),
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text('主题'),
          subtitle: Text(_themeDescription(themeMode)),
          onTap: () {
            _showThemeBottomSheet(ref);
          },
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('语言'),
          subtitle: Text(language == 'zh' ? '中文' : 'English'),
          onTap: () {
            _showLanguageBottomSheet(ref);
          },
        ),
      ],
    );
  }

  static String _themeDescription(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return '跟随系统';
      case ThemeMode.light:
        return '浅色模式';
      case ThemeMode.dark:
        return '深色模式';
    }
  }

  void _showThemeBottomSheet(WidgetRef ref) {
    showModalBottomSheet(
      context: ref.context,
      builder: (context) {
        final themeMode = ref.watch(themeModeProvider);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('跟随系统'),
              value: ThemeMode.system,
              groupValue: themeMode,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).state = value;
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('浅色模式'),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).state = value;
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('深色模式'),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).state = value;
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showLanguageBottomSheet(WidgetRef ref) {
    showModalBottomSheet(
      context: ref.context,
      builder: (context) {
        final language = ref.watch(languageProvider);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('中文'),
              value: 'zh',
              groupValue: language,
              onChanged: (value) {
                if (value != null) {
                  ref.read(languageProvider.notifier).state = value;
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: language,
              onChanged: (value) {
                if (value != null) {
                  ref.read(languageProvider.notifier).state = value;
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCacheAndUpdateSection(BuildContext context) {
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

  Widget _buildAboutSection(BuildContext context) {
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    ...app.entries.map(
                      (e) => Text('${e.key}: ${e.value}',
                          style: const TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '设备信息',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
