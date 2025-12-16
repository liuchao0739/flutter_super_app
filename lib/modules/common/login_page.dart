import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/auth_state.dart';
import '../../ui/ui_utils.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入用户名和密码')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(authStateProvider.notifier).login(
            username: username,
            password: password,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('欢迎你，$username')),
      );
      context.router.replaceNamed('/super-home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登录失败：$e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => UiUtils.hideKeyboard(context),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (authState.isLoggedIn)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  '当前已登录：${authState.username}',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: '用户名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('账号密码登录'),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('验证码登录（Demo，占位）')),
                    );
                  },
                  child: const Text('验证码登录'),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('注册新账号（Demo，占位）')),
                    );
                  },
                  child: const Text('注册'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('微信登录（Mock）')),
                    );
                  },
                  icon: const Icon(Icons.wechat),
                  label: const Text('微信'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('苹果登录（Mock）')),
                    );
                  },
                  icon: const Icon(Icons.apple),
                  label: const Text('Apple'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('指纹/手势登录（Mock）')),
                    );
                  },
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('生物识别'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context.router.replaceNamed('/super-home'),
              child: const Text('先逛逛，稍后再登录'),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

