import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../analytics/analytics_service.dart';
import '../carousel/carousel_demo.dart';
import '../../services/payment/payment_service.dart';
import '../../routes/app_router.dart';
import '../../services/network/api_service.dart';
import '../network/mock_data.dart';
import '../demo/map_demo.dart';
import '../demo/scan_demo.dart';
import '../demo/share_demo.dart';
import '../demo/screenshot_demo.dart';
import '../demo/theme_language_demo.dart';
import '../demo/permission_demo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logPageView('HomePage');
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiService().getPosts();
      if (mounted) {
        setState(() {
          _posts = List<Map<String, dynamic>>.from(response['data'] ?? []);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Universal Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.router.push(const SettingsRoute()),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadPosts,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // 轮播图
            CarouselDemo(),
            const SizedBox(height: 10),
            
            // 功能按钮区域
            _buildSectionTitle('功能演示'),
            _buildButtonGrid(),
            
            const SizedBox(height: 20),
            
            // 列表数据展示
            _buildSectionTitle('数据列表（Mock）'),
            _isLoading
                ? const Center(child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ))
                : _buildPostsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildButtonGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.5,
      children: [
        _buildFeatureButton(
          'Crash 测试',
          Icons.bug_report,
          Colors.red,
          () {
            AnalyticsService.logEvent('feature_crash_test');
            throw Exception('Crash Test Button');
          },
        ),
        _buildFeatureButton(
          '网络请求',
          Icons.cloud,
          Colors.blue,
          () async {
            AnalyticsService.logEvent('feature_network_post');
            final response = await ApiService().postData({'test': 'data'});
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('POST 成功: ${response['message']}')),
              );
            }
          },
        ),
        _buildFeatureButton(
          'Mock 支付',
          Icons.payment,
          Colors.green,
          () {
            AnalyticsService.logEvent('feature_payment_mock');
            PaymentService.showPaymentDialog(context, '支付宝', 9.9);
          },
        ),
        _buildFeatureButton(
          '地图 Demo',
          Icons.map,
          Colors.orange,
          () {
            AnalyticsService.logEvent('feature_map_demo');
            Navigator.push(context, MaterialPageRoute(builder: (_) => MapDemoPage()));
          },
        ),
        _buildFeatureButton(
          '扫码 Demo',
          Icons.qr_code_scanner,
          Colors.purple,
          () {
            AnalyticsService.logEvent('feature_scan_demo');
            Navigator.push(context, MaterialPageRoute(builder: (_) => ScanDemoPage()));
          },
        ),
        _buildFeatureButton(
          '分享 Demo',
          Icons.share,
          Colors.teal,
          () {
            AnalyticsService.logEvent('feature_share_demo');
            Navigator.push(context, MaterialPageRoute(builder: (_) => ShareDemoPage()));
          },
        ),
        _buildFeatureButton(
          '截图 Demo',
          Icons.camera_alt,
          Colors.indigo,
          () {
            AnalyticsService.logEvent('feature_screenshot_demo');
            Navigator.push(context, MaterialPageRoute(builder: (_) => ScreenshotDemoPage()));
          },
        ),
        _buildFeatureButton(
          '主题/语言',
          Icons.palette,
          Colors.pink,
          () {
            AnalyticsService.logEvent('feature_theme_language');
            Navigator.push(context, MaterialPageRoute(builder: (_) => ThemeLanguageDemoPage()));
          },
        ),
        _buildFeatureButton(
          '权限申请',
          Icons.security,
          Colors.amber,
          () {
            AnalyticsService.logEvent('feature_permission_demo');
            Navigator.push(context, MaterialPageRoute(builder: (_) => PermissionDemoPage()));
          },
        ),
        _buildFeatureButton(
          '设置',
          Icons.settings,
          Colors.grey,
          () {
            AnalyticsService.logEvent('feature_settings');
            context.router.push(const SettingsRoute());
          },
        ),
      ],
    );
  }

  Widget _buildFeatureButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      ),
    );
  }

  Widget _buildPostsList() {
    if (_posts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('暂无数据'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(post['title'] ?? ''),
            subtitle: Text('${post['author'] ?? ''} · ${post['date'] ?? ''}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('点击了: ${post['title']}')),
              );
            },
          ),
        );
      },
    );
  }
}
