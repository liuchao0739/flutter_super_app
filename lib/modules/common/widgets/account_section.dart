import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/state/auth_state.dart';

/// 账号设置部分组件
class AccountSection extends ConsumerWidget {
  const AccountSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);

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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('请在首页使用登录入口进行登录')),
              );
            }
          },
        ),
      ],
    );
  }
}

