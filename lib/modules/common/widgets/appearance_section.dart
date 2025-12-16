import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/state/theme_state.dart';

/// 外观与语言设置部分组件
class AppearanceSection extends ConsumerWidget {
  const AppearanceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final language = ref.watch(languageProvider);

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
          onTap: () => _showThemeBottomSheet(context, ref),
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('语言'),
          subtitle: Text(language == 'zh' ? '中文' : 'English'),
          onTap: () => _showLanguageBottomSheet(context, ref),
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

  void _showThemeBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
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
                  Navigator.pop(ctx);
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
                  Navigator.pop(ctx);
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
                  Navigator.pop(ctx);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showLanguageBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
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
                  Navigator.pop(ctx);
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
                  Navigator.pop(ctx);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

