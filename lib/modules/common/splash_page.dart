import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../core/storage/hive_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showIntro = false;
  int _currentPage = 0;

  final List<_IntroPageData> _pages = const [
    _IntroPageData(
      title: '多端通用壳工程',
      desc: '集成网络、存储、权限、支付、地图等常用能力，适合快速起盘。',
      icon: Icons.flutter_dash,
    ),
    _IntroPageData(
      title: '模块化 Demo 能力',
      desc: 'Crash、日志、扫码、分享、WebView、直播、实名认证一应俱全。',
      icon: Icons.widgets,
    ),
    _IntroPageData(
      title: '可直接对接生产',
      desc: '统一封装 Service/路由/状态管理，替换真实接口即可上线。',
      icon: Icons.rocket_launch,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _decideFlow();
  }

  Future<void> _decideFlow() async {
    try {
      final flag = HiveService.get('prefs', 'onboarded') as bool?;
      if (mounted) {
        setState(() {
          _showIntro = !(flag ?? false);
        });
      }
      if (flag == true) {
        _navigateToHome();
      }
    } catch (_) {
      _navigateToHome();
    }
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      // SuperHome 使用普通命名路由，避免依赖生成的 Route 类
      context.router.replaceNamed('/super-home');
    }
  }

  Future<void> _finishIntro() async {
    await HiveService.put('prefs', 'onboarded', true);
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showIntro) {
      // 保留一个简短的启动 Logo，避免白屏
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Flutter Universal Demo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finishIntro,
                child: const Text('跳过'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(page.icon, size: 120, color: Colors.blue),
                        const SizedBox(height: 24),
                        Text(
                          page.title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page.desc,
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                  width: _currentPage == index ? 10 : 6,
                  height: _currentPage == index ? 10 : 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.blue.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _finishIntro,
                  child: const Text('立即体验'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroPageData {
  final String title;
  final String desc;
  final IconData icon;

  const _IntroPageData({
    required this.title,
    required this.desc,
    required this.icon,
  });
}

